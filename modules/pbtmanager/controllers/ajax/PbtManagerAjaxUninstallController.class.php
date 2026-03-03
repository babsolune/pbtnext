<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 */
class PbtManagerAjaxUninstallController extends AbstractController
{
    public function execute(HTTPRequestCustom $request)
    {
        if (!PbtManagerAuthorizationsService::check_authorizations()->moderation())
            return new JSONResponse(array('success' => false, 'error' => 'Unauthorized'), 403);

        $module_id = preg_replace('/[^a-zA-Z0-9_\-]/', '', $request->get_string('id', ''));

        if ($module_id === 'pbtmanager')
            return new JSONResponse(array('success' => false, 'error' => 'Vous ne pouvez pas désinstaller ce module depuis lui-même.'));

        if (!ModulesManager::is_module_installed($module_id))
            return new JSONResponse(array('success' => false, 'error' => 'Module non installé'));

        if (ModulesManager::is_module_activated($module_id))
            ModulesManager::update_module($module_id, 0);

        $drop_files = $request->get_string('drop_files', '0') === '1';
        ModulesManager::uninstall_module($module_id, $drop_files);
        return new JSONResponse(array('success' => true));
    }
}
?>
