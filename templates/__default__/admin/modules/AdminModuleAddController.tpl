<!-- === /templates/__default__/admin/modules/AdminModuleAddController.tpl === -->
# INCLUDE MESSAGE_HELPER_WARNING #
# INCLUDE MESSAGE_HELPER_SUCCESS #
<header>
	<h2>{@addon.modules.add}</h2>
	<div class="message-helper bgc notice">{@addon.modules.warning.install}</div>
</header>
<div id="select-source" class="tabs-container">
	<nav class="tabs-nav">
		<ul class="tabs-items">
			<li><span class="tab-item first-tab --target-github">{@addon.add.tab.github}</span></li>
			<li><span class="tab-item --target-website">{@addon.add.tab.website}</span></li>
			<li><span class="tab-item --target-server">{@addon.add.tab.server}</span></li>
			<li><span class="tab-item --target-archive">{@addon.add.tab.archive}</span></li>
		</ul>
	</nav>
	<div class="tabs-wrapper">
		<div id="target-github" class="tab-content">
			<div class="addon-source-selector fieldset-content">
				# IF C_GITHUB_HAS_REPOS #
					<div class="addon-repo-selector">
						<label class="text-strong" for="github-repo-select">{@addon.github.choose.repo}</label>
						<select id="github-repo-select">
							# START github_repos #
								<option value="{github_repos.OWNER}" data-repo="{github_repos.REPO}" data-dir="{github_repos.DIR}">{github_repos.LABEL}</option>
							# END github_repos #
						</select>
					</div>
				# ENDIF #
				<details class="addon-custom-repo">
					<summary class="text-strong">{@addon.github.custom.repo}</summary>
					<div class="fieldset-content cell-flex cell-columns-3">
						<div>
							<label for="github-custom-owner">{@addon.repos.owner}</label>
							<input type="text" id="github-custom-owner" value="{GITHUB_DEFAULT_OWNER}" placeholder="owner" />
						</div>
						<div>
							<label for="github-custom-repo">{@addon.repos.repository}</label>
							<input type="text" id="github-custom-repo" value="{GITHUB_DEFAULT_REPO}" placeholder="repository" />
						</div>
						<div>
							<label for="github-custom-dir">{@addon.sub.directory}</label>
							<input type="text" id="github-custom-dir" value="{GITHUB_DEFAULT_DIR}" placeholder="{@addon.sub.directory.optional}" />
						</div>
					</div>
					<button id="github-btn-load" type="button" class="button submit">{@addon.github.load.repo}</button>
				</details>
			</div>
			<div id="github-addon-list" class="addon-remote-list">
				<div class="addon-list-loader"><i class="fa fa-spinner fa-spin" aria-hidden="true"></i> {@addon.loading}</div>
			</div>
		</div>

		<div id="target-website" class="tab-content">
			<div class="addon-source-selector fieldset-content">
				# IF C_WEBSITE_HAS_SERVERS #
					<div class="addon-repo-selector">
						<label class="text-strong" for="website-server-select">{@addon.website.choose.server}</label>
						<select id="website-server-select">
							# START website_servers #
								<option value="{website_servers.URL}" data-dir="{website_servers.DIR}">{website_servers.LABEL}</option>
							# END website_servers #
						</select>
					</div>
				# ENDIF #
				<details class="addon-custom-server">
					<summary class="text-strong">{@addon.website.custom.server}</summary>
					<div class="fieldset-content cell-flex cell-columns-2">
						<div>
							<label for="website-custom-url">{@addon.servers.url}</label>
							<input type="text" id="website-custom-url" value="{WEBSITE_DEFAULT_URL}" placeholder="https://example.com" />
						</div>
						<div>
							<label for="website-custom-dir">{@addon.sub.directory}</label>
							<input type="text" id="website-custom-dir" value="{WEBSITE_DEFAULT_DIR}" placeholder="{@addon.sub.directory.optional}" />
						</div>
					</div>
					<button id="website-btn-load" type="button" class="button submit">{@addon.website.load}</button>
				</details>
			</div>
			<div id="website-addon-list" class="addon-remote-list">
				<div class="addon-list-loader"><i class="fa fa-spinner fa-spin" aria-hidden="true"></i> {@addon.loading}</div>
			</div>
		</div>

		<div id="target-server" class="tab-content">
			<form action="{REWRITED_SCRIPT}" method="post" class="fieldset-content">
				<input type="hidden" name="token" value="{TOKEN}">
				<section id="not-installed-modules-container" class="addons-container modules-elements-container not-installed-elements-container">
					# IF C_MODULE_AVAILABLE #
						<div class="cell-flex cell-columns-4 cell-tile mini-checkbox">
							# START genres #
								<div>
									<header><h3>{genres.GENRE_NAME}</h3></header>
									<div class="cell-list cell cell-tile">
										<ul>
											# START genres.server_modules #
												<li class="li-stretch addon# IF NOT genres.server_modules.C_COMPATIBLE # not-compatible error# ENDIF #">
													<div id="module-{genres.server_modules.MODULE_NUMBER}" class="addon-name align-left">
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
													<div class="addon-infos">
														<span class="# IF genres.server_modules.C_COMPATIBLE #success# ELSE #error# ENDIF #" aria-label="{@addon.compatibility} PHPBoost">{genres.server_modules.COMPATIBILITY}</span>
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
														# IF genres.server_modules.C_COMPATIBLE #
															<button type="submit" class="button button-mini bgc-full logo-color" name="add-{genres.server_modules.MODULE_ID}" value="true" aria-label="{@addon.install}"><i class="fa fa-fw fa-arrows-spin" aria-hidden="true"></i></button>
														# ELSE #
															<button type="submit" class="button button-mini bgc-full error" name="add-{genres.server_modules.MODULE_ID}" onclick="return false;" aria-label="{@addon.not.compatible}"><i class="fa fa-fw fa-ban" aria-hidden="true"></i></button>
														# ENDIF #
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

