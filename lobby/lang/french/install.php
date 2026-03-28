<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      Sebastien LARTIGUE <babsolune@phpboost.com>
 * @version     PHPBoost 6.1 - last update: 2026 03 21
 * @since       PHPBoost 6.1 - 2026 03 21
*/

####################################################
#                      French                      #
####################################################

$lang['lobby.edito.description'] = '
    Accédez à la <a class="offload" href="' . LobbyUrlBuilder::configuration()->relative() . '">configuration de ce module</a> pour paramétrer la <strong>page d\'accueil</strong>
    <br /><br />
    Votre site propulsé par PHPBoost est bien installé et fonctionnel. Afin de vous aider à le prendre en main,
    l\'accueil de chaque module contient un message pour vous guider dans vos premiers pas. Voici également quelques recommandations supplémentaires que nous vous proposons de lire avec attention : <br />
    <br />
    <h2 class="formatter-title">N\'oubliez pas de supprimer le répertoire "install"</h2><br />
    Supprimez le répertoire /install à la racine de votre site pour des raisons de sécurité afin que personne ne puisse recommencer l\'installation.<br />
    <br />
    <h2 class="formatter-title">Administrez votre site</h2><br />
    Accédez au <a class="offload" href="' . UserUrlBuilder::administration()->relative() . '">panneau d\'administration de votre site</a> afin de le paramétrer comme vous le souhaitez !
    <br />
    Pour cela :
    <ul class="formatter-ul">
        <li class="formatter-li"><a class="offload" href="' . AdminMaintainUrlBuilder::maintain()->relative() . '">Mettez votre site en maintenance</a> en attendant que vous le configuriez à votre guise.
        </li><li class="formatter-li">Rendez vous à la <a class="offload" href="' . AdminConfigUrlBuilder::general_config()->relative() . '">Configuration générale du site</a>.
        </li><li class="formatter-li"><a class="offload" href="' . AdminModulesUrlBuilder::list_installed_modules()->relative() . '">Configurez les modules</a> disponibles et donnez leur les droits d\'accès (si vous n\'avez pas installé le pack complet, tous les modules sont disponibles sur le site de <a class="offload" href="https://www.phpboost.com/download/">phpboost.com</a> dans la section téléchargement).
        </li><li class="formatter-li"><a class="offload" href="' . AdminContentUrlBuilder::content_configuration()->relative() . '">Choisissez le langage de formatage du contenu</a> par défaut du site.
        </li><li class="formatter-li"><a class="offload" href="' . AdminMembersUrlBuilder::configuration()->relative() . '">Configurez l\'inscription des membres</a>.
        </li><li class="formatter-li"><a class="offload" href="' . AdminThemeUrlBuilder::list_installed_theme()->relative() . '">Choisissez le thème par défaut de votre site</a> pour en changer l\'apparence (vous pouvez en obtenir d\'autres sur le site de <a class="offload" href="https://www.phpboost.com/download/">phpboost.com</a>).
        </li><li class="formatter-li">Avant de donner l\'accès de votre site à vos visiteurs, prenez un peu de temps pour y mettre du contenu.
        </li><li class="formatter-li">Enfin <a class="offload" href="' . AdminMaintainUrlBuilder::maintain()->relative() . '">désactivez la maintenance</a> de votre site afin qu\'il soit visible par vos visiteurs.<br /></li>
    </ul>
    <br />
    <h2 class="formatter-title">Que faire si vous rencontrez un problème ?</h2><br />
    N\'hésitez pas à consulter <a class="offload" href="https://www.phpboost.com/wiki/">la documentation de PHPBoost</a> ou à poser vos questions sur le <a class="offload" href="https://www.phpboost.com/forum/">forum d\'entraide</a>.<br /> <br />
    <br />
    <p class="float-right">Toute l\'équipe de PHPBoost vous remercie d\'utiliser son logiciel pour créer votre site web !</p>
';
?>
