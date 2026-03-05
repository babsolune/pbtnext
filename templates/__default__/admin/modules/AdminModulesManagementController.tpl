# INCLUDE MESSAGE_HELPER #
# START errors #
	# INCLUDE errors.MESSAGE_HELPER #
# END errors #

<div class="text-helper">
	<span class="message-helper bgc warning">{@H|addon.modules.warning.delete}</span>
	<span class="message-helper bgc notice">{@addon.modules.warning.install}</span>
</div>
<form action="{REWRITED_SCRIPT}" method="post">
	<section id="installed-modules-container">
        <header class="legend">{@addon.modules.installed}</header>
        <div class="cell-flex cell-columns-2">
            # START genres #
                <div class="responsive-table">
                    <table class="table">
                        <caption>{genres.GENRE_NAME}</caption>
                        <thead>
                            <tr>
                                # IF C_SEVERAL_MODULES_INSTALLED #
                                    <th></th>
                                # ENDIF #
                                <th>{@common.name}</th>
                                <th>{@common.version}</th>
                                <th>{@addon.compatibility}</th>
                                <th>{@common.status}</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            # START genres.modules #
                                <tr class="addon-row addon# IF NOT genres.modules.C_IS_ACTIVATED # disabled-addon# ENDIF ## IF NOT genres.modules.C_COMPATIBLE # not-compatible error# ENDIF #">
                                    # IF C_SEVERAL_MODULES_INSTALLED #
                                        # IF genres.modules.C_COMPATIBLE #
                                            <td class="align-center">
                                                <label class="checkbox" for="multiple-checkbox-{genres.modules.MODULE_NUMBER}">
                                                    <input type="checkbox" id="multiple-checkbox-{genres.modules.MODULE_NUMBER}" name="delete-checkbox-{genres.modules.MODULE_NUMBER}"/>
                                                    <span>&nbsp;</span>
                                                </label>
                                            </td>
                                        # ENDIF #
                                    # ENDIF #
                                    <td class="align-left" id="module-{genres.modules.MODULE_NUMBER}">
                                        <div class="flex-between">
                                            <div class="name">
                                                # IF genres.modules.C_THUMBNAIL #
                                                    <img src="{genres.modules.THUMBNAIL_URL}" alt="{genres.modules.MODULE_NAME} thumbnail" class="addon-thumbnail" />
                                                # ELSEIF genres.modules.C_FA_ICON #
                                                    <i class="fa {genres.modules.FA_ICON}" aria-hidden="true"></i>
                                                # ELSEIF genres.modules.C_HEXA_ICON #
                                                    <span class="hexa-icon bigger">{genres.modules.HEXA_ICON}</span>
                                                # ELSE #
                                                    <i class="far fa-fw fa-puzzle-piece" aria-hidden="true"></i>
                                                # ENDIF #
                                                {genres.modules.MODULE_NAME}
                                            </div>
                                            <span class="modal-button --infos-module-{genres.modules.MODULE_NUMBER}" aria-label="{@common.informations}"><i class="far fa-circle-question" aria-hidden="true"></i></span>
                                            <div id="infos-module-{genres.modules.MODULE_NUMBER}" class="modal modal-half">
                                                <div class="modal-overlay close-modal" aria-label="{@common.close}"></div>
                                                <div class="modal-content">
                                                    <span class="error big hide-modal close-modal" aria-label="{@common.close}"><i class="far fa-circle-xmark" aria-hidden="true"></i></span>
                                                    <div class="cell-list">
                                                        <ul>
                                                            <li class="li-stretch">
                                                                <h2>
                                                                    # IF genres.modules.C_THUMBNAIL #
                                                                        <img src="{genres.modules.THUMBNAIL_URL}" alt="{genres.modules.MODULE_NAME} thumbnail" class="addon-thumbnail" />
                                                                    # ELSEIF genres.modules.C_FA_ICON #
                                                                        <i class="fa {genres.modules.FA_ICON}" aria-hidden="true"></i>
                                                                    # ELSEIF genres.modules.C_HEXA_ICON #
                                                                        <span class="hexa-icon bigger">{genres.modules.HEXA_ICON}</span>
                                                                    # ELSE #
                                                                        <i class="far fa-fw fa-puzzle-piece" aria-hidden="true"></i>
                                                                    # ENDIF #
                                                                    {genres.modules.MODULE_NAME}
                                                                </h2>
                                                                <button onclick="window.open('{genres.modules.U_DOCUMENTATION}', '_blank', 'noopener'); return false;" class="button button-mini bgc submit" aria-label="{@addon.modules.documentation}"><i class="fa fa-fw fa-book" aria-hidden="true"></i></button></a>
                                                            </li>
                                                            <li class="li-stretch">
                                                                <span class="text-strong">{@common.author} :</span>
                                                                <span>
                                                                    {genres.modules.AUTHOR}
                                                                    # IF genres.modules.C_AUTHOR_EMAIL # <a href="mailto:{genres.modules.AUTHOR_EMAIL}" class="pinned bgc notice" aria-label="{@common.email}"><i class="fa iboost fa-iboost-email fa-fw" aria-hidden="true"></i></a># ENDIF #
                                                                    # IF genres.modules.C_AUTHOR_WEBSITE # <a href="{genres.modules.AUTHOR_WEBSITE}" class="pinned bgc question" aria-label="{@common.website}"><i class="fa fa-share-square fa-fw" aria-hidden="true"></i></a> # ENDIF #
                                                                </span>
                                                            </li>
                                                            <li class="li-stretch">
                                                                <span class="text-strong">{@common.creation.date} :</span>
                                                                {genres.modules.CREATION_DATE}
                                                            </li>
                                                            <li class="li-stretch">
                                                                <span class="text-strong">{@common.last.update} :</span>
                                                                {genres.modules.LAST_UPDATE}
                                                            </li>
                                                            <li>
                                                                <span class="text-strong">{@common.description} :</span>
                                                                {genres.modules.DESCRIPTION}
                                                            </li>
                                                            <li class="li-stretch">
                                                                <span class="text-strong">{@addon.modules.php.version} :</span>
                                                                {genres.modules.PHP_VERSION}
                                                            </li>
                                                            # IF NOT genres.modules.C_COMPATIBLE_ADDON #
                                                                <li class="bgc-full error">{@addon.modules.not.module}</li>
                                                            # ENDIF #
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>{genres.modules.VERSION}</td>
                                    <td# IF NOT genres.modules.C_COMPATIBLE_VERSION # class="not-compatible bgc-full error"# ENDIF #>{genres.modules.COMPATIBILITY}</td>
                                    <td>
                                        # IF genres.modules.C_COMPATIBLE #
                                            # IF genres.modules.C_IS_ACTIVATED #
                                                <span class="success">{@common.enabled}</span>
                                            # ELSE #
                                                <span class="warning">{@common.disabled}</span>
                                            # ENDIF #
                                        # ELSE #
                                            <span class="error">{@addon.not.compatible}</span>
                                        # ENDIF #
                                    </td>
                                    <td>
                                        # IF genres.modules.C_COMPATIBLE #
                                            # IF genres.modules.C_IS_ACTIVATED #
                                                <button type="submit" class="button button-mini bgc-full notice" name="disable-{genres.modules.MODULE_ID}" aria-label="{@H|addon.module.disable}" value="true"><i class="far fa-fw fa-eye-slash" aria-hidden="true"></i></button>
                                            # ELSE #
                                                <button type="submit" class="button button-mini bgc-full success" name="enable-{genres.modules.MODULE_ID}" aria-label="{@common.enable}" value="true"><i class="far fa-fw fa-eye" aria-hidden="true"></i></button>
                                            # ENDIF #
                                        # ENDIF #
                                        # IF C_IS_LOCALHOST #
                                            <button type="submit" class="button button-mini bgc-full warning" name="uninstall-{genres.modules.MODULE_ID}" aria-label="{@H|addon.module.uninstall}" value="true" data-confirmation="uninstall-element"><i class="fa fa-fw fa-ban" aria-hidden="true"></i></button>
                                        # ENDIF #
                                        <button type="submit" class="button button-mini bgc-full error" name="delete-{genres.modules.MODULE_ID}" aria-label="{@H|addon.module.delete}" value="true" data-confirmation="delete-element"><i class="far fa-fw fa-trash-can" aria-hidden="true"></i></button>
                                    </td>
                                </tr>
                            # END genres.modules #
                        </tbody>
                    </table>
                </div>
            # END genres #
        </div>
		<footer>
			<input type="hidden" name="token" value="{TOKEN}">
		</footer>
	</section>

	# IF C_SEVERAL_MODULES_INSTALLED #
        <div class="addon-menu-container multiple-select-menu-container">
            <a href="#" class="multiple-select-menu addon-menu-title bgc-full link-color">{@addon.multiple.select}</a>
            <ul class="addon-menu-content">
                <li class="addon-menu-checkbox mini-checkbox select-all-checkbox bgc-full link-color">
                    <label class="checkbox" for="toggle-all-checkbox">
                        <input type="checkbox" class="check-all" id="toggle-all-checkbox" name="toggle-all-checkbox" onclick="multiple_checkbox_check(this.checked, {MODULES_NUMBER}, null, false);" />
                        <span aria-label="{@addon.modules.select.all}">&nbsp;</span>
                    </label>
                </li>
                <li class="addon-menu-item"><button type="submit" name="activate-selected-modules" value="true" class="button bgc-full success" id="activate-all-button">{@addon.multiple.enable}</button></li>
                <li class="addon-menu-item"><button type="submit" name="deactivate-selected-modules" value="true" class="button bgc-full notice" id="deactivate-all-button">{@addon.multiple.disable}</button></li>
                # IF C_IS_LOCALHOST #
                    <li class="addon-menu-item"><button type="submit" name="uninstall-selected-modules" value="true" class="button bgc-full warning" id="uninstall-all-button" data-confirmation="uninstall-elements">{@addon.multiple.uninstall}</button></li>
                # ENDIF #
                <li class="addon-menu-item"><button type="submit" name="delete-selected-modules" value="true" class="button bgc-full error" id="delete-all-button" data-confirmation="delete-elements">{@addon.multiple.delete}</button></li>
            </ul>
        </div>
	# ENDIF #
</form>

<script>
	opensubmenu('.addon-menu-title', {
		osmTarget: '.addon-menu-title',
		osmCloseExcept : '.addon-menu-checkbox, .addon-menu-checkbox *'
	});

	opensubmenu('.addon-auth', {
		osmTarget: '.addon-auth-container',
		osmCloseExcept: '.addon-auth-content *',
		osmCloseButton: '.addon-auth-close i',
	});
</script>
