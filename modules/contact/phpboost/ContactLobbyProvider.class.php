<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Sebastien LARTIGUE <babsolune@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 03 21
 * @since       PHPBoost 6.1 - 2026 03 21
*/

class ContactLobbyProvider extends DefaultLobbyModuleProvider
{
	public function get_module_id(): string
	{
		return 'contact';
	}

	/**
	 * Contact has no categories and no items limit / chars limit fields.
	 */
	public function has_categories(): bool
	{
		return false;
	}

	/**
	 * Contact only needs the enable/disable toggle — no extra config fields.
	 *
	 * @param  LobbyModule $module
	 * @return AbstractFormField[]
	 */
	public function get_config_fields(LobbyModule $module): array
	{
		return [];
	}

	public function get_fields_visibility(LobbyModule $module): array
	{
		return [];
	}

	public function save(HTMLForm $form, LobbyModule $module): void
	{
		// Nothing extra to persist for contact beyond the displayed flag
	}

	/**
	 * Builds and returns the contact form view.
	 * The form processing (submit, mail sending) is performed inline here
	 * so that the lobby home controller handles it transparently.
	 */
	public function get_view(): FileTemplate
	{
		$module_id      = $this->get_module_id();
		$contact_config = ContactConfig::load();

		$view = $this->get_lobby_template('ContactLobbyProvider.tpl');
		$view->add_lang(array_merge(LangLoader::get_all_langs(), LangLoader::get_all_langs('lobby'), LangLoader::get_all_langs($module_id)));

		$view->put_all([
			'MODULE_POSITION' => LobbyConfig::load()->get_module_position_by_id($module_id),
			'C_MAP_ENABLED'   => $contact_config->is_map_enabled(),
			'C_MAP_TOP'       => $contact_config->is_map_enabled() && $contact_config->is_map_top(),
			'C_MAP_BOTTOM'    => $contact_config->is_map_enabled() && $contact_config->is_map_bottom(),
			'L_MODULE_TITLE'  => ModulesManager::get_module($module_id)->get_configuration()->get_name(),
		]);

		// Build form
		$form     = new HTMLForm('contact_lobby');
		$fieldset = new FormFieldsetHTML('send_a_mail', $contact_config->get_title());
		$form->add_fieldset($fieldset);

		foreach ($contact_config->get_fields() as $id => $properties)
		{
			$field = new ContactField();
			$field->set_properties($properties);
			if ($field->is_displayed())
			{
				$field->get_fieldtype()->set_value($field->get_default_value());
				$fieldset->add_field($field->get_fieldtype()->get_form_field());
			}
		}

		$submit_button = new FormButtonDefaultSubmit();
		$form->add_button($submit_button);

		if ($submit_button->has_been_submited() && $form->validate())
		{
			if (ContactService::send_contact_mail($form))
			{
				$msg = LangLoader::get_message('contact.message.success.email', 'common', 'contact');
				if ($contact_config->is_sender_acknowledgment_enabled())
				{
					$msg .= ' ' . LangLoader::get_message('contact.message.acknowledgment', 'common', 'contact');
				}
				$view->put('MESSAGE_HELPER', MessageHelper::display($msg, MessageHelper::SUCCESS));
				$view->put('C_MAIL_SENT', true);
			}
			else
			{
				$view->put('MESSAGE_HELPER', MessageHelper::display(
					LangLoader::get_message('contact.message.error.email', 'common', 'contact'),
					MessageHelper::ERROR, 5
				));
			}
		}

		if ($contact_config->is_map_enabled())
		{
			$map = new GoogleMapsDisplayMap($contact_config->get_map_markers());
			$view->put('MAP', $map->display());
		}

		$view->put('CONTACT_FORM', $form->display());

		return $view;
	}
}
?>
