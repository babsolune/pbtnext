<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Sebastien LARTIGUE <babsolune@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 03 29
 * @since       PHPBoost 6.1 - 2026 03 29
*/

class AdminLangAjaxWebsiteListController extends AbstractController
{
	public function execute(HTTPRequestCustom $request)
	{
		if (!AppContext::get_current_user()->check_level(User::ADMINISTRATOR_LEVEL))
			return new JSONResponse(['addons' => [], 'error' => 'Unauthorized']);

		$phpboost_version = GeneralConfig::load()->get_phpboost_major_version();
		$server_url       = $request->get_getstring('server_url', '');
		$server_dir       = $request->get_getstring('server_dir', '');

		if (empty($server_url))
			return new JSONResponse(['addons' => [], 'error' => 'missing_params']);

		list($base_url, $index) = AddonRemoteHelper::fetch_server_index($server_url, $server_dir, $phpboost_version, 'langs');

		if (empty($index))
			return new JSONResponse(['addons' => [], 'error' => null]);

		$addons = [];
		foreach ($index as $item)
		{
			$addon_id = isset($item['id']) ? $item['id'] : '';
			if (empty($addon_id) || (isset($item['addon_type']) ? $item['addon_type'] : '') !== 'lang')
				continue;

			$addons[] = [
				'id'            => $addon_id,
				'name'          => isset($item['name'])          ? $item['name']          : $addon_id,
				'compatibility' => isset($item['compatibility']) ? $item['compatibility'] : '',
				'version'       => isset($item['version'])       ? $item['version']       : '',
				'author'        => isset($item['author_name'])   ? $item['author_name']   : (isset($item['author']) ? $item['author'] : ''),
				'description'   => isset($item['description'])  ? $item['description']   : '',
				'compatible'    => (isset($item['compatibility']) ? $item['compatibility'] : '') === $phpboost_version,
				'installed'     => LangsManager::get_lang_existed($addon_id),
				'thumbnail'     => !empty($item['thumbnail']) ? $base_url . '/' . $addon_id . '/' . $item['thumbnail'] : '',
			];
		}

		usort($addons, ['self', 'sort_by_name']);
		return new JSONResponse(['addons' => $addons, 'error' => null]);
	}

	private static function sort_by_name($a, $b)
	{
		return strcasecmp($a['name'], $b['name']);
	}
}
?>
