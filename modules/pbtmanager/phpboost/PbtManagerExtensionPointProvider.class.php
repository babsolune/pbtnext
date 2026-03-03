<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 */

class PbtManagerExtensionPointProvider extends ExtensionPointProvider
{
    public function css_files()
    {
        $module_css_files = new ModuleCssFiles();
        $module_css_files->adding_always_displayed_file('pbtmanager.css');
        return $module_css_files;
    }

    public function tree_links()
    {
        return new PbtManagerTreeLinks();
    }

    public function url_mappings()
    {
        return new UrlMappings([new DispatcherUrlMapping('/pbtmanager/index.php')]);
    }
}
?>
