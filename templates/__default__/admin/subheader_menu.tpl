<li id="adminboost-administration">
    <a href="#admin-administration" class=""><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.administration}</span></a>
    <ul>
        <li>
            <a href="${relative_url(AdminConfigUrlBuilder::general_config())}"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.configuration}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(AdminConfigUrlBuilder::general_config())}"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.configuration.general}</span></a></li>
                <li><a href="${relative_url(AdminConfigUrlBuilder::advanced_config())}"><i aria-hidden="true" class="fa fa-fw fa-cogs"></i><span>{@menu.configuration.advanced}</span></a></li>
                <li><a href="${relative_url(AdminConfigUrlBuilder::mail_config())}"><i aria-hidden="true" class="fa fa-fw iboost fa-iboost-email"></i><span>{@menu.configuration.email}</span></a></li>
            </ul>
        </li>
        <li>
            <a href="{PATH_TO_ROOT}/admin/menus/menus.php"><i aria-hidden="true" class="fa fa-fw fa-list-ul"></i><span>{@menu.menus}</span></a>
            <ul class="level-2">
                <li><a href="{PATH_TO_ROOT}/admin/menus/menus.php"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.management}</span></a></li>
                <li><a href="{PATH_TO_ROOT}/admin/menus/links.php"><i aria-hidden="true" class="fa fa-fw fa-list-ul"></i><span>{@menu.links.add}</span></a></li>
                <li><a href="{PATH_TO_ROOT}/admin/menus/content.php"><i aria-hidden="true" class="far fa-fw fa-file"></i><span>{@menu.content.add}</span></a></li>
                <li><a href="{PATH_TO_ROOT}/admin/menus/feed.php"><i aria-hidden="true" class="fa fa-fw fa-rss"></i><span>{@menu.feed.add}</span></a></li>
            </ul>
        </li>
        <li><a href="{PATH_TO_ROOT}/admin/updates/updates.php?type=kernel"><i aria-hidden="true" class="fa fa-fw fa-cog"></i> <span>{@menu.updates} {@menu.updates.kernel}</span></a></li>
        <li><a href="${relative_url(AdminContentUrlBuilder::content_configuration())}"><i aria-hidden="true" class="far fa-fw fa-square"></i><span>{@menu.content}</span></a></li>
        <li><a href="${relative_url(AdminMaintainUrlBuilder::maintain())}"><i aria-hidden="true" class="far fa-fw fa-clock"></i> <span>{@menu.maintenance}</span></a></li>
        <li><a href="{PATH_TO_ROOT}/admin/admin_alerts.php"><i aria-hidden="true" class="fa fa-fw fa-bell"></i> <span>{@menu.alerts}</span></a></li>
        <li>
            <a href="{PATH_TO_ROOT}/admin/admin_files.php"><i aria-hidden="true" class="fa fa-fw fa-file-alt"></i><span>{@menu.files}</span></a>
            <ul class="level-2">
                <li><a href="{PATH_TO_ROOT}/admin/admin_files.php"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.management}</span></a></li>
                <li><a href="${relative_url(AdminFilesUrlBuilder::configuration())}"><i aria-hidden="true" class="fa fa-cogs"></i><span>{@menu.configuration}</span></a></li>
            </ul>
        </li>
        <li>
            <a href="${relative_url(UserUrlBuilder::comments())}"><i aria-hidden="true" class="far fa-fw fa-comment"></i><span>{@menu.comments}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(UserUrlBuilder::comments())}"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.management}</span></a></li>
                <li><a href="{PATH_TO_ROOT}/admin/content/?url=/comments/config/"><i aria-hidden="true" class="fa fa-fw fa-cogs"></i><span>{@menu.configuration}</span></a></li>
            </ul>
        </li>
        <li>
            <a href="${relative_url(AdminSmileysUrlBuilder::management())}"><i aria-hidden="true" class="far fa-fw fa-smile"></i><span>{@menu.smileys}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(AdminSmileysUrlBuilder::management())}"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.management}</span></a></li>
                <li><a href="${relative_url(AdminSmileysUrlBuilder::add())}"><i aria-hidden="true" class="fa fa-fw fa-plus"></i><span>{@menu.add}</span></a></li>
            </ul>
        </li>
        # IF C_ADMIN_LINKS_1 #
            # START admin_links_1 #
                # INCLUDE admin_links_1.MODULE_MENU #
            # END admin_links_1 #
        # ENDIF #
    </ul>
