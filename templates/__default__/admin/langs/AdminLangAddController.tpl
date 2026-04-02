# INCLUDE MESSAGE_HELPER_WARNING #
# INCLUDE MESSAGE_HELPER_SUCCESS #
<header>
	<h2>{@addon.langs.add}</h2>
	<div class="message-helper bgc notice">{@addon.langs.warning.install}</div>
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

		<!-- ==================== GITHUB ==================== -->
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

		<!-- ==================== WEBSITE ==================== -->
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

		<!-- ==================== SERVER ==================== -->
		<div id="target-server" class="tab-content">
<form action="{REWRITED_SCRIPT}" method="post" class="fieldset-content">
	<input type="hidden" name="token" value="{TOKEN}">
	<section id="not-installed-langs-container" class="addons-container langs-elements-container not-installed-elements-container">
		<header class="legend">{@addon.langs.available}</header>
		# IF C_LANG_AVAILABLE #
			<div class="cell-flex cell-columns-3 cell-tile">
				# START langs_not_installed #
					<article class="cell addon# IF NOT langs_not_installed.C_COMPATIBLE # not-compatible bgc error# ENDIF #">
						<header class="cell-header">
							# IF C_SEVERAL_LANGS_AVAILABLE #
								# IF langs_not_installed.C_COMPATIBLE #
									<div class="mini-checkbox">
										<label class="checkbox" for="multiple-checkbox-{langs_not_installed.LANG_NUMBER}">
											<input type="checkbox" class="multiple-checkbox add-checkbox" id="multiple-checkbox-{langs_not_installed.LANG_NUMBER}" name="add-checkbox-{langs_not_installed.LANG_NUMBER}"/>
											<span>&nbsp;</span>
										</label>
									</div>
								# ENDIF #
							# ENDIF #
							# IF langs_not_installed.C_HAS_THUMBNAIL #
								<img src="{langs_not_installed.U_THUMBNAIL}" alt="{langs_not_installed.NAME}" class="flag-icon" />
							# ENDIF #
							<h3 class="cell-name">
								{langs_not_installed.NAME}
							</h3>
							<div class="addon-menu-container">
								# IF langs_not_installed.C_COMPATIBLE #
									<button type="submit" class="button submit addon-menu-title" name="add-{langs_not_installed.ID}" value="true">{@addon.install}</button>
								# ELSE #
									<span class="addon-menu-title bgc-full error">{@addon.not.compatible}</span>
								# ENDIF #
							</div>
						</header>

						<div class="cell-list">
							<ul>
								<li class="li-stretch">
									<span class="text-strong">{@common.version} :</span>
									{langs_not_installed.VERSION}
								</li>
								<li class="li-stretch">
									<span class="text-strong">{@addon.compatibility} :</span>
									<span # IF NOT langs_not_installed.C_COMPATIBLE_VERSION # class="bgc-full error"# ENDIF #>PHPBoost {langs_not_installed.COMPATIBILITY}</span>
								</li>
								<li class="li-stretch">
									<span class="text-strong">{@common.author} :</span>
									<span>
										{langs_not_installed.AUTHOR}
										# IF langs_not_installed.C_AUTHOR_EMAIL # <a href="mailto:{langs_not_installed.AUTHOR_EMAIL}" class="pinned bgc notice" aria-label="{@common.email}"><i class="fa iboost fa-iboost-email fa-fw" aria-hidden="true"></i></a># ENDIF #
										# IF langs_not_installed.C_AUTHOR_WEBSITE # <a href="{langs_not_installed.AUTHOR_WEBSITE}" class="pinned bgc question" aria-label="{@common.website}"><i class="fa fa-share-square fa-fw" aria-hidden="true"></i></a> # ENDIF #
									</span>
								</li>
                                # IF NOT langs_not_installed.C_COMPATIBLE_ADDON #
                                    <li class="bgc-full error">{@addon.langs.not.lang}</li>
                                # ENDIF #
							</ul>
						</div>

						<footer class="cell-footer">
							# IF langs_not_installed.C_COMPATIBLE #
								<div class="addon-auth-container">
									<a href="#" class="addon-auth" aria-label="{@addon.authorizations}"><i class="fa fa-user-shield" aria-hidden="true"></i></a>
									<div class="addon-auth-content">
										{langs_not_installed.AUTHORIZATIONS}
										<a href="#" class="addon-auth-close" aria-label="{@common.close}"><i class="fa fa-times" aria-hidden="true"></i></a>
									</div>
								</div>
							# ENDIF #
						</footer>
					</article>
				# END langs_not_installed #
			</div>
		# ELSE #
			<div class="content">
				<div class="message-helper bgc notice message-helper-small">{@common.no.item.now}</div>
			</div>
		# ENDIF #
		<footer></footer>
	</section>
	# IF C_SEVERAL_LANGS_AVAILABLE #
		<div class="multiple-select-button select-all-checkbox mini-checkbox inline-checkbox bgc-full link-color">
			<label class="checkbox" for="add-all-checkbox">
				<input type="checkbox" class="check-all" id="add-all-checkbox" name="add-all-checkbox" onclick="multiple_checkbox_check(this.checked, {LANGS_NUMBER}, null, false);" />
				<span aria-label="{@addon.langs.select.all}">&nbsp;</span>
			</label>
			<button type="submit" name="add-selected-langs" value="true" class="button submit select-all-button">{@addon.multiple.install}</button>
		</div>
	# ENDIF #
