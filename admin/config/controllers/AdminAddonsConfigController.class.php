<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Sebastien LARTIGUE <babsolune@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 03 18
 * @since       PHPBoost 6.1 - 2026 03 07
*/

class AdminAddonsConfigController extends DefaultAdminController
{
	private $configuration;

    public function execute(HTTPRequestCustom $request)
    {
		$this->init();
		$this->build_form();

		if ($this->submit_button->has_been_submited() && $this->form->validate())
		{
			$this->save();
			$this->view->put('MESSAGE_HELPER', MessageHelper::display($this->lang['warning.process.success'], MessageHelper::SUCCESS, 4));
        }

		$this->view->put('CONTENT', $this->form->display());

		return new AdminAddonsConfigDisplayResponse($this->view, $this->lang['form.configuration']);
    }

    public function init()
    {
        $this->configuration = AddonsConfig::load();
    }

    private function build_form()
    {
        $form = new HTMLForm(self::class);

        $fieldset = new FormFieldsetHTML('github', $this->lang['addon.github.configuration']);
        $form->add_fieldset($fieldset);

        $fieldset->add_field(new FormFieldTextEditor('github_token', $this->lang['addon.github.token'], $this->configuration->get_github_token()));

        $fieldset->add_field(new FormFieldAddonsRepositories('modules_repos', $this->lang['addon.modules.repos.add'], $this->configuration->get_modules_repo(), 
            ['class' => 'full-field']
        ));

        $fieldset->add_field(new FormFieldAddonsRepositories('themes_repos', $this->lang['addon.themes.repos.add'], $this->configuration->get_themes_repo(), 
            ['class' => 'full-field']
        ));

        $fieldset->add_field(new FormFieldAddonsRepositories('langs_repos', $this->lang['addon.langs.repos.add'], $this->configuration->get_langs_repo(), 
            ['class' => 'full-field']
        ));

        $server_fieldset = new FormFieldsetHTML('addon_server', $this->lang['addon.servers.configuration']);
        $server_fieldset->set_description($this->lang['addon.servers.configuration.clue']);
        $form->add_fieldset($server_fieldset);

        $server_fieldset->add_field(new FormFieldAddonsServers('addons_server', $this->lang['addon.servers.add'], $this->configuration->get_addons_server(), 
            ['class' => 'full-field']
        ));

        $this->submit_button = new FormButtonDefaultSubmit();
        $form->add_button($this->submit_button);

        $this->form = $form;
    }

    private function save()
    {
        $this->configuration->set_github_token($this->form->get_field_by_id('github_token')->get_value());
        $this->configuration->set_modules_repo($this->form->get_field_by_id('modules_repos')->get_value());
        $this->configuration->set_themes_repo($this->form->get_field_by_id('themes_repos')->get_value());
        $this->configuration->set_langs_repo($this->form->get_field_by_id('langs_repos')->get_value());
        $this->configuration->set_addons_server($this->form->get_field_by_id('addons_server')->get_value());
    }
}
?>