</li>
<li  id="adminboost-addons"class="has-sub">
    <a href="#admin-addons"><i aria-hidden="true" class="fa fa-fw fa-puzzle-piece"></i><span>{@menu.addons}</span></a>
    <ul>
        <li>
            <a href="${relative_url(AdminModulesUrlBuilder::list_installed_modules())}"><i aria-hidden="true" class="fa fa-fw fa-cubes"></i><span>{@menu.modules}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(AdminModulesUrlBuilder::list_installed_modules())}"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.management}</span></a></li>
                <li><a href="${relative_url(AdminModulesUrlBuilder::add_module())}"><i aria-hidden="true" class="fa fa-fw fa-plus"></i><span>{@menu.add}</span></a></li>
                <li><a href="${relative_url(AdminModulesUrlBuilder::update_module())}"><i aria-hidden="true" class="fa fa-fw fa-level-up-alt"></i><span>{@menu.updates}</span></a></li>
                <li><a href="{PATH_TO_ROOT}/admin/updates/updates.php?type=module"><i aria-hidden="true" class="fa fa-fw fa-cubes"></i><span>{@menu.updates}</span></a></li>
            </ul>
        </li>
        <li>
            <a href="${relative_url(AdminThemeUrlBuilder::list_installed_theme())}"><i aria-hidden="true" class="fa fa-fw fa-image"></i><span>{@menu.themes}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(AdminThemeUrlBuilder::list_installed_theme())}"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.management}</span></a></li>
                <li><a href="${relative_url(AdminThemeUrlBuilder::add_theme())}"><i aria-hidden="true" class="fa fa-fw fa-plus"></i><span>{@menu.add}</span></a></li>
                <li><a href="{PATH_TO_ROOT}/admin/updates/updates.php?type=template"><i aria-hidden="true" class="fa fa-fw fa-image"></i><span>{@menu.updates}</span></a></li>
            </ul>
        </li>
        <li>
            <a href="${relative_url(AdminLangsUrlBuilder::list_installed_langs())}"><i aria-hidden="true" class="fa fa-fw fa-language"></i><span>{@menu.langs}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(AdminLangsUrlBuilder::list_installed_langs())}"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.management}</span></a></li>
                <li><a href="${relative_url(AdminLangsUrlBuilder::install())}"><i aria-hidden="true" class="fa fa-fw fa-plus"></i> <span>{@menu.add}</span></a></li>
            </ul>
        </li>
        # IF C_ADMIN_LINKS_2 #
            # START admin_links_2 #
                # INCLUDE admin_links_2.MODULE_MENU #
            # END admin_links_2 #
        # ENDIF #
    </ul>
</li>
<li id="adminboost-tools">
    <a href="#admin-tools"><i aria-hidden="true" class="fa fa-fw fa-wrench"></i><span>{@menu.tools}</span></a>
    <ul>
        <li>
            <a href="${relative_url(AdminCacheUrlBuilder::clear_cache())}"><i aria-hidden="true" class="fa fa-fw fa-sync"></i><span>{@menu.cache}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(AdminCacheUrlBuilder::clear_cache())}"><i aria-hidden="true" class="fa fa-fw fa-sync"></i><span>{@menu.cache}</span></a></li>
                <li><a href="${relative_url(AdminCacheUrlBuilder::clear_syndication_cache())}"><i aria-hidden="true" class="fa fa-fw fa-rss"></i><span>{@menu.cache.syndication}</span></a></li>
                <li><a href="${relative_url(AdminCacheUrlBuilder::clear_css_cache())}"><i aria-hidden="true" class="fab fa-fw fa-css3"></i><span>{@menu.cache.css}</span></a></li>
                <li><a href="${relative_url(AdminCacheUrlBuilder::configuration())}"><i aria-hidden="true" class="fa fa-fw fa-cogs"></i><span>{@menu.configuration}</span></a></li>
            </ul>
        </li>
        <li>
            <a href="${relative_url(AdminErrorsUrlBuilder::logged_errors())}"><i aria-hidden="true" class="fa fa-fw fa-exclamation-triangle"></i><span>{@menu.errors}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(AdminErrorsUrlBuilder::logged_errors())}"><i aria-hidden="true" class="fa fa-fw fa-exclamation-circle"></i><span>{@menu.errors.archived}</span></a></li>
                <li><a href="${relative_url(AdminErrorsUrlBuilder::list_404_errors())}"><i aria-hidden="true" class="fa fa-fw fa-ban"></i><span>{@menu.errors.404}</span></a></li>
            </ul>
        </li>
        <li>
            <a href="${relative_url(AdminServerUrlBuilder::system_report())}"><i aria-hidden="true" class="fa fa-fw fa-building"></i><span>{@menu.server}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(AdminServerUrlBuilder::phpinfo())}"><i aria-hidden="true" class="fa fa-fw fa-info"></i><span>{@menu.server.phpinfo}</span></a></li>
                <li><a href="${relative_url(AdminServerUrlBuilder::system_report())}"><i aria-hidden="true" class="fa fa-fw fa-info-circle"></i><span>{@menu.server.system.report}</span></a></li>
            </ul>
        </li>
        # IF C_ADMIN_LINKS_3 #
            # START admin_links_3 #
                # INCLUDE admin_links_3.MODULE_MENU #
            # END admin_links_3 #
        # ENDIF #
    </ul>
