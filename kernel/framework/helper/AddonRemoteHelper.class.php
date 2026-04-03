<?php
/**
 * Static helper for fetching remote addon lists via cURL.
 *
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Sebastien LARTIGUE <babsolune@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 03 29
 * @since       PHPBoost 6.1 - 2026 03 29
*/

class AddonRemoteHelper
{
	public static function curl_get($url, $extra_headers = [], $timeout = 15)
	{
		if (!function_exists('curl_init'))
			return false;

		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL,            $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_setopt($ch, CURLOPT_MAXREDIRS,      5);
		curl_setopt($ch, CURLOPT_TIMEOUT,        $timeout);
		curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
		curl_setopt($ch, CURLOPT_USERAGENT,      'PHPBoost/' . GeneralConfig::load()->get_phpboost_major_version());
		curl_setopt($ch, CURLOPT_ENCODING,       '');
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
		curl_setopt($ch, CURLOPT_HTTPHEADER,     array_merge(['Accept: application/json'], $extra_headers));

		$body = curl_exec($ch);
		$http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
		$err  = curl_error($ch);
		curl_close($ch);

		if ($body === false || !empty($err) || $http < 200 || $http >= 300)
			return false;

		return $body;
	}

    public static function remote_file_exists(string $url): bool
    {
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_NOBODY, true);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 5);
		curl_setopt($ch, CURLOPT_USERAGENT, 'PHPBoost/' . GeneralConfig::load()->get_phpboost_major_version());
        curl_exec($ch);

        $http_code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        return $http_code >= 200 && $http_code < 300;
    }

	public static function curl_get_json($url, $extra_headers = [], $timeout = 15)
	{
		$raw = self::curl_get($url, $extra_headers, $timeout);
		if ($raw === false)
			return null;
		$decoded = json_decode($raw, true);
		return is_array($decoded) ? $decoded : null;
	}

	public static function github_headers($token)
	{
		$headers = ['Accept: application/vnd.github.v3+json'];
		if (!empty($token))
			$headers[] = 'Authorization: token ' . $token;
		return $headers;
	}

	public static function resolve_github_branch($owner, $repo, $version, $token)
	{
		$url      = 'https://api.github.com/repos/' . $owner . '/' . $repo . '/branches';
		$branches = self::curl_get_json($url, self::github_headers($token));
		if (is_array($branches))
		{
			$names = array_column($branches, 'name');
			if (in_array($version, $names)) return $version;
			if (in_array('master', $names)) return 'master';
			if (in_array('main',   $names)) return 'main';
		}
		return 'master';
	}

	public static function github_list_dirs($owner, $repo, $path, $branch, $token)
	{
		$encoded = $path !== '' ? implode('/', array_map('rawurlencode', explode('/', $path))) : '';
		$url     = 'https://api.github.com/repos/' . $owner . '/' . $repo . '/contents/' . $encoded . '?ref=' . rawurlencode($branch);
		$data    = self::curl_get_json($url, self::github_headers($token));
		if (!is_array($data))
			return null;
		$dirs = [];
		foreach ($data as $item)
		{
			if (isset($item['type']) && $item['type'] === 'dir')
				$dirs[] = $item;
		}
		return $dirs;
	}

	public static function github_read_config_ini($owner, $repo, $path, $branch, $token)
	{
		$encoded = implode('/', array_map('rawurlencode', explode('/', $path)));
		$url     = 'https://api.github.com/repos/' . $owner . '/' . $repo . '/contents/' . $encoded . '?ref=' . rawurlencode($branch);
		$data    = self::curl_get_json($url, self::github_headers($token));
		if (!is_array($data) || empty($data['content']))
			return [];
		$ini    = base64_decode(str_replace("\n", '', $data['content']));
		$parsed = @parse_ini_string($ini);
		return is_array($parsed) ? $parsed : [];
	}

	public static function fetch_server_index($server_url, $directory, $version, $addon_folder)
	{
		$base = rtrim($server_url, '/');
		if (!empty($directory))
			$base .= '/' . trim($directory, '/');

        $real_version = $version === GeneralConfig::load()->get_phpboost_major_version() ? $version : '/dev/';

		$versioned = $base . '/' . $real_version . '/' . $addon_folder;
		$data      = self::curl_get_json($versioned . '/addons.json');
		if (is_array($data))
			return [$versioned, $data];

		$dev  = $base . '/dev/' . $addon_folder;
		$data = self::curl_get_json($dev . '/addons.json');
		if (is_array($data))
			return [$dev, $data];

		return ['', []];
	}

	public static function download_and_extract_from_github($owner, $repo, $branch, $addon_prefix, $dest_dir, $token)
	{
		$zip_url = 'https://github.com/' . $owner . '/' . $repo . '/archive/refs/heads/' . rawurlencode($branch) . '.zip';
		$headers = [];
		if (!empty($token))
			$headers[] = 'Authorization: token ' . $token;
		$content = self::curl_get($zip_url, $headers, 60);
		if ($content === false)
			return false;
		return self::extract_zip_prefix_to($content, $addon_prefix, $dest_dir);
	}

	public static function extract_zip_prefix_to($zip_binary, $prefix, $dest_dir)
	{
		$tmp = tempnam(sys_get_temp_dir(), 'pbt_addon_') . '.zip';
		file_put_contents($tmp, $zip_binary);
		$zip = new ZipArchive();
		if ($zip->open($tmp) !== true)
		{
			@unlink($tmp);
			return false;
		}
		$extracted = false;
		for ($i = 0; $i < $zip->numFiles; $i++)
		{
			$stat     = $zip->statIndex($i);
			$name     = $stat['name'];
			if ($prefix !== '' && strpos($name, $prefix) !== 0)
				continue;
			$relative = $prefix !== '' ? substr($name, strlen($prefix)) : $name;
			if ($relative === '' || $relative === '/')
				continue;
			$target = $dest_dir . $relative;
			if (substr($name, -1) === '/')
			{
				@mkdir($target, 0755, true);
			}
			else
			{
				@mkdir(dirname($target), 0755, true);
				$stream = $zip->getStream($name);
				if ($stream !== false)
				{
					file_put_contents($target, stream_get_contents($stream));
					fclose($stream);
					$extracted = true;
				}
			}
		}
		$zip->close();
		@unlink($tmp);
		if ($extracted)
			self::apply_permissions($dest_dir, 0755);
		return $extracted;
	}

	public static function apply_permissions($path, $mode)
	{
		@chmod($path, $mode);
		if (is_dir($path))
		{
			foreach (scandir($path) as $item)
			{
				if ($item === '.' || $item === '..')
					continue;
				self::apply_permissions($path . '/' . $item, $mode);
			}
		}
	}
}
?>
