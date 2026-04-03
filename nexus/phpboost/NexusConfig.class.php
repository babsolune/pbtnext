<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Sebastien LARTIGUE <babsolune@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 03 28
 * @since       PHPBoost 6.1 - 2026 03 28
*/

class NexusConfig extends DefaultRichModuleConfig
{
	const ITEMS_SUGGESTIONS_ENABLED = 'items_suggestions_enabled';
	const ITEMS_NAVIGATION_ENABLED = 'items_navigation_enabled';

	/**
	 * {@inheritdoc}
	 */
	public function get_additional_default_values()
	{
		return [
			self::ITEMS_PER_PAGE            => 10,
			self::ITEMS_PER_ROW             => 1,
			self::FULL_ITEM_DISPLAY         => true,
			self::VIEWS_NUMBER_ENABLED      => true,
			self::DISPLAY_TYPE              => self::LIST_VIEW,
			self::ROOT_CATEGORY_DESCRIPTION => '',
			self::ITEMS_SUGGESTIONS_ENABLED => true,
			self::ITEMS_NAVIGATION_ENABLED  => true
		];
	}
}
?>
