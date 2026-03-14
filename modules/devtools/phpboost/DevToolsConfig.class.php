<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 */

class DevToolsConfig extends AbstractConfigData
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
        try {
            $row = PersistenceContext::get_querier()->select_single_row(
                PREFIX . 'configs', array('value'), 'WHERE name = :name', array('name' => 'devtools-config')
            );
            if ($row && !empty($row['value']))
            {
                $instance = @unserialize($row['value'], array('allowed_classes' => array('DevToolsConfig', 'AbstractConfigData')));
                if ($instance instanceof self)
                    return $instance;
            }
        } catch (Exception $e) {}

        // First install or corrupt data - return defaults
        $instance = new self();
        $instance->set_property(self::GITHUB_TOKEN, '');
        $instance->set_property(self::REPOS, self::DEFAULT_REPOS);
        return $instance;
    }

    public static function save()
    {
        // Use persist() on the loaded instance
    }

    public function persist()
    {
        $serialized = serialize($this);
        try {
            $count = PersistenceContext::get_querier()->count(PREFIX . 'configs', 'WHERE name = :name', array('name' => 'devtools-config'));
            if ($count > 0)
                PersistenceContext::get_querier()->update(PREFIX . 'configs', array('value' => $serialized), 'WHERE name = :name', array('name' => 'devtools-config'));
            else
                PersistenceContext::get_querier()->insert(PREFIX . 'configs', array('name' => 'devtools-config', 'value' => $serialized));
        } catch (Exception $e) {
            @file_put_contents(PATH_TO_ROOT . '/cache/backup/debug_config.log',
                date('H:i:s') . ' persist error: ' . $e->getMessage() . "\n", FILE_APPEND);
        }
    }}
?>