</li>
<li id="adminboost-users">
    <a href="#admin-users"><i aria-hidden="true" class="fa fa-fw fa-user"></i><span>{@menu.users}</span></a>
    <ul>
        <li>
            <a href="${relative_url(AdminMembersUrlBuilder::management())}"><i aria-hidden="true" class="fa fa-fw fa-user"></i><span>{@menu.users}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(AdminMembersUrlBuilder::management())}"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.management}</span></a></li>
                <li><a href="${relative_url(AdminMembersUrlBuilder::add())}"><i aria-hidden="true" class="fa fa-fw fa-plus"></i><span>{@menu.add}</span></a></li>
                <li><a href="${relative_url(AdminMembersUrlBuilder::configuration())}"><i aria-hidden="true" class="fa fa-fw fa-cogs"></i><span>{@menu.configuration}</span></a></li>
                <li><a href="{PATH_TO_ROOT}/user/moderation_panel.php"><i aria-hidden="true" class="fa fa-fw fa-ban"></i><span>{@menu.sanctions.manager}</span></a></li>
            </ul>
        </li>
        <li>
            <a href="{PATH_TO_ROOT}/admin/admin_groups.php"><i aria-hidden="true" class="fa fa-fw fa-users"></i><span>{@menu.groups}</span></a>
            <ul class="level-2">
                <li><a href="{PATH_TO_ROOT}/admin/admin_groups.php"><i aria-hidden="true" class="fa fa-fw fa-cog"></i><span>{@menu.management}</span></a></li>
                <li><a href="{PATH_TO_ROOT}/admin/admin_groups.php?add=1"><i aria-hidden="true" class="fa fa-fw fa-plus"></i><span>{@menu.add}</span></a></li>
            </ul>
        </li>
        <li>
            <a href="${relative_url(AdminExtendedFieldsUrlBuilder::fields_list())}"><i aria-hidden="true" class="fa fa-fw fa-list"></i><span>{@menu.extended.fields}</span></a>
            <ul class="level-2">
                <li><a href="${relative_url(AdminExtendedFieldsUrlBuilder::fields_list())}"><i aria-hidden="true" class="fa fa-cog"></i><span>{@menu.management}</span></a></li>
                <li><a href="${relative_url(AdminExtendedFieldsUrlBuilder::add())}"><i aria-hidden="true" class="fa fa-fw fa-plus"></i><span>{@menu.add}</span></a></li>
            </ul>
        </li>
        # IF C_ADMIN_LINKS_4 #
            # START admin_links_4 #
                # INCLUDE admin_links_4.MODULE_MENU #
            # END admin_links_4 #
        # ENDIF #
    </ul>
</li>
<li id="adminboost-modules">
    <a href="#admin-modules" class=""><i aria-hidden="true" class="fa fa-fw fa-cube"></i><span>{@menu.modules}</span></a>
    <ul>
        # IF C_ADMIN_LINKS_5 #
            # START admin_links_5 #
                # INCLUDE admin_links_5.MODULE_MENU #
            # END admin_links_5 #
        # ENDIF #
    </ul>
</li>
<li id="adminboost-content">
    <a href="#admin-content"><i aria-hidden="true" class="far fa-fw fa-square"></i><span>{@menu.minis}</span></a>
    <ul>
        # IF C_ADMIN_LINKS_6 #
            # START admin_links_6 #
                # INCLUDE admin_links_6.MODULE_MENU #
            # END admin_links_6 #
        # ENDIF #
    </ul>
</li>
