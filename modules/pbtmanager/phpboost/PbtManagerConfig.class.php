<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 */

class PbtManagerConfig extends AbstractConfigData
{
    const REPOS         = 'repos';
    const GITHUB_TOKEN  = 'github_token';

    // Default repos shipped with the module
    const DEFAULT_REPOS = array(
        array(
            'label'  => 'LamPDL',
            'owner'  => 'mipel85',
            'repo'   => 'LamPDL',
            'path'   => 'modules',
        ),
        array(
            'label'  => 'PHPBoost/Modules',
            'owner'  => 'PHPBoost',
            'repo'   => 'Modules',
            'path'   => '',
        ),
        array(
            'label'  => 'PHPBoost/PHPBoost',
            'owner'  => 'PHPBoost',
            'repo'   => 'PHPBoost',
            'path'   => 'modules',
        ),
        array(
            'label'  => 'PHPBoost/Themes',
            'owner'  => 'PHPBoost',
            'repo'   => 'Themes',
            'path'   => '',
        ),
    );

    /**
     * @return array  List of configured repos (each item: label, owner, repo, path)
     */
    public function get_repos()
    {
        return $this->get_property(self::REPOS);
    }

    public function set_repos(array $repos)
    {
        $this->set_property(self::REPOS, $repos);
    }

    public function get_github_token()
    {
        return $this->get_property(self::GITHUB_TOKEN);
    }

    public function set_github_token($token)
    {
        $this->set_property(self::GITHUB_TOKEN, $token);
    }

    public function get_default_values()
    {
        return array(
            self::REPOS        => self::DEFAULT_REPOS,
            self::GITHUB_TOKEN => '',
        );
    }

    public static function load()
    {
        return ConfigManager::load(__CLASS__, 'pbtmanager', 'config');
    }

    public static function save()
    {
        ConfigManager::save('pbtmanager', self::load(), 'config');
    }
}
?>
