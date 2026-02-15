<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Loic ROUCHON <horn@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2021 04 07
 * @since       PHPBoost 3.0 - 2010 10 04
 * @contributor Julien BRISWALTER <j1.seth@phpboost.com>
 * @contributor Sebastien LARTIGUE <babsolune@phpboost.com>
 */

class UpdateFinishController extends UpdateController
{
    public function execute(HTTPRequestCustom $request): mixed
    {
        parent::load_lang($request);
        $view = new FileTemplate('update/finish.tpl');
        return $this->create_response($view);
    }

    private function create_response(View $view): UpdateDisplayResponse
    {
        $step_title = $this->lang['step.list.end'];
        $response   = new UpdateDisplayResponse(5, $step_title, $view);
        return $response;
    }
}
