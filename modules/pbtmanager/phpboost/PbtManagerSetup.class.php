<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 */

class PbtManagerSetup extends DefaultModuleSetup
{
    public function install()
    {
        // No custom tables needed: data comes from local filesystem + GitHub API.
        // Initialize config with default values so ConfigManager never returns null.
        $config = new PbtManagerConfig();
        $config->set_default_values();
        ConfigManager::save('pbtmanager', $config, 'config');
    }

    public function uninstall()
    {
        ConfigManager::delete('pbtmanager', 'config');
    }
}
?>
