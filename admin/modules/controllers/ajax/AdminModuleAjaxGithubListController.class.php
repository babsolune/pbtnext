<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Sebastien LARTIGUE <babsolune@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 04 06
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
		$force  = $request->get_getbool('refresh', false); // ?refresh=1 vide le cache

		if (empty($owner) || empty($repo))
			return new JSONResponse(['addons' => [], 'error' => 'missing_params']);

		// Résolution de la branche (un seul appel API)
		$branch = AddonRemoteHelper::resolve_github_branch($owner, $repo, $phpboost_version, $github_token);

		// Récupération de l'index centralisé (avec cache)
		$index = AddonRemoteHelper::fetch_github_index_json($owner, $repo, $subdir, $branch, $github_token, 'modules.json', $force);

		if ($index === null)
			return new JSONResponse(['addons' => [], 'error' => 'api_unreachable', 'branch' => $branch]);

		$locale   = AppContext::get_current_user()->get_locale();
		$raw_base = 'https://raw.githubusercontent.com/' . $owner . '/' . $repo . '/' . $branch . '/';
		$path     = trim($subdir, '/');

		$addons = [];
		foreach ($index as $entry)
		{
			// Filtre : uniquement les modules
			if (!isset($entry['addon_type']) || $entry['addon_type'] !== 'module')
				continue;

			$addon_id = $entry['id'] ?? '';
			if (empty($addon_id))
				continue;

			// Résolution du nom localisé (français > anglais > id)
			$name  = $this->resolve_locale_field($entry, 'name',        $locale, $addon_id);
			$desc  = $this->resolve_locale_field($entry, 'description', $locale, '');
			$genre = $this->resolve_locale_field($entry, 'genre',       $locale, '');

			// Vignette : champ thumbnail dans le JSON, sinon on tente le chemin standard
			$thumbnail = null;
			if (!empty($entry['thumbnail']))
			{
				$thumbnail = $entry['thumbnail'];
			}
			else
			{
				$thumb_path = ($path !== '' ? $path . '/' : '') . $addon_id . '/' . $addon_id . '.png';
				$thumb_url  = $raw_base . $thumb_path;
				if (AddonRemoteHelper::remote_file_exists($thumb_url))
					$thumbnail = $thumb_url;
			}

			$addons[] = [
				'id'            => $addon_id,
				'name'          => $name,
				'genre'         => $genre,
				'compatibility' => $entry['compatibility'] ?? '',
				'version'       => $entry['version']       ?? '',
				'author'        => $entry['author']        ?? '',
				'author_mail'   => $entry['author_mail']   ?? '',
				'author_website'=> $entry['author_website']?? '',
				'description'   => $desc,
				'creation_date' => $entry['creation_date'] ?? '',
				'last_update'   => $entry['last_update']   ?? '',
				'php_version'   => $entry['php_version']   ?? '',
				'fa_icon'       => $entry['fa_icon']        ?? '',
				'hexa_icon'     => $entry['hexa_icon']      ?? '',
				'compatible'    => ($entry['compatibility'] ?? '') === $phpboost_version,
				'installed'     => ModulesManager::is_module_installed($addon_id),
				'thumbnail'     => $thumbnail,
				'repo_url'      => 'https://github.com/' . $owner . '/' . $repo
					. '/tree/' . $branch . '/' . ($path !== '' ? $path . '/' : '') . $addon_id,
			];
		}

		usort($addons, ['self', 'sort_by_name']);

		return new JSONResponse([
			'addons'  => $addons,
			'error'   => null,
			'branch'  => $branch,
			'cached'  => !$force,
		]);
	}

	/**
	 * Résout un champ multilingue du JSON.
	 *
	 * Le champ peut être :
	 *   - une chaîne simple            → retournée directement
	 *   - un tableau ['fr' => …, …]    → locale courante, puis 'english', puis première valeur
	 *
	 * @param array  $entry    Entrée issue de modules.json
	 * @param string $field    Nom du champ (ex : 'name', 'description', 'genre')
	 * @param string $locale   Locale de l'utilisateur (ex : 'french')
	 * @param string $default  Valeur par défaut si rien n'est trouvé
	 */
	private function resolve_locale_field(array $entry, string $field, string $locale, string $default): string
	{
		if (!isset($entry[$field]))
			return $default;

		$value = $entry[$field];

		if (is_string($value))
			return $value;

		if (is_array($value))
		{
			if (isset($value[$locale]))       return $value[$locale];
			if (isset($value['english']))     return $value['english'];
			$first = reset($value);
			return is_string($first) ? $first : $default;
		}

		return $default;
	}

	private static function sort_by_name($a, $b)
	{
		return strcasecmp($a['name'], $b['name']);
	}
}
?>