<script>
(function () {
	var ajaxGithubList    = '{U_AJAX_GITHUB_LIST}';
	var ajaxWebsiteList   = '{U_AJAX_WEBSITE_LIST}';
	var ajaxInstall       = '{U_AJAX_INSTALL}';
	var csrfToken         = '{TOKEN}';

	// ---- Current state ----
	var gh = {
		owner: '{GITHUB_DEFAULT_OWNER}',
		repo:  '{GITHUB_DEFAULT_REPO}',
		dir:   '{GITHUB_DEFAULT_DIR}'
	};
	var ws = {
		url: '{WEBSITE_DEFAULT_URL}',
		dir: '{WEBSITE_DEFAULT_DIR}'
	};

	// ---- GitHub ----
	var ghSel = document.getElementById('github-repo-select');
	if (ghSel) {
		ghSel.addEventListener('change', function () {
			var opt = ghSel.options[ghSel.selectedIndex];
			gh.owner = opt.value;
			gh.repo  = opt.getAttribute('data-repo') || '';
			gh.dir   = opt.getAttribute('data-dir')  || '';
			document.getElementById('github-custom-owner').value = gh.owner;
			document.getElementById('github-custom-repo').value  = gh.repo;
			document.getElementById('github-custom-dir').value   = gh.dir;
			loadGithub();
		});
	}
	var ghBtn = document.getElementById('github-btn-load');
	if (ghBtn) {
		ghBtn.addEventListener('click', function () {
			gh.owner = document.getElementById('github-custom-owner').value;
			gh.repo  = document.getElementById('github-custom-repo').value;
			gh.dir   = document.getElementById('github-custom-dir').value;
			loadGithub();
		});
	}

	function loadGithub() {
		var container = document.getElementById('github-addon-list');
		setLoader(container);
		var url = ajaxGithubList
			+ '?repo_owner=' + encodeURIComponent(gh.owner)
			+ '&repo_name='  + encodeURIComponent(gh.repo)
			+ '&repo_dir='   + encodeURIComponent(gh.dir);
		fetch(url)
			.then(function (r) { return r.json(); })
			.then(function (data) { renderList(container, data, 'github', ${escapejs(@addon.github.no.addon.found)}); })
			.catch(function () { setError(container); });
	}

    // ---- Website ----
	var wsSel = document.getElementById('website-server-select');
	if (wsSel) {
		wsSel.addEventListener('change', function () {
			var opt = wsSel.options[wsSel.selectedIndex];
			ws.url = opt.value;
			ws.dir = opt.getAttribute('data-dir') || '';
			document.getElementById('website-custom-url').value = ws.url;
			document.getElementById('website-custom-dir').value = ws.dir;
			loadWebsite();
		});
	}
	var wsBtn = document.getElementById('website-btn-load');
	if (wsBtn) {
		wsBtn.addEventListener('click', function () {
			ws.url = document.getElementById('website-custom-url').value;
			ws.dir = document.getElementById('website-custom-dir').value;
			loadWebsite();
		});
	}

	function loadWebsite() {
		var container = document.getElementById('website-addon-list');
		setLoader(container);
		var url = ajaxWebsiteList
			+ '?server_url=' + encodeURIComponent(ws.url)
			+ '&server_dir=' + encodeURIComponent(ws.dir);
		fetch(url)
			.then(function (r) { return r.json(); })
			.then(function (data) { renderList(container, data, 'website', ${escapejs(@addon.website.no.addon.found)}); })
			.catch(function () { setError(container); });
	}

	// ---- List render ----
	function renderList(container, data, source, emptyMsg) {
    if (data.error && data.error !== null) {
        container.innerHTML = '<div class="message-helper bgc error">' + ${escapejs(@addon.source.error)} + '</div>';
        return;
    }

    var addons = data.addons || [];
    if (!addons.length) {
        container.innerHTML = '<div class="content"><div class="message-helper bgc notice message-helper-small">' + emptyMsg + '</div></div>';
        return;
    }

    // Group addons by genre
    var addonsByGenre = {};
    addons.forEach(function(addon) {
        if (!addonsByGenre[addon.genre]) {
            addonsByGenre[addon.genre] = [];
        }
        addonsByGenre[addon.genre].push(addon);
    });

    // Sort genres alphabetically
    var sortedGenres = Object.keys(addonsByGenre).sort();

    var html = '<div id="' + source + '-feedback"></div>';

    // Render each genre section
    sortedGenres.forEach(function(genre) {
        var genreAddons = addonsByGenre[genre];
        var compatibles = genreAddons.filter(function(a) { return a.compatible && !a.installed; });

        html += '<h2>' + esc(genre) + '</h2>';
        html += '<section class="addons-container modules-elements-container not-installed-elements-container">';
        html += '<div class="cell-list">';
        html += '<ul class="col-v-3">';

        genreAddons.forEach(function(addon) {
            var cls = addon.compatible ? '' : ' not-compatible error';
            if (addon.installed) cls += ' installed';
            html += '<li class="li-stretch addon' + cls + '">';
                html += '<div class="addon-name align-left mini-checkbox">';
                    if (compatibles.length > 1 && addon.compatible && !addon.installed) {
                        html += '<label class="checkbox" for="' + source + '-cb-' + esc(addon.id) + '">'
                            + '<input type="checkbox" class="add-checkbox" id="' + source + '-cb-' + esc(addon.id) + '" value="' + esc(addon.id) + '">'
                            + '<span>&nbsp;</span></label>';
                    }
                    html += esc(addon.name);
                html += '</div>';
                html += '<div class="addon-infos addon-large align-right">';
                    html += '<button onclick="return false;" class="modal-button --infos-module-' + esc(addon.id) + ' button button-mini" aria-label="' + ${escapejs(@common.informations)} + '"><i class="far fa-circle-question" aria-hidden="true"></i></button>';
                    html += '<div id="infos-module-' + esc(addon.id) + '" class="modal modal-full">';
                        html += '<div class="modal-overlay close-modal" aria-label="' + ${escapejs(@common.close)} + '"></div>';
                        html += '<div class="modal-content cell-list">';
                            html += '<span class="error big hide-modal close-modal" aria-label="' + ${escapejs(@common.close)} + '"><i class="far fa-circle-xmark" aria-hidden="true"></i></span>';
                            html += '<ul>';
                                html += '<li class="li-stretch">';
                                    if (addon.thumbnail) {
                                        html += '<img src="' + esc(addon.thumbnail) + '" alt="' + esc(addon.name) + '" class="addon-thumbnail" onerror="this.style.display=\'none\'">';
                                    } else if (addon.fa_icon) {
                                        html += '<i class="' + esc(addon.fa_icon) + '" aria-hidden="true"></i>';
                                    } else {
                                        html += '<i class="fa fa-fw fa-puzzle-piece" aria-hidden="true"></i>';
                                    }
                                    html += '<h2>' + esc(addon.name) + '</h2>';
                                html += '</li>';
                                html += '<li class="li-stretch"><span class="text-strong">{@common.description} :</span> ' + esc(addon.description) + '</li>';
                                html += '<li class="li-stretch"><span class="text-strong">{@common.author} :</span> ' + esc(addon.author) + '</li>';
                                html += '<li class="li-stretch"><span class="text-strong">{@common.version} :</span> ' + esc(addon.version) + '</li>';
                                if (addon.creation_date) {
                                    html += '<li class="li-stretch"><span class="text-strong">{@common.creation.date} :</span> ' + esc(addon.creation_date) + '</li>';
                                }
                                if (addon.last_update) {
                                    html += '<li class="li-stretch"><span class="text-strong">{@common.last.update} :</span> ' + esc(addon.last_update) + '</li>';
                                }
                            html += '</ul>';
                        html += '</div>';
                    html += '</div>';
                    html += ' <button class="button button-mini default ' + (addon.compatible ? 'success' : 'error') + '" aria-label="' + ${escapejs(@addon.compatibility)} + ' PHPBoost">' + esc(addon.compatibility) + '</button>';
                    if (source === 'github' && addon.repo_url) {
                        html += ' <a href="' + esc(addon.repo_url) + '" class="button button-mini default offload" target="_blank" rel="noopener" aria-label="' + ${escapejs(@addon.github.view.repo)} + '"><i class="fab fa-github fa-fw" aria-hidden="true"></i></a>';
                    }
                    if (addon.installed) {
                        html += ' <button onclick="return false;" class="button button-mini bgc-full success" aria-label="' + ${escapejs(@addon.already.installed)} + '"><i class="fa fa-fw fa-check" aria-hidden="true"></i></button>';
                    } else if (addon.compatible) {
                        html += ' <button type="button" class="button button-mini bgc-full logo-color btn-install-one" data-id="' + esc(addon.id) + '" data-source="' + source + '" aria-label="' + ${escapejs(@addon.install)} + '"><i class="fa fa-fw fa-arrows-spin" aria-hidden="true"></i></button>';
                    } else {
                        html += ' <button type="button" class="button button-mini bgc-full error" disabled aria-label="' + ${escapejs(@addon.not.compatible)} + '"><i class="fa fa-fw fa-ban" aria-hidden="true"></i></button>';
                    }
                html += '</div>';
            html += '</li>';
        });

        html += '</ul></div><footer></footer></section>';
    });

    container.innerHTML = html;

    // Check all checkboxes
    var checkAll = document.getElementById(source + '-check-all');
    if (checkAll) {
        checkAll.addEventListener('change', function() {
            container.querySelectorAll('.add-checkbox').forEach(function(cb) { cb.checked = checkAll.checked; });
        });
    }

    // Install one addon
    container.querySelectorAll('.btn-install-one').forEach(function(btn) {
        btn.addEventListener('click', function() {
            install([btn.getAttribute('data-id')], btn.getAttribute('data-source'));
        });
    });

    // Install selected addons
    var btnSel = document.getElementById(source + '-install-sel');
    if (btnSel) {
        btnSel.addEventListener('click', function() {
            var ids = [];
            container.querySelectorAll('.add-checkbox:checked').forEach(function(cb) { ids.push(cb.value); });
            if (ids.length) install(ids, source);
        });
    }
}

	// ---- Installation ----
	function install(ids, source) {
		var feedback = document.getElementById(source + '-feedback');
		feedback.innerHTML = '<div class="addon-list-loader"><i class="fa fa-spinner fa-spin" aria-hidden="true"></i> ' + ${escapejs(@addon.installing)} + '</div>';

		var body = 'token=' + encodeURIComponent(csrfToken) + '&source=' + encodeURIComponent(source);
		if (source === 'github') {
			body += '&repo_owner=' + encodeURIComponent(gh.owner)
				+ '&repo_name='    + encodeURIComponent(gh.repo)
				+ '&repo_dir='     + encodeURIComponent(gh.dir);
		} else {
			body += '&server_url=' + encodeURIComponent(ws.url)
				+ '&server_dir='   + encodeURIComponent(ws.dir);
		}
		ids.forEach(function (id) { body += '&addon_ids[]=' + encodeURIComponent(id); });

		fetch(ajaxInstall, {
			method: 'POST',
			headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
			body: body
		})
		.then(function (r) { return r.json(); })
		.then(function (data) {
			var results = data.results || {};
			var html = '';
			Object.keys(results).forEach(function (id) {
				var r   = results[id];
				var cls = r.success ? 'success' : 'warning';
				html += '<div class="message-helper bgc ' + cls + '"><b>' + esc(id) + '</b> : ' + esc(r.msg_key) + '</div>';
			});
			feedback.innerHTML = html;
			if (source === 'github') loadGithub(); else loadWebsite();
		})
		.catch(function () { setError(document.getElementById(source + '-feedback')); });
	}

	function setLoader(el) {
		el.innerHTML = '<div class="addon-list-loader"><i class="fa fa-spinner fa-spin" aria-hidden="true"></i> ' + ${escapejs(@addon.loading)} + '</div>';
	}
	function setError(el) {
		el.innerHTML = '<div class="message-helper bgc error">' + ${escapejs(@addon.source.error)} + '</div>';
	}
	function esc(s) {
		return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
	}

	//  Automatic loading from the tab made visible
	// TabsBoost hides the divs, on lazy-load at the first activation
	var ghLoaded = false, wsLoaded = false;
	var observer = new MutationObserver(function (mutations) {
		mutations.forEach(function (m) {
			if (m.target.id === 'target-github' && m.target.classList.contains('current-tab') && !ghLoaded) {
				ghLoaded = true; loadGithub();
			}
			if (m.target.id === 'target-website' && m.target.classList.contains('current-tab') && !wsLoaded) {
				wsLoaded = true; loadWebsite();
			}
		});
	});
	var ghDiv = document.getElementById('target-github');
	var wsDiv = document.getElementById('target-website');
	if (ghDiv) observer.observe(ghDiv, { attributes: true, attributeFilter: ['class'] });
	if (wsDiv) observer.observe(wsDiv, { attributes: true, attributeFilter: ['class'] });

	// If github is the first tab displayed at startup, load immediately
	document.addEventListener('DOMContentLoaded', function () {
		if (ghDiv && ghDiv.classList.contains('current-tab') && !ghLoaded) {
			ghLoaded = true; loadGithub();
		}
	});
}());
</script>
