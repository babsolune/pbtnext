<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 *
 * Returns the list of public repos for a GitHub organization.
 */
class PbtManagerAjaxReposController extends AbstractController
{
    public function execute(HTTPRequestCustom $request)
    {
        if (!PbtManagerAuthorizationsService::check_authorizations()->admin())
            return new JSONResponse(array('success' => false, 'error' => 'Unauthorized'), 403);

        $org = preg_replace('/[^a-zA-Z0-9_\-]/', '', $request->get_string('org', ''));
        if (empty($org))
            return new JSONResponse(array('success' => false, 'error' => 'Organisation manquante'));

        $data = PbtManagerGitHubService::get_org_repos($org);
        if ($data === false)
            return new JSONResponse(array('success' => false, 'error' => 'Impossible de récupérer les dépôts'));

        $repos = array();
        foreach ($data as $repo)
        {
            $repos[] = array(
                'name'        => $repo['name'],
                'full_name'   => $repo['full_name'],
                'description' => $repo['description'] ?? '',
            );
        }

        return new JSONResponse(array('success' => true, 'repos' => $repos));
    }
}
?>
