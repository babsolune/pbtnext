<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Sebastien LARTIGUE <babsolune@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 03 29
 * @since       PHPBoost 6.1 - 2026 03 29
*/

class AdminModuleAjaxGithubListController extends AbstractController
{
	public function execute(HTTPRequestCustom $request)
	{
		if (!AppContext::get_current_user()->check_level(User::ADMINISTRATOR_LEVEL))
			return new JSONResponse(['addons' => [], 'error' => 'Unauthorized']);

		$addons_config    = AddonsConfig::load();
		$phpboost_version = GeneralConfig::load()->get_phpboost_major_version();
		$github_token     = $addons_config->get_github_token();

		$owner  = $request->get_getstring('repo_owner', '');
		$repo   = $request->get_getstring('repo_name', '');
		$subdir = $request->get_getstring('repo_dir', '');

		if (empty($owner) || empty($repo))
			return new JSONResponse(['addons' => [], 'error' => 'missing_params']);

		$branch = AddonRemoteHelper::resolve_github_branch($owner, $repo, $phpboost_version, $github_token);
		$path   = trim($subdir, '/');
		$dirs   = AddonRemoteHelper::github_list_dirs($owner, $repo, $path, $branch, $github_token);

		if ($dirs === null)
			return new JSONResponse(['addons' => [], 'error' => 'api_unreachable']);

		$addons   = [];
		$raw_base = 'https://raw.githubusercontent.com/' . $owner . '/' . $repo . '/' . $branch . '/';

		foreach ($dirs as $item)
		{
			$locale      = AppContext::get_current_user()->get_locale();
			$addon_id    = $item['name'];
			$config_path = ($path !== '' ? $path . '/' : '') . $addon_id . '/config.ini';
			$desc_path   = ($path !== '' ? $path . '/' : '') . $addon_id . '/lang/' . $locale . '/desc.ini';

            $config      = AddonRemoteHelper::github_read_config_ini($owner, $repo, $config_path, $branch, $github_token);
			if (empty($config) || (isset($config['addon_type']) ? $config['addon_type'] : '') !== 'module')
				continue;

            $desc = AddonRemoteHelper::github_read_config_ini($owner, $repo, $desc_path, $branch, $github_token);
            if (empty($desc) || (isset($config['addon_type']) ? $config['addon_type'] : '') !== 'module')
                $desc = AddonRemoteHelper::github_read_config_ini($owner, $repo,
                    ($path !== '' ? $path . '/' : '') . $addon_id . '/lang/english/desc.ini',
                    $branch, $github_token
                );

			$thumb_path = ($path !== '' ? $path . '/' : '') . $addon_id . '/' . $addon_id . '.png';
			$addons[] = [
				'id'            => $addon_id,
				'name'          => isset($desc['name'])             ? $desc['name']            : $addon_id,
				'genre'         => isset($desc['genre'])            ? $desc['genre']           : $addon_id,
				'compatibility' => isset($config['compatibility'])  ? $config['compatibility'] : '',
				'version'       => isset($config['version'])        ? $config['version']       : '',
				'author'        => isset($config['author'])         ? $config['author']        : '',
				'description'   => isset($desc['desc'])             ? $desc['desc']            : '',
				'compatible'    => (isset($config['compatibility']) ? $config['compatibility'] : '') === $phpboost_version,
				'fa_icon'       => isset($config['fa_icon'])        ? $config['fa_icon']       : '',
				'installed'     => ModulesManager::is_module_installed($addon_id),
				'thumbnail'     => AddonRemoteHelper::remote_file_exists($raw_base . $thumb_path) ? $raw_base . $thumb_path : null,
				'repo_url'      => 'https://github.com/' . $owner . '/' . $repo . '/tree/' . $branch . '/' . ($path !== '' ? $path . '/' : '') . $addon_id,
			];
		}

		usort($addons, ['self', 'sort_by_name']);
		return new JSONResponse(['addons' => $addons, 'error' => null, 'branch' => $branch]);
	}

	private static function sort_by_name($a, $b)
	{
		return strcasecmp($a['name'], $b['name']);
	}
}
?>