</form>
<script>
	opensubmenu('.addon-auth', {
		osmTarget: '.addon-auth-container',
		osmCloseExcept: '.addon-auth-content *',
		osmCloseButton: '.addon-auth-close i',
	});
</script>

		</div>

		<!-- ==================== ARCHIVE ==================== -->
		<div id="target-archive" class="tab-content"># INCLUDE CONTENT #</div>

	</div>
</div>

<script>
(function () {
	var ajaxGithubList    = '{U_AJAX_GITHUB_LIST}';
	var ajaxWebsiteList   = '{U_AJAX_WEBSITE_LIST}';
	var ajaxInstall       = '{U_AJAX_INSTALL}';
	var csrfToken         = '{TOKEN}';

	// ---- État courant ----
	var gh = {
		owner: '{GITHUB_DEFAULT_OWNER}',
		repo:  '{GITHUB_DEFAULT_REPO}',
		dir:   '{GITHUB_DEFAULT_DIR}'
	};
	var ws = {
		url: '{WEBSITE_DEFAULT_URL}',
		dir: '{WEBSITE_DEFAULT_DIR}'
	};

	// ---- Sélecteur dépôt GitHub ----
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

	// ---- Sélecteur serveur Website ----
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

	// ---- Chargement GitHub ----$
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

	// ---- Chargement Website ----
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

	// ---- Rendu de liste ----
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
		var pfx         = source;
		var compatibles = addons.filter(function (a) { return a.compatible && !a.installed; });

		var html = '<div id="' + pfx + '-feedback"></div>';
		html += '<section class="addons-container modules-elements-container not-installed-elements-container">';
		html += '<div class="cell-list">';
		html += '<ul class="col-v-3">';

		addons.forEach(function (addon) {
			var cls = addon.compatible ? '' : ' not-compatible error';
			if (addon.installed) cls += ' installed';
			html += '<li class="li-stretch addon' + cls + '">';
			html += '<div class="addon-name align-left mini-checkbox">';
			if (compatibles.length > 1 && addon.compatible && !addon.installed) {
				html += '<label class="checkbox" for="' + pfx + '-cb-' + esc(addon.id) + '">'
					+ '<input type="checkbox" class="add-checkbox" id="' + pfx + '-cb-' + esc(addon.id) + '" value="' + esc(addon.id) + '">'
					+ '<span>&nbsp;</span></label>';
			}
			if (addon.thumbnail) {
				html += '<img src="' + esc(addon.thumbnail) + '" alt="' + esc(addon.name) + '" class="addon-thumbnail" onerror="this.style.display=\'none\'">';
			} else {
				html += '<i class="far fa-fw fa-puzzle-piece" aria-hidden="true"></i>';
			}
			html += esc(addon.name) + '</div>';
			html += '<div class="addon-infos">';
			html += '<span class="' + (addon.compatible ? 'success' : 'error') + '" aria-label="' + ${escapejs(@addon.compatibility)} + ' PHPBoost">' + esc(addon.compatibility) + '</span>';
			if (source === 'github' && addon.repo_url) {
				html += '<a href="' + esc(addon.repo_url) + '" class="button button-mini default offload" target="_blank" rel="noopener" aria-label="' + ${escapejs(@addon.github.view.repo)} + '"><i class="fab fa-github fa-fw" aria-hidden="true"></i></a>';
			}
			if (addon.installed) {
				html += '<span class="button button-mini bgc-full success" aria-label="' + ${escapejs(@addon.already.installed)} + '"><i class="fa fa-fw fa-check" aria-hidden="true"></i></span>';
			} else if (addon.compatible) {
				html += '<button type="button" class="button button-mini bgc-full logo-color btn-install-one" data-id="' + esc(addon.id) + '" data-source="' + pfx + '" aria-label="' + ${escapejs(@addon.install)} + '"><i class="fa fa-fw fa-arrows-spin" aria-hidden="true"></i></button>';
			} else {
				html += '<button type="button" class="button button-mini bgc-full error" disabled aria-label="' + ${escapejs(@addon.not.compatible)} + '"><i class="fa fa-fw fa-ban" aria-hidden="true"></i></button>';
			}
			html += '</div></li>';
		});

		html += '</ul></div><footer></footer></section>';

		if (compatibles.length > 1) {
			html += '<div class="multiple-select-button select-all-checkbox mini-checkbox inline-checkbox bgc-full link-color">'
				+ '<label class="checkbox" for="' + pfx + '-check-all">'
				+ '<input type="checkbox" id="' + pfx + '-check-all">'
				+ '<span aria-label="' + ${escapejs(@addon.langs.select.all)} + '">&nbsp;</span></label>'
				+ '<button type="button" id="' + pfx + '-install-sel" class="button submit select-all-button">' + ${escapejs(@addon.multiple.install)} + '</button>'
				+ '</div>';
		}

		container.innerHTML = html;

		// Tout cocher
		var checkAll = document.getElementById(pfx + '-check-all');
		if (checkAll) {
			checkAll.addEventListener('change', function () {
				container.querySelectorAll('.add-checkbox').forEach(function (cb) { cb.checked = checkAll.checked; });
			});
		}

		// Installer un seul
		container.querySelectorAll('.btn-install-one').forEach(function (btn) {
			btn.addEventListener('click', function () {
				install([btn.getAttribute('data-id')], btn.getAttribute('data-source'));
			});
		});

		// Installer la sélection
		var btnSel = document.getElementById(pfx + '-install-sel');
		if (btnSel) {
			btnSel.addEventListener('click', function () {
				var ids = [];
				container.querySelectorAll('.add-checkbox:checked').forEach(function (cb) { ids.push(cb.value); });
				if (ids.length) install(ids, pfx);
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

	// Chargement automatique dès l'onglet rendu visible
	// TabsBoost cache les divs, on lazy-load à la première activation
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

	// Si github est le premier onglet affiché au démarrage, charger immédiatement
	document.addEventListener('DOMContentLoaded', function () {
		if (ghDiv && ghDiv.classList.contains('current-tab') && !ghLoaded) {
			ghLoaded = true; loadGithub();
		}
	});
}());
</script>
