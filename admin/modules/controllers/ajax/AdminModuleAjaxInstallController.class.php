<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Sebastien LARTIGUE <babsolune@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 03 29
 * @since       PHPBoost 6.1 - 2026 03 29
*/

class AdminModuleAjaxInstallController extends AbstractController
{
    private $lang;

    public function __construct()
    {
        $this->lang = LangLoader::get_all_langs();
    }

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

		ClassLoader::generate_classlist(true);
		return new JSONResponse(['results' => $results]);
	}

	private function install_from_github($addon_id, $owner, $repo, $subdir, $version, $token)
	{
		$modules_folder = PATH_TO_ROOT . '/modules/';
		if (!is_writable($modules_folder) && !@chmod($modules_folder, 0755))
			return ['success' => false, 'msg_key' => $this->lang['warning.process.error']];
		if (ModulesManager::is_module_installed($addon_id))
			return ['success' => false, 'msg_key' => $this->lang['addon.modules.already.installed']];

		$branch       = AddonRemoteHelper::resolve_github_branch($owner, $repo, $version, $token);
		$path         = trim($subdir, '/');
		$addon_prefix = $repo . '-' . $branch . '/' . ($path !== '' ? $path . '/' : '') . $addon_id . '/';

		$ok = AddonRemoteHelper::download_and_extract_from_github($owner, $repo, $branch, $addon_prefix, $modules_folder . $addon_id . '/', $token);
		if (!$ok)
			return ['success' => false, 'msg_key' => $this->lang['addon.warning.download.error']];

		return $this->do_install($addon_id);
	}

	private function install_from_website($addon_id, $server_url, $server_dir, $version)
	{
		$modules_folder = PATH_TO_ROOT . '/modules/';
		if (!is_writable($modules_folder) && !@chmod($modules_folder, 0755))
			return ['success' => false, 'msg_key' => $this->lang['warning.process.error']];
		if (ModulesManager::is_module_installed($addon_id))
			return ['success' => false, 'msg_key' => $this->lang['addon.modules.already.installed']];

		list($base_url) = AddonRemoteHelper::fetch_website_index($server_url, $server_dir, $version, 'modules');
		if (empty($base_url))
			return ['success' => false, 'msg_key' => $this->lang['addon.warning.download.error']];

		$zip_content = AddonRemoteHelper::curl_get($base_url . '/' . rawurlencode($addon_id) .'/' . rawurlencode($addon_id) . '.zip', [], 60);
		if ($zip_content === false)
			return ['success' => false, 'msg_key' => $this->lang['addon.warning.download.error']];

		$dest = $modules_folder . $addon_id . '/';
		$ok   = AddonRemoteHelper::extract_zip_prefix_to($zip_content, $addon_id . '/', $dest);
		if (!$ok)
			$ok = AddonRemoteHelper::extract_zip_prefix_to($zip_content, '', $dest);
		if (!$ok)
			return ['success' => false, 'msg_key' => 'warning.invalid.archive.content'];

		return $this->do_install($addon_id);
	}

	private function do_install($addon_id)
	{
		ClassLoader::generate_classlist(true);
		switch (ModulesManager::install_module($addon_id))
		{
			case ModulesManager::CONFIG_CONFLICT:          return ['success' => false, 'msg_key' => $this->lang['addon.modules.config.conflict']];
			case ModulesManager::UNEXISTING_MODULE:        return ['success' => false, 'msg_key' => $this->lang['warning.element.unexists']];
			case ModulesManager::MODULE_ALREADY_INSTALLED: return ['success' => false, 'msg_key' => $this->lang['addon.modules.already.installed']];
			case ModulesManager::PHP_VERSION_CONFLICT:     return ['success' => false, 'msg_key' => $this->lang['warning.misfit.php']];
			case ModulesManager::PHPBOOST_VERSION_CONFLICT:return ['success' => false, 'msg_key' => $this->lang['warning.misfit.phpboost']];
			case ModulesManager::MODULE_INSTALLED:
			default:
				$module = ModulesManager::get_module($addon_id);
				HooksService::execute_hook_typed_action('install', 'module', $addon_id, array_merge(
					['title' => $module->get_configuration()->get_name(), 'url' => AdminModulesUrlBuilder::list_installed_modules()->rel()],
					$module->get_configuration()->get_properties()
				));
				return ['success' => true, 'msg_key' => $this->lang['warning.process.success']];
		}
	}
}
?>
