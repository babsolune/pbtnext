<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 *
 * Main page: local modules table + remote repo panel.
 */

class PbtManagerHomeController extends DefaultModuleController
{
    public function execute(HTTPRequestCustom $request)
    {
        $this->check_authorizations();
        $this->build_view();
        return $this->generate_response();
    }

    private function build_view()
    {
        $this->view = new FileTemplate('pbtmanager/PbtManagerHomeController.tpl');
        $this->view->add_lang(LangLoader::get_all_langs('pbtmanager'));

        $config  = PbtManagerConfig::load();
        $modules = PbtManagerLocalService::get_local_modules();
        $repos   = $config->get_repos() ?: PbtManagerConfig::DEFAULT_REPOS;

        // --- Local modules table rows ---
        $module_rows = '';
        foreach ((array)$modules as $mod)
        {
            $status_label = $this->lang['pbtmanager.status.not.installed'];
            $status_class = 'pbtm-status-none';

            if ($mod['installed'] && $mod['activated'])
            {
                $status_label = $this->lang['pbtmanager.status.active'];
                $status_class = 'pbtm-status-active';
            }
            elseif ($mod['installed'])
            {
                $status_label = $this->lang['pbtmanager.status.inactive'];
                $status_class = 'pbtm-status-inactive';
            }

            $actions = '';
            $token   = AppContext::get_session()->get_token();

            if ($mod['installed'] && $mod['activated'])
            {
                $actions .= '<button class="pbtm-btn pbtm-btn-warn pbtm-action-deactivate" data-id="' . htmlspecialchars($mod['id']) . '" data-token="' . $token . '" title="' . htmlspecialchars($this->lang['pbtmanager.action.deactivate.title']) . '">'
                    . $this->lang['pbtmanager.action.deactivate'] . '</button> ';
                $actions .= '<button class="pbtm-btn pbtm-btn-danger pbtm-action-uninstall" data-id="' . htmlspecialchars($mod['id']) . '" data-drop="0" data-token="' . $token . '" title="' . htmlspecialchars($this->lang['pbtmanager.uninstall.soft.title']) . '">'
                    . $this->lang['pbtmanager.action.uninstall.soft'] . '</button> ';
                $actions .= '<button class="pbtm-btn pbtm-btn-danger pbtm-action-uninstall" data-id="' . htmlspecialchars($mod['id']) . '" data-drop="1" data-token="' . $token . '" title="' . htmlspecialchars($this->lang['pbtmanager.uninstall.hard.title']) . '">'
                    . $this->lang['pbtmanager.action.uninstall.hard'] . '</button>';
            }
            elseif ($mod['installed'])
            {
                $actions .= '<button class="pbtm-btn pbtm-btn-ok pbtm-action-activate" data-id="' . htmlspecialchars($mod['id']) . '" data-token="' . $token . '" title="' . htmlspecialchars($this->lang['pbtmanager.action.activate.title']) . '">'
                    . $this->lang['pbtmanager.action.activate'] . '</button> ';
                $actions .= '<button class="pbtm-btn pbtm-btn-danger pbtm-action-uninstall" data-id="' . htmlspecialchars($mod['id']) . '" data-drop="0" data-token="' . $token . '" title="' . htmlspecialchars($this->lang['pbtmanager.uninstall.soft.title']) . '">'
                    . $this->lang['pbtmanager.action.uninstall.soft'] . '</button> ';
                $actions .= '<button class="pbtm-btn pbtm-btn-danger pbtm-action-uninstall" data-id="' . htmlspecialchars($mod['id']) . '" data-drop="1" data-token="' . $token . '" title="' . htmlspecialchars($this->lang['pbtmanager.uninstall.hard.title']) . '">'
                    . $this->lang['pbtmanager.action.uninstall.hard'] . '</button>';
            }
            else
            {
                $actions .= '<button class="pbtm-btn pbtm-btn-ok pbtm-action-local-install" data-id="' . htmlspecialchars($mod['id']) . '" data-token="' . $token . '">'
                    . $this->lang['pbtmanager.action.local.install'] . '</button>';
            }

            $module_rows .= '<tr>'
                . '<td>' . htmlspecialchars($mod['name']) . '<br/><small class="pbtm-id">' . htmlspecialchars($mod['id']) . '</small></td>'
                . '<td>' . htmlspecialchars($mod['version'] ?? '—') . '</td>'
                . '<td><span class="pbtm-status ' . $status_class . '">' . $status_label . '</span></td>'
                . '<td class="pbtm-remote-version" data-id="' . htmlspecialchars($mod['id']) . '">—</td>'
                . '<td class="pbtm-actions">' . $actions . '</td>'
                . '</tr>';
        }

        // --- Repos select options ---
        $repo_options = '';
        foreach ($repos as $idx => $repo)
        {
            $label = htmlspecialchars($repo['label'] ?? $repo['owner'] . '/' . $repo['repo']);
            $repo_options .= '<option value="' . $idx . '" data-repo="' . htmlspecialchars(json_encode($repo)) . '">' . $label . '</option>';
        }

        $this->view->put_all(array(
            'C_IS_ADMIN'              => PbtManagerAuthorizationsService::check_authorizations()->admin(),
            'U_CONFIG'                => ModulesUrlBuilder::configuration()->rel(),
            'L_CONFIG'                => $this->lang['pbtmanager.tab.config'],
            'MODULE_ROWS'             => $module_rows,
            'REPO_OPTIONS'            => $repo_options,
            'URL_AJAX_BRANCHES'       => PbtManagerUrlBuilder::ajax_branches()->rel(),
            'URL_AJAX_FOLDERS'        => PbtManagerUrlBuilder::ajax_folders()->rel(),
            'URL_AJAX_INSTALL'        => PbtManagerUrlBuilder::ajax_install()->rel(),
            'URL_AJAX_ACTIVATE'       => PbtManagerUrlBuilder::ajax_activate()->rel(),
            'URL_AJAX_DEACTIVATE'     => PbtManagerUrlBuilder::ajax_deactivate()->rel(),
            'URL_AJAX_UNINSTALL'      => PbtManagerUrlBuilder::ajax_uninstall()->rel(),
            'URL_AJAX_REPOS'          => PbtManagerUrlBuilder::ajax_repos()->rel(),
            'URL_AJAX_SAVE_REPOS'     => PbtManagerUrlBuilder::ajax_save_repo()->rel(),
            'URL_AJAX_LOCAL_INSTALL'  => PbtManagerUrlBuilder::ajax_local_install()->rel(),
            'CSRF_TOKEN'              => AppContext::get_session()->get_token(),
            // UI labels — colonnes & titres
            'L_MODULES'               => $this->lang['pbtmanager.tab.modules'],
            'L_REFRESH'               => $this->lang['pbtmanager.action.refresh'],
            'L_REPO_ADD'              => $this->lang['pbtmanager.repo.add'],
            'L_REPO_ADD_CONFIRM'      => $this->lang['pbtmanager.repo.add.confirm'],
            'L_CANCEL'                => $this->lang['pbtmanager.repo.cancel'],
            'L_REPO_ORG'              => $this->lang['pbtmanager.repo.org'],
            'L_REPO_PICK'             => $this->lang['pbtmanager.repo.pick'],
            'L_REPO_PATH'             => $this->lang['pbtmanager.repo.path'],
            'L_REPO_LABEL'            => $this->lang['pbtmanager.repo.label'],
            'L_COL_NAME'              => $this->lang['pbtmanager.col.name'],
            'L_COL_VERSION'           => $this->lang['pbtmanager.col.version'],
            'L_COL_STATUS'            => $this->lang['pbtmanager.col.status'],
            'L_COL_REMOTE'            => $this->lang['pbtmanager.col.remote.version'],
            'L_COL_ACTIONS'           => $this->lang['pbtmanager.col.actions'],
            'L_REMOTE_TITLE'          => $this->lang['pbtmanager.remote.title'],
            'L_REMOTE_REPO'           => $this->lang['pbtmanager.remote.repo'],
            'L_REMOTE_BRANCH'         => $this->lang['pbtmanager.remote.branch'],
            'L_REMOTE_AVAIL'          => $this->lang['pbtmanager.remote.available'],
            'L_REMOTE_LOADING'        => addslashes((string)($this->lang['pbtmanager.remote.loading'] ?? '')),
            'L_REMOTE_ERROR'          => addslashes((string)($this->lang['pbtmanager.remote.error']   ?? '')),
            'L_REMOTE_NONE'           => addslashes((string)($this->lang['pbtmanager.remote.none']    ?? '')),
            'L_INSTALL_SEL'           => $this->lang['pbtmanager.action.install.sel'],
            'L_SELECT_ALL'            => $this->lang['pbtmanager.action.select.all'],
            'L_DESELECT_ALL'          => $this->lang['pbtmanager.action.deselect.all'],
            'L_INSTALL_SUCCESS'       => addslashes((string)($this->lang['pbtmanager.install.success']      ?? '')),
            'L_INSTALL_ERROR'         => addslashes((string)($this->lang['pbtmanager.install.error']        ?? '')),
            'L_INSTALL_NONE'          => addslashes((string)($this->lang['pbtmanager.install.no.selection'] ?? '')),
            // Variables JS — doivent être safe pour injection dans une string JS
            'L_STATUS_ACTIVE'         => addslashes((string)($this->lang['pbtmanager.status.active']        ?? '')),
            'L_STATUS_INACTIVE'       => addslashes((string)($this->lang['pbtmanager.status.inactive']      ?? '')),
            'L_STATUS_NOT_INSTALLED'  => addslashes((string)($this->lang['pbtmanager.status.not.installed'] ?? '')),
            'L_STATUS_UP_TO_DATE'     => addslashes((string)($this->lang['pbtmanager.status.up.to.date']    ?? '')),
            'L_STATUS_UPDATE_AVAIL'   => addslashes((string)($this->lang['pbtmanager.status.update.avail']  ?? '')),
            'L_STATUS_UNKNOWN'        => addslashes((string)($this->lang['pbtmanager.status.unknown']       ?? '')),
            'L_ACTION_ACTIVATE'       => addslashes((string)($this->lang['pbtmanager.action.activate']      ?? '')),
            'L_ACTION_DEACTIVATE'     => addslashes((string)($this->lang['pbtmanager.action.deactivate']    ?? '')),
            'L_ACTION_UNINSTALL'       => addslashes((string)($this->lang['pbtmanager.action.uninstall']      ?? '')),
            'L_ACTION_LOCAL_INSTALL'   => addslashes((string)($this->lang['pbtmanager.action.local.install']  ?? '')),
            'L_UNINSTALL_CONFIRM'      => addslashes((string)($this->lang['pbtmanager.uninstall.confirm']     ?? '')),
            'L_UNINSTALL_SOFT_CONFIRM' => addslashes((string)($this->lang['pbtmanager.uninstall.soft.confirm'] ?? '')),
            'L_UNINSTALL_HARD_CONFIRM' => addslashes((string)($this->lang['pbtmanager.uninstall.hard.confirm'] ?? '')),
        ));
    }

    protected function get_template_string_content()
    {
        return '
            # INCLUDE MESSAGE_HELPER #
            # INCLUDE CONTENT #
        ';
    }

    private function check_authorizations()
    {
        $current_user = AppContext::get_current_user();
        if ($current_user->get_level() < User::MODERATOR_LEVEL)
        {
            $error_controller = PHPBoostErrors::user_not_authorized();
            DispatchManager::redirect($error_controller);
        }
    }

    private function generate_response()
    {
        $response              = new SiteDisplayResponse($this->view);
        $graphical_environment = $response->get_graphical_environment();
        $graphical_environment->set_page_title($this->lang['pbtmanager.module.title']);
        $graphical_environment->get_seo_meta_data()->set_canonical_url(PbtManagerUrlBuilder::home());

        $breadcrumb = $graphical_environment->get_breadcrumb();
        $breadcrumb->add($this->lang['pbtmanager.module.title'], PbtManagerUrlBuilder::home());

        return $response;
    }
}
?>
