<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 07
 * @since       PHPBoost 6.0 - 2026 03 07
 *
 * Ajax endpoint for the Lang Review tab.
 * action=analyze&module=xxx  → returns unused keys + duplicates
 * action=modules             → returns list of installed modules
 */

require_once PATH_TO_ROOT . '/modules/devtools/services/DevToolsAuthorizationsService.class.php';

class DevToolsAjaxLangController extends AbstractController
{
    public function execute(HTTPRequestCustom $request)
    {
        if (!DevToolsAuthorizationsService::check_authorizations()->moderation())
            return new JSONResponse(array('success' => false, 'error' => 'Unauthorized'), 403);

        $action = $request->get_string('action', '');

        switch ($action)
        {
            case 'modules':
                return $this->action_modules();

            case 'analyze':
                return $this->action_analyze($request);

            default:
                return new JSONResponse(array('success' => false, 'error' => 'Unknown action'));
        }
    }

    // -------------------------------------------------------------------------
    // action=modules — list installed modules that have a lang folder
    // -------------------------------------------------------------------------
    private function action_modules()
    {
        $modules = array();
        $modules_path = PATH_TO_ROOT . '/modules';

        if (!is_dir($modules_path))
            return new JSONResponse(array('success' => true, 'modules' => array(), 'debug' => 'modules dir not found: ' . $modules_path));

        $entries = @scandir($modules_path);
        if (!$entries)
            return new JSONResponse(array('success' => true, 'modules' => array(), 'debug' => 'scandir failed'));

        foreach ($entries as $entry)
        {
            if ($entry === '.' || $entry === '..') continue;
            $lang_file = $modules_path . '/' . $entry . '/lang/french/common.php';
            if (is_file($lang_file))
                $modules[] = $entry;
        }

        sort($modules);
        return new JSONResponse(array('success' => true, 'modules' => $modules));
    }

    // -------------------------------------------------------------------------
    // action=analyze&module=xxx
    // -------------------------------------------------------------------------
    private function action_analyze(HTTPRequestCustom $request)
    {
        $module = $request->get_string('module', '');
        if (!$module || !preg_match('`^[a-z0-9_-]+$`i', $module))
            return new JSONResponse(array('success' => false, 'error' => 'Invalid module'));

        $module_path = PATH_TO_ROOT . '/modules/' . $module;
        if (!is_dir($module_path))
            return new JSONResponse(array('success' => false, 'error' => 'Module not found'));

        // 1. Extract keys from both lang files
        $keys_fr = $this->extract_lang_keys($module_path . '/lang/french/common.php');
        $keys_en = $this->extract_lang_keys($module_path . '/lang/english/common.php');

        // Merge: union of both lang files
        $all_lang_keys = array();
        foreach ($keys_fr as $k => $v) $all_lang_keys[$k] = array('fr' => $v, 'en' => isset($keys_en[$k]) ? $keys_en[$k] : null);
        foreach ($keys_en as $k => $v)
            if (!isset($all_lang_keys[$k])) $all_lang_keys[$k] = array('fr' => null, 'en' => $v);

        if (empty($all_lang_keys))
            return new JSONResponse(array('success' => false, 'error' => 'No lang keys found'));

        // 2. Scan all .php + .tpl files in the module for key usage
        $source_files = $this->scan_source_files($module_path);
        $source_content = implode("\n", $source_files);

        // 3. Find unused keys
        $unused = array();
        foreach ($all_lang_keys as $key => $values)
        {
            if (!$this->is_key_used($key, $source_content))
                $unused[] = array(
                    'key' => $key,
                    'fr'  => $values['fr'],
                    'en'  => $values['en'],
                );
        }

        // 4. Find duplicates within this module (same value, different key)
        $duplicates_internal = $this->find_internal_duplicates($keys_fr, $keys_en);

        // 5. Find duplicates across all modules
        $duplicates_external = $this->find_external_duplicates($keys_fr, $module);

        return new JSONResponse(array(
            'success'              => true,
            'module'               => $module,
            'total_keys'           => count($all_lang_keys),
            'unused'               => $unused,
            'duplicates_internal'  => $duplicates_internal,
            'duplicates_external'  => $duplicates_external,
        ));
    }

