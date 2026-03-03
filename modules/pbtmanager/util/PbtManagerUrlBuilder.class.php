<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 */

class PbtManagerUrlBuilder
{
    private static $dispatcher = '/pbtmanager';

    public static function home()
    {
        return DispatchManager::get_url(self::$dispatcher, '/');
    }

    public static function modules()
    {
        return DispatchManager::get_url(self::$dispatcher, '/modules/');
    }

    public static function configuration()
    {
        return DispatchManager::get_url(self::$dispatcher, '/admin/config/');
    }

    // Ajax endpoints
    public static function ajax_branches()
    {
        return DispatchManager::get_url(self::$dispatcher, '/ajax/branches/');
    }

    public static function ajax_folders()
    {
        return DispatchManager::get_url(self::$dispatcher, '/ajax/folders/');
    }

    public static function ajax_install()
    {
        return DispatchManager::get_url(self::$dispatcher, '/ajax/install/');
    }

    public static function ajax_activate()
    {
        return DispatchManager::get_url(self::$dispatcher, '/ajax/activate/');
    }

    public static function ajax_deactivate()
    {
        return DispatchManager::get_url(self::$dispatcher, '/ajax/deactivate/');
    }

    public static function ajax_uninstall()
    {
        return DispatchManager::get_url(self::$dispatcher, '/ajax/uninstall/');
    }

    public static function ajax_repos()
    {
        return DispatchManager::get_url(self::$dispatcher, '/ajax/repos/');
    }

    public static function ajax_save_repo()
    {
        return DispatchManager::get_url(self::$dispatcher, '/ajax/save-repo/');
    }

    public static function ajax_local_install()
    {
        return DispatchManager::get_url(self::$dispatcher, '/ajax/local-install/');
    }
}
?>
