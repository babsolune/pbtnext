# INCLUDE MESSAGE_HELPER_WARNING #
# INCLUDE MESSAGE_HELPER_SUCCESS #
<header>
    <h2>{@addon.modules.add}</h2>
    <div class="message-helper bgc notice">{@addon.modules.warning.install}</div>
</header>
<div id="select-source" class="tabs-container">
    <nav class="tabs-nav">
        <ul class="tabs-items">
            <li><span class="tab-item --target-github">{@addon.modules.add.tab.github}</span></li>
            <li><span class="tab-item --target-website">{@addon.modules.add.tab.website}</span></li>
            <li><span class="tab-item --target-server">{@addon.modules.add.tab.server}</span></li>
            <li><span class="tab-item --target-archive">{@addon.modules.add.tab.archive}</span></li>
        </ul>
    </nav>
    <div class="tabs-wrapper">
        <div id="target-github" class="tab-content"></div>
        <div id="target-website" class="tab-content"></div>
        <div id="target-server" class="tab-content">
            <form action="{REWRITED_SCRIPT}" method="post" class="fieldset-content">
                <input type="hidden" name="token" value="{TOKEN}">
                <section id="not-installed-modules-container" class="addons-container modules-elements-container not-installed-elements-container">
                    # IF C_MODULE_AVAILABLE #
                        <div class="cell-flex cell-columns-4 cell-tile">
                            # START genres #
                                <div>
                                    <header><h3>{genres.GENRE_NAME}</h3></header>
                                    <div class="cell-list cell cell-tile">
                                        <ul>
                                            # START genres.server_modules #
                                                <li class="li-stretch addon# IF NOT genres.server_modules.C_COMPATIBLE # not-compatible error# ENDIF #">
                                                    <div class="align-left" id="module-{genres.server_modules.MODULE_NUMBER}">
                                                        # IF C_SEVERAL_MODULES_AVAILABLE #
                                                            # IF genres.server_modules.C_COMPATIBLE #
                                                                    <label class="checkbox" for="multiple-checkbox-{genres.server_modules.MODULE_NUMBER}">
                                                                        <input type="checkbox" class="multiple-checkbox add-checkbox" id="multiple-checkbox-{genres.server_modules.MODULE_NUMBER}" name="add-checkbox-{genres.server_modules.MODULE_NUMBER}"/>
                                                                        <span>&nbsp;</span>
                                                                    </label>
                                                            # ENDIF #
                                                        # ENDIF #
                                                        {genres.server_modules.MODULE_NAME}
                                                    </div>
                                                    <div>
                                                        <span aria-label="{@addon.compatibility} PHPBoost">{genres.server_modules.COMPATIBILITY}</span>
                                                        <button onclick="return false;" class="button button-mini default modal-button --infos-module-{genres.server_modules.MODULE_NUMBER}" aria-label="{@common.informations}"><i class="far fa-circle-question" aria-hidden="true"></i></button>
                                                        <div id="infos-module-{genres.server_modules.MODULE_NUMBER}" class="modal modal-half">
                                                            <div class="modal-overlay close-modal" aria-label="{@common.close}"></div>
                                                            <div class="modal-content">
                                                                <span class="error big hide-modal close-modal" aria-label="{@common.close}"><i class="far fa-circle-xmark" aria-hidden="true"></i></span>
                                                                <div class="cell-list">
                                                                    <ul>
                                                                        <li class="li-stretch">
                                                                            <h2>
                                                                                # IF genres.server_modules.C_THUMBNAIL #
                                                                                    <img src="{genres.server_modules.THUMBNAIL_URL}" alt="{genres.server_modules.MODULE_NAME} thumbnail" class="addon-thumbnail" />
                                                                                # ELSEIF genres.server_modules.C_FA_ICON #
                                                                                    <i class="fa {genres.server_modules.FA_ICON}" aria-hidden="true"></i>
                                                                                # ELSEIF genres.server_modules.C_HEXA_ICON #
                                                                                    <span class="hexa-icon bigger">{genres.server_modules.HEXA_ICON}</span>
                                                                                # ELSE #
                                                                                    <i class="far fa-fw fa-puzzle-piece" aria-hidden="true"></i>
                                                                                # ENDIF #
                                                                                {genres.server_modules.MODULE_NAME}
                                                                            </h2>
                                                                        </li>
                                                                        <li class="li-stretch">
                                                                            <span class="text-strong">{@common.author} :</span>
                                                                            <span>
                                                                                {genres.server_modules.AUTHOR}
                                                                                # IF genres.server_modules.C_AUTHOR_EMAIL # <a href="mailto:{genres.server_modules.AUTHOR_EMAIL}" class="pinned bgc notice" aria-label="{@common.email}"><i class="fa iboost fa-iboost-email fa-fw" aria-hidden="true"></i></a># ENDIF #
                                                                                # IF genres.server_modules.C_AUTHOR_WEBSITE # <a href="{genres.server_modules.AUTHOR_WEBSITE}" class="pinned bgc question" aria-label="{@common.website}"><i class="fa fa-share-square fa-fw" aria-hidden="true"></i></a> # ENDIF #
                                                                            </span>
                                                                        </li>
                                                                        <li class="li-stretch">
                                                                            <span class="text-strong">{@common.version}</span>
                                                                            {genres.server_modules.VERSION}
                                                                        </li>
                                                                        <li class="li-stretch">
                                                                            <span class="text-strong">{@common.creation.date} :</span>
                                                                            {genres.server_modules.CREATION_DATE}
                                                                        </li>
                                                                        <li class="li-stretch">
                                                                            <span class="text-strong">{@common.last.update} :</span>
                                                                            {genres.server_modules.LAST_UPDATE}
                                                                        </li>
                                                                        <li>
                                                                            <span class="text-strong">{@common.description} :</span>
                                                                            {genres.server_modules.DESCRIPTION}
                                                                        </li>
                                                                        <li class="li-stretch">
                                                                            <span class="text-strong">{@addon.modules.php.version} :</span>
                                                                            {genres.server_modules.PHP_VERSION}
                                                                        </li>
                                                                        # IF NOT genres.server_modules.C_COMPATIBLE_ADDON #
                                                                            <li class="bgc-full error">{@addon.modules.not.module}</li>
                                                                        # ENDIF #
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="addon-menu-container">
                                                            # IF genres.server_modules.C_COMPATIBLE #
                                                                <button type="submit" class="button button-mini submit" name="add-{genres.server_modules.MODULE_ID}" value="true">{@addon.install}</button>
                                                            # ELSE #
                                                                <span class="addon-menu-title bgc-full error">{@addon.not.compatible}</span>
                                                            # ENDIF #
                                                        </div>
                                                    </div>
                                                </li>
                                            # END genres.server_modules #
                                        </ul>
                                    </div>
                                </div>
                            # END genres #
                        </div>
                    # ELSE #
                        <div class="content">
                            <div class="message-helper bgc notice message-helper-small">{@common.no.item.now}</div>
                        </div>
                    # ENDIF #
                    <footer></footer>
                </section>
                # IF C_SEVERAL_MODULES_AVAILABLE #
                    <div class="multiple-select-button select-all-checkbox mini-checkbox inline-checkbox bgc-full link-color">
                        <label class="checkbox" for="add-all-checkbox">
                            <input type="checkbox" class="check-all" id="add-all-checkbox" name="add-all-checkbox" onclick="multiple_checkbox_check(this.checked, {MODULES_NUMBER}, null, false);" />
                            <span aria-label="{@addon.modules.select.all}">&nbsp;</span>
                        </label>
                        <button type="submit" name="add-selected-modules" value="true" class="button submit select-all-button">{@addon.multiple.install}</button>
                    </div>
                # ENDIF #
            </form>
        </div>
        <div id="target-archive" class="tab-content"># INCLUDE CONTENT #</div>
    </div>
</div>
