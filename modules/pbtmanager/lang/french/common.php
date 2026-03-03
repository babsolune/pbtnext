<?php
/**
 * @copyright   &copy; 2005-2026 PHPBoost
 * @license     https://www.gnu.org/licenses/gpl-3.0.html GNU/GPL-3.0
 * @author      LamPDL
 * @version     PHPBoost 6.0 - last update: 2026 03 01
 * @since       PHPBoost 6.0 - 2026 03 01
 */

####################################################
#                    French                        #
####################################################

$lang['pbtmanager.module.title'] = 'PBT Manager';

// Tabs
$lang['pbtmanager.tab.modules']  = 'Modules présents';
$lang['pbtmanager.tab.themes']   = 'Thèmes';
$lang['pbtmanager.tab.config']   = 'Réglages';

// Local status table
$lang['pbtmanager.local.modules']        = 'Modules installés';
$lang['pbtmanager.col.name']             = 'Nom';
$lang['pbtmanager.col.version']          = 'Version installée';
$lang['pbtmanager.col.status']           = 'État';
$lang['pbtmanager.col.remote.version']   = 'Version disponible';
$lang['pbtmanager.col.actions']          = 'Actions';

$lang['pbtmanager.status.active']        = 'Actif';
$lang['pbtmanager.status.inactive']      = 'Inactif';
$lang['pbtmanager.status.not.installed'] = 'Non installé';
$lang['pbtmanager.status.up.to.date']    = 'À jour';
$lang['pbtmanager.status.update.avail']  = 'Mise à jour disponible';
$lang['pbtmanager.status.unknown']       = 'Inconnu';

// Actions
$lang['pbtmanager.action.refresh']       = 'Rafraîchir';
$lang['pbtmanager.action.activate']       = 'Activer';
$lang['pbtmanager.action.activate.title']  = 'Ce module sera à nouveau disponible';
$lang['pbtmanager.repo.add']             = 'Ajouter un dépôt';
$lang['pbtmanager.repo.add.confirm']     = 'Ajouter';
$lang['pbtmanager.repo.cancel']          = 'Annuler';
$lang['pbtmanager.repo.org']             = 'Organisation GitHub';
$lang['pbtmanager.repo.pick']            = 'Dépôt';
$lang['pbtmanager.repo.path']            = 'Sous-dossier';
$lang['pbtmanager.repo.label']           = 'Label affiché';
$lang['pbtmanager.action.deactivate']      = 'Désactiver';
$lang['pbtmanager.action.deactivate.title'] = 'Ce module sera indisponible sans perte de données';
$lang['pbtmanager.action.uninstall']          = 'Désinstaller';
$lang['pbtmanager.action.uninstall.soft']     = 'Désinstaller';
$lang['pbtmanager.action.uninstall.hard']     = 'Désinstaller et supprimer';
$lang['pbtmanager.action.local.install']      = 'Installer';
$lang['pbtmanager.uninstall.soft.title']      = 'Ce module pourra être réinstallé (les fichiers sont conservés)';
$lang['pbtmanager.uninstall.hard.title']      = 'Ce module ne sera plus disponible sans le télécharger à nouveau';
$lang['pbtmanager.uninstall.confirm']         = 'Confirmer la désinstallation de ce module ?';
$lang['pbtmanager.uninstall.soft.confirm']    = 'Désinstaller ce module ? Les fichiers seront conservés, il pourra être réinstallé.';
$lang['pbtmanager.uninstall.hard.confirm']    = 'Supprimer définitivement ce module ? Les fichiers seront supprimés, il faudra le télécharger à nouveau.';

$lang['pbtmanager.action.install.sel']   = 'Installer la sélection';
$lang['pbtmanager.action.select.all']    = 'Tout sélectionner';
$lang['pbtmanager.action.deselect.all']  = 'Tout désélectionner';

// Remote repo panel
$lang['pbtmanager.remote.title']         = 'Dépôts distants';
$lang['pbtmanager.remote.repo']          = 'Dépôt';
$lang['pbtmanager.remote.branch']        = 'Branche';
$lang['pbtmanager.remote.available']     = 'Modules disponibles';
$lang['pbtmanager.remote.loading']       = 'Chargement…';
$lang['pbtmanager.remote.error']         = 'Erreur de chargement du dépôt distant.';
$lang['pbtmanager.remote.none']          = 'Aucun module trouvé dans cette branche.';

// Install feedback
$lang['pbtmanager.install.success']      = 'Module(s) installé(s) avec succès.';
$lang['pbtmanager.install.error']        = 'Erreur lors de l\'installation : ';
$lang['pbtmanager.install.no.selection'] = 'Aucun module sélectionné.';
$lang['pbtmanager.uninstall.confirm']    = 'Confirmer la désinstallation de ce module ?';
$lang['pbtmanager.uninstall.drop.confirm'] = 'Supprimer aussi les fichiers du dossier /modules ?';

// Config
$lang['pbtmanager.config.repos']         = 'Dépôts GitHub';
$lang['pbtmanager.config.repo.add']      = 'Ajouter un dépôt';
$lang['pbtmanager.config.repo.delete']   = 'Supprimer';
$lang['pbtmanager.config.repo.org']      = 'Organisation GitHub';
$lang['pbtmanager.config.repo.pick']     = 'Dépôt';
$lang['pbtmanager.config.repo.owner']    = 'Propriétaire (ex: LamPDL)';
$lang['pbtmanager.config.repo.name']     = 'Nom du dépôt (ex: LamPDL)';
$lang['pbtmanager.config.repo.path']     = 'Sous-dossier des modules (laisser vide si racine)';
$lang['pbtmanager.config.repo.label']    = 'Label affiché';
$lang['pbtmanager.config.github.token']  = 'Token GitHub (optionnel, pour éviter les limites de taux)';

// SEO
$lang['pbtmanager.seo.description']      = 'Gestion des modules PHPBoost sur ' . GeneralConfig::load()->get_site_name() . '.';
?>
