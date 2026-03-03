<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 */

define('PATH_TO_ROOT', '../..');
ini_set('display_errors', 0);
error_reporting(E_ALL);

require_once PATH_TO_ROOT . '/kernel/init.php';

$url_controller_mappers = array(
    // Admin
    new UrlControllerMapper('AdminPbtManagerConfigController', '`^/admin(?:/config)?/?$`'),

    // Ajax endpoints
    new UrlControllerMapper('PbtManagerAjaxBranchesController',   '`^/ajax/branches/?$`'),
    new UrlControllerMapper('PbtManagerAjaxFoldersController',    '`^/ajax/folders/?$`'),
    new UrlControllerMapper('PbtManagerAjaxInstallController',    '`^/ajax/install/?$`'),
    new UrlControllerMapper('PbtManagerAjaxActivateController',   '`^/ajax/activate/?$`'),
    new UrlControllerMapper('PbtManagerAjaxDeactivateController', '`^/ajax/deactivate/?$`'),
    new UrlControllerMapper('PbtManagerAjaxUninstallController',  '`^/ajax/uninstall/?$`'),
    new UrlControllerMapper('PbtManagerAjaxReposController',      '`^/ajax/repos/?$`'),
    new UrlControllerMapper('PbtManagerAjaxSaveRepoController',   '`^/ajax/save-repo/?$`'),
    new UrlControllerMapper('PbtManagerAjaxLocalInstallController', '`^/ajax/local-install/?$`'),

    // Main page (modules tab)
    new UrlControllerMapper('PbtManagerHomeController', '`^(?:/modules)?/?$`'),
);

DispatchManager::dispatch($url_controller_mappers);
?>