    // -------------------------------------------------------------------------
    // Extract $lang['key'] = 'value' from a PHP lang file
    // -------------------------------------------------------------------------
    private function extract_lang_keys($file_path)
    {
        $keys = array();
        if (!is_file($file_path)) return $keys;

        $content = file_get_contents($file_path);
        // Match $lang['key'] = 'value'; or $lang['key'] = "value";
        preg_match_all('`\$lang\[\'([^\']+)\'\]\s*=\s*(?:\'((?:[^\'\\\\]|\\\\.)*)\'|"((?:[^"\\\\]|\\\\.)*)")\s*;`', $content, $matches, PREG_SET_ORDER);

        foreach ($matches as $m)
        {
            $key   = $m[1];
            $value = isset($m[3]) && $m[3] !== '' ? $m[3] : $m[2];
            $keys[$key] = $value;
        }

        return $keys;
    }

    // -------------------------------------------------------------------------
    // Scan all .php and .tpl files in a module directory, return array of contents
    // -------------------------------------------------------------------------
    private function scan_source_files($module_path)
    {
        $contents = array();
        $iterator = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($module_path, RecursiveDirectoryIterator::SKIP_DOTS)
        );

        foreach ($iterator as $file)
        {
            $ext = strtolower(pathinfo($file->getFilename(), PATHINFO_EXTENSION));
            if (!in_array($ext, array('php', 'tpl'))) continue;
            // Skip lang files themselves
            if (strpos($file->getPathname(), '/lang/') !== false) continue;

            $c = @file_get_contents($file->getPathname());
            if ($c !== false) $contents[] = $c;
        }

        return $contents;
    }

    // -------------------------------------------------------------------------
    // Check if a lang key is referenced anywhere in source content
    // PHPBoost patterns:
    //   {@key} in .tpl
    //   $this->lang['key'] in .php
    //   LangLoader::get_message('key', ...) in .php
    // -------------------------------------------------------------------------
    private function is_key_used($key, $source_content)
    {
        // {@key} — tpl pattern
        if (strpos($source_content, '{@' . $key . '}') !== false) return true;
        // $lang['key'] or $this->lang['key']
        if (strpos($source_content, "lang['" . $key . "']") !== false) return true;
        // LangLoader::get_message('key'
        if (strpos($source_content, "get_message('" . $key . "'") !== false) return true;

        return false;
    }

    // -------------------------------------------------------------------------
    // Find keys with identical values within the same module (fr or en)
    // -------------------------------------------------------------------------
    private function find_internal_duplicates($keys_fr, $keys_en)
    {
        $duplicates = array();

        // Check in french file
        $by_value = array();
        foreach ($keys_fr as $key => $value)
        {
            $norm = trim(strtolower($value));
            if ($norm === '') continue;
            $by_value[$norm][] = $key;
        }
        foreach ($by_value as $value => $keys)
            if (count($keys) > 1)
                $duplicates[] = array('lang' => 'fr', 'value' => $value, 'keys' => $keys);

        // Check in english file
        $by_value = array();
        foreach ($keys_en as $key => $value)
        {
            $norm = trim(strtolower($value));
            if ($norm === '') continue;
            $by_value[$norm][] = $key;
        }
        foreach ($by_value as $value => $keys)
            if (count($keys) > 1)
            {
                // Avoid reporting same group twice if fr+en are identical
                $already = false;
                foreach ($duplicates as $d)
                    if ($d['keys'] === $keys) { $already = true; break; }
                if (!$already)
                    $duplicates[] = array('lang' => 'en', 'value' => $value, 'keys' => $keys);
            }

        return $duplicates;
    }

    // -------------------------------------------------------------------------
    // Find keys whose fr value matches a key in another module's fr lang file
    // -------------------------------------------------------------------------
    private function find_external_duplicates($keys_fr, $current_module)
    {
        if (empty($keys_fr)) return array();

        $duplicates = array();
        $modules_path = PATH_TO_ROOT . '/modules';

        // Build a map: value → array of [module, key] from other modules
        $other_values = array();
        foreach (scandir($modules_path) as $mod)
        {
            if ($mod === '.' || $mod === '..' || $mod === $current_module) continue;
            $lang_file = $modules_path . '/' . $mod . '/lang/french/common.php';
            if (!is_file($lang_file)) continue;

            $other_keys = $this->extract_lang_keys($lang_file);
            foreach ($other_keys as $k => $v)
            {
                $norm = trim(strtolower($v));
                if ($norm === '') continue;
                $other_values[$norm][] = array('module' => $mod, 'key' => $k);
            }
        }

        // Compare current module keys against other modules
        foreach ($keys_fr as $key => $value)
        {
            $norm = trim(strtolower($value));
            if ($norm === '' || !isset($other_values[$norm])) continue;
            $duplicates[] = array(
                'key'     => $key,
                'value'   => $value,
                'matches' => $other_values[$norm],
            );
        }

        return $duplicates;
    }
}
?>
