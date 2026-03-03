<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 *
 * Installs a module already present on disk.
 */
class PbtManagerAjaxLocalInstallController extends AbstractController
{
    public function execute(HTTPRequestCustom $request)
    {
        if (!PbtManagerAuthorizationsService::check_authorizations()->moderation())
            return new JSONResponse(array('success' => false, 'error' => 'Unauthorized'), 403);

        $module_id = preg_replace('/[^a-zA-Z0-9_\-]/', '', $request->get_string('id', ''));

        if (empty($module_id))
            return new JSONResponse(array('success' => false, 'error' => 'Identifiant manquant'));

        if (ModulesManager::is_module_installed($module_id))
            return new JSONResponse(array('success' => false, 'error' => 'Module déjà installé'));

        $module_dir = PATH_TO_ROOT . '/modules/' . $module_id;
        if (!is_dir($module_dir))
            return new JSONResponse(array('success' => false, 'error' => 'Dossier module introuvable'));

        $result = ModulesManager::install_module($module_id);

        switch ($result)
        {
            case ModulesManager::MODULE_INSTALLED:
                $module = ModulesManager::get_module($module_id);
                HooksService::execute_hook_typed_action('install', 'module', $module_id, array_merge(
                    array('title' => $module->get_configuration()->get_name(), 'url' => ''),
                    $module->get_configuration()->get_properties()
                ));
                return new JSONResponse(array('success' => true));

            case ModulesManager::MODULE_ALREADY_INSTALLED:
                return new JSONResponse(array('success' => false, 'error' => 'Module déjà installé'));

            case ModulesManager::CONFIG_CONFLICT:
                return new JSONResponse(array('success' => false, 'error' => 'Conflit de configuration'));

            case ModulesManager::PHP_VERSION_CONFLICT:
                return new JSONResponse(array('success' => false, 'error' => 'Version PHP incompatible'));

            case ModulesManager::PHPBOOST_VERSION_CONFLICT:
                return new JSONResponse(array('success' => false, 'error' => 'Version PHPBoost incompatible'));

            case ModulesManager::UNEXISTING_MODULE:
            default:
                return new JSONResponse(array('success' => false, 'error' => 'Module introuvable ou erreur d\'installation'));
        }
    }
}
?>
