<?php
/**
 * @package     MVC
 * @subpackage  Dispatcher
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Loic ROUCHON <horn@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 02 05
 * @since       PHPBoost 3.0 - 2010 10 06
 * @contributor Julien BRISWALTER <j1.seth@phpboost.com>
 * @contributor Arnaud GENET <elenwii@phpboost.com>
 * @contributor Sebastien LARTIGUE <babsolune@phpboost.com>
*/

class DispatcherUrlMapping extends UrlMapping
{
    private bool $high_priority = false;
    private bool $low_priority = false;

    /**
     * @param UrlMapping[] $mappings
     */
    public function __construct(string $dispatcher_name, string $match = '([\w/_-]*)$', string $from_path = '', string $redirect_path = '', bool $high_priority = false)
    {
        $module = explode('/', $dispatcher_name)[1];
        if (in_array($module, ['kernel', 'admin', 'cache', 'install', 'update', 'user', 'syndication', 'upload', 'images', 'lang', 'templates']))
            $prefix =  '';
        else
            $prefix = '/modules';
        if (!empty($from_path))
        {
            if ($from_path == 'root')
            {
                $from = '^' . $match;
                $to = $prefix . $dispatcher_name . '?url=/' . ($redirect_path ? $redirect_path : '$1');
                $this->low_priority = true;
            }
            else
            {
                $dispatcher_path = ltrim(TextHelper::substr($from_path, 0, TextHelper::strrpos($from_path, '/') + 1), '/');
                $from = '^' . $dispatcher_path . $match;
                $to = $prefix . $dispatcher_name . '?url=/' . $dispatcher_path . '$1';
                $this->high_priority = true;
            }
        }
        else if ($high_priority)
        {
            $dispatcher_path = ltrim(TextHelper::substr($dispatcher_name, 0, TextHelper::strrpos($dispatcher_name, '/') + 1), '/');
            $from = '^' . $dispatcher_path . $match;
            $to = $prefix . $dispatcher_name . '?url=/' . ($redirect_path ? $redirect_path : '$1');
            $this->high_priority = true;
        }
        else
        {
            $dispatcher_path = ltrim(TextHelper::substr($dispatcher_name, 0, TextHelper::strrpos($dispatcher_name, '/') + 1), '/');
            $from = '^' . $dispatcher_path . $match;
            $to = $prefix . $dispatcher_name . '?url=/$1';
        }
        parent::__construct($from, $to);
    }

    /**
     * Check if the Url must be placed in high priority in the .htaccess file
     */
    public function is_high_priority(): bool
    {
        return $this->high_priority;
    }

    /**
     * Check if the Url must be placed in low priority in the .htaccess file
     */
    public function is_low_priority(): bool
    {
        return $this->low_priority;
    }
}
?>
