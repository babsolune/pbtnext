<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 */

class PbtManagerTreeLinks extends DefaultTreeLinks
{
    public function __construct()
    {
        parent::__construct('pbtmanager');
    }

    protected function get_module_additional_items_actions_tree_links(&$tree)
    {
        $lang = LangLoader::get_all_langs('pbtmanager');

        if (PbtManagerAuthorizationsService::check_authorizations()->moderation())
        {
            $tree->add_link(new ModuleLink(
                $lang['pbtmanager.tab.modules'],
                PbtManagerUrlBuilder::modules(),
                true
            ));
        }
    }
}
?>
