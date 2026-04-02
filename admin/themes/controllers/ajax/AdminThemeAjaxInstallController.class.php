<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Sebastien LARTIGUE <babsolune@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 03 29
 * @since       PHPBoost 6.1 - 2026 03 29
*/

class AdminThemeAjaxInstallController extends AbstractController
{
	public function execute(HTTPRequestCustom $request)
	{
		if (!AppContext::get_current_user()->check_level(User::ADMINISTRATOR_LEVEL))
			return new JSONResponse(['results' => [], 'error' => 'Unauthorized']);

		AppContext::get_session()->csrf_post_protect();

		$phpboost_version = GeneralConfig::load()->get_phpboost_major_version();
		$github_token     = AddonsConfig::load()->get_github_token();

		$source     = $request->get_poststring('source', '');
		$addon_ids  = $request->get_postarray('addon_ids', []);
		$owner      = $request->get_poststring('repo_owner', '');
		$repo       = $request->get_poststring('repo_name', '');
		$subdir     = $request->get_poststring('repo_dir', '');
		$server_url = $request->get_poststring('server_url', '');
		$server_dir = $request->get_poststring('server_dir', '');

		$results = [];
		foreach ($addon_ids as $raw_id)
		{
			$addon_id = preg_replace('/[^A-Za-z0-9_-]/', '', $raw_id);
			if (empty($addon_id)) continue;

			if ($source === 'github')
				$results[$addon_id] = $this->install_from_github($addon_id, $owner, $repo, $subdir, $phpboost_version, $github_token);
			else
				$results[$addon_id] = $this->install_from_website($addon_id, $server_url, $server_dir, $phpboost_version);
		}

		return new JSONResponse(['results' => $results]);
	}

	private function install_from_github($addon_id, $owner, $repo, $subdir, $version, $token)
	{
		$templates_folder = PATH_TO_ROOT . '/templates/';
		if (!is_writable($templates_folder) && !@chmod($templates_folder, 0755))
			return ['success' => false, 'msg_key' => 'warning.process.error'];
		if (ThemesManager::get_theme_existed($addon_id))
			return ['success' => false, 'msg_key' => 'addon.themes.already.installed'];

		$branch       = AddonRemoteHelper::resolve_github_branch($owner, $repo, $version, $token);
		$path         = trim($subdir, '/');
		$addon_prefix = $repo . '-' . $branch . '/' . ($path !== '' ? $path . '/' : '') . $addon_id . '/';

		$ok = AddonRemoteHelper::download_and_extract_from_github($owner, $repo, $branch, $addon_prefix, $templates_folder . $addon_id . '/', $token);
		if (!$ok)
			return ['success' => false, 'msg_key' => 'addon.warning.download.error'];

		return $this->do_install($addon_id);
	}

	private function install_from_website($addon_id, $server_url, $server_dir, $version)
	{
		$templates_folder = PATH_TO_ROOT . '/templates/';
		if (!is_writable($templates_folder) && !@chmod($templates_folder, 0755))
			return ['success' => false, 'msg_key' => 'warning.process.error'];
		if (ThemesManager::get_theme_existed($addon_id))
			return ['success' => false, 'msg_key' => 'addon.themes.already.installed'];

		list($base_url) = AddonRemoteHelper::fetch_server_index($server_url, $server_dir, $version, 'templates');
		if (empty($base_url))
			return ['success' => false, 'msg_key' => 'addon.warning.download.error'];

		$zip_content = AddonRemoteHelper::curl_get($base_url . '/' . rawurlencode($addon_id) . '/' . rawurlencode($addon_id) . '.zip', [], 60);
		if ($zip_content === false)
			return ['success' => false, 'msg_key' => 'addon.warning.download.error'];

		$dest = $templates_folder . $addon_id . '/';
		$ok   = AddonRemoteHelper::extract_zip_prefix_to($zip_content, $addon_id . '/', $dest);
		if (!$ok)
			$ok = AddonRemoteHelper::extract_zip_prefix_to($zip_content, '', $dest);
		if (!$ok)
			return ['success' => false, 'msg_key' => 'warning.invalid.archive.content'];

		return $this->do_install($addon_id);
	}

	private function do_install($addon_id)
	{
		$authorizations = Authorizations::auth_array_simple(Theme::ACCES_THEME, $addon_id);
		ThemesManager::install($addon_id, $authorizations);
		$error = ThemesManager::get_error();
		if ($error !== null)
			return ['success' => false, 'msg_key' => 'warning.process.error'];

		$theme = ThemesManager::get_theme($addon_id);
		HooksService::execute_hook_typed_action('install', 'theme', $addon_id, array_merge(
			['title' => $theme->get_configuration()->get_name(), 'url' => AdminThemeUrlBuilder::list_installed_theme()->rel()],
			$theme->get_configuration()->get_properties()
		));
		return ['success' => true, 'msg_key' => 'warning.process.success'];
	}
}
?>
