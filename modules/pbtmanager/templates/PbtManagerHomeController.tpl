# INCLUDE MESSAGE_HELPER #

<div class="pbtm-container">

    <!-- ===================== ONGLETS ===================== -->
    <div class="pbtm-tabs">
        <button class="pbtm-tab active" data-tab="local">{L_MODULES}</button>
        <button class="pbtm-tab" data-tab="remote">{L_REMOTE_TITLE}</button>
        # IF C_IS_ADMIN #
        <a class="pbtm-tab" href="{U_CONFIG}">{L_CONFIG}</a>
        # ENDIF #
    </div>

    <!-- ===================== ONGLET 1 : MODULES INSTALLÉS ===================== -->
    <section class="pbtm-section pbtm-tab-content active" id="pbtm-tab-local">

        <div class="pbtm-toolbar">
            <button type="button" class="pbtm-btn pbtm-btn-secondary" id="pbtm-refresh-local">&#x21bb; {L_REFRESH}</button>
        </div>

        <div class="pbtm-table-wrapper">
            <table class="pbtm-table" id="pbtm-local-table">
                <thead>
                    <tr>
                        <th>{L_COL_NAME}</th>
                        <th>{L_COL_VERSION}</th>
                        <th>{L_COL_STATUS}</th>
                        <th>{L_COL_REMOTE}</th>
                        <th>{L_COL_ACTIONS}</th>
                    </tr>
                </thead>
                <tbody>
                    {MODULE_ROWS}
                </tbody>
            </table>
        </div>
    </section>

    <!-- ===================== ONGLET 2 : DÉPÔTS DISTANTS ===================== -->
    <section class="pbtm-section pbtm-tab-content" id="pbtm-tab-remote">

        <!-- Panneau ajout de dépôt -->
        <div class="pbtm-add-repo-panel" id="pbtm-add-repo-panel" style="display:none;">
            <strong>{L_REPO_ADD}</strong>
            <div class="pbtm-remote-controls" style="margin-top:.75rem;">
                <div class="pbtm-control-group">
                    <label>{L_REPO_ORG}</label>
                    <div style="display:flex;gap:.5rem;">
                        <input type="text" id="pbtm-add-org" value="PHPBoost" style="flex:1;padding:.35rem .6rem;border:1px solid #d1d5db;border-radius:4px;font-size:14px;">
                        <button type="button" class="pbtm-btn pbtm-btn-secondary" id="pbtm-load-org-repos">&#x21bb;</button>
                    </div>
                </div>
                <div class="pbtm-control-group">
                    <label>{L_REPO_PICK}</label>
                    <select id="pbtm-add-repo-select" style="width:100%;">
                        <option value="">—</option>
                    </select>
                </div>
                <div class="pbtm-control-group">
                    <label>{L_REPO_PATH}</label>
                    <input type="text" id="pbtm-add-path" placeholder="modules" style="width:100%;padding:.35rem .6rem;border:1px solid #d1d5db;border-radius:4px;font-size:14px;box-sizing:border-box;">
                </div>
                <div class="pbtm-control-group">
                    <label>{L_REPO_LABEL}</label>
                    <input type="text" id="pbtm-add-label" style="width:100%;padding:.35rem .6rem;border:1px solid #d1d5db;border-radius:4px;font-size:14px;box-sizing:border-box;">
                </div>
                <div class="pbtm-control-group" style="justify-content:flex-end;">
                    <label>&nbsp;</label>
                    <button type="button" class="pbtm-btn pbtm-btn-ok" id="pbtm-confirm-add-repo">{L_REPO_ADD_CONFIRM}</button>
                    <button type="button" class="pbtm-btn pbtm-btn-secondary" id="pbtm-cancel-add-repo" style="margin-top:.25rem;">{L_CANCEL}</button>
                </div>
            </div>
            <p id="pbtm-add-repo-error" style="display:none;color:#dc2626;font-size:13px;margin-top:.5rem;"></p>
        </div>

        <div class="pbtm-remote-controls">
            <div class="pbtm-control-group">
                <label for="pbtm-repo-select">{L_REMOTE_REPO}</label>
                <select id="pbtm-repo-select">
                    {REPO_OPTIONS}
                </select>
            </div>

            <div class="pbtm-control-group">
                <label for="pbtm-branch-select">{L_REMOTE_BRANCH}</label>
                <select id="pbtm-branch-select" disabled>
                    <option value="">{L_REMOTE_LOADING}</option>
                </select>
            </div>

            <div class="pbtm-control-group pbtm-control-refresh">
                <label>&nbsp;</label>
                <button type="button" class="pbtm-btn pbtm-btn-secondary" id="pbtm-refresh-remote">&#x21bb; {L_REFRESH}</button>
                <button type="button" class="pbtm-btn pbtm-btn-ok" id="pbtm-show-add-repo" style="margin-top:.25rem;">+ {L_REPO_ADD}</button>
            </div>
        </div>

        <div id="pbtm-remote-feedback" class="pbtm-feedback" style="display:none;"></div>

        <div id="pbtm-remote-modules" style="display:none;">
            <div class="pbtm-bulk-actions">
                <button type="button" class="pbtm-btn pbtm-btn-secondary" id="pbtm-select-all">{L_SELECT_ALL}</button>
                <button type="button" class="pbtm-btn pbtm-btn-secondary" id="pbtm-deselect-all">{L_DESELECT_ALL}</button>
                <button type="button" class="pbtm-btn pbtm-btn-ok" id="pbtm-install-sel">{L_INSTALL_SEL}</button>
            </div>

            <div class="pbtm-table-wrapper">
                <table class="pbtm-table" id="pbtm-remote-table">
                    <thead>
                        <tr>
                            <th class="pbtm-col-check"><input type="checkbox" id="pbtm-check-all" title="{L_SELECT_ALL}"></th>
                            <th>{L_COL_NAME}</th>
                            <th>{L_COL_REMOTE}</th>
                            <th>{L_COL_VERSION}</th>
                            <th>{L_COL_STATUS}</th>
                        </tr>
                    </thead>
                    <tbody id="pbtm-remote-tbody"></tbody>
                </table>
            </div>
        </div>

        <p id="pbtm-remote-none" style="display:none;" class="pbtm-info">{L_REMOTE_NONE}</p>
        <div id="pbtm-remote-loading" class="pbtm-loading-row">
            <span class="pbtm-spinner"></span>{L_REMOTE_LOADING}
        </div>
        <p id="pbtm-remote-error" style="display:none;" class="pbtm-error">{L_REMOTE_ERROR}</p>
    </section>

</div>

<script>
(function() {
    'use strict';

    var URL_BRANCHES     = '{URL_AJAX_BRANCHES}';
    var URL_FOLDERS      = '{URL_AJAX_FOLDERS}';
    var URL_INSTALL      = '{URL_AJAX_INSTALL}';
    var URL_ACTIVATE     = '{URL_AJAX_ACTIVATE}';
    var URL_DEACTIVATE   = '{URL_AJAX_DEACTIVATE}';
    var URL_UNINSTALL    = '{URL_AJAX_UNINSTALL}';
    var URL_REPOS        = '{URL_AJAX_REPOS}';
    var URL_SAVE_REPOS   = '{URL_AJAX_SAVE_REPOS}';
    var URL_LOCAL_INSTALL = '{URL_AJAX_LOCAL_INSTALL}';
    var CSRF_TOKEN       = '{CSRF_TOKEN}';

    var L = {
        loading:    '{L_REMOTE_LOADING}',
        error:      '{L_REMOTE_ERROR}',
        none:       '{L_REMOTE_NONE}',
        success:    '{L_INSTALL_SUCCESS}',
        errPrefix:  '{L_INSTALL_ERROR}',
        noSel:      '{L_INSTALL_NONE}',
        active:     '{L_STATUS_ACTIVE}',
        inactive:   '{L_STATUS_INACTIVE}',
        notInst:    '{L_STATUS_NOT_INSTALLED}',
        upToDate:   '{L_STATUS_UP_TO_DATE}',
        updateAvail:'{L_STATUS_UPDATE_AVAIL}',
        unknown:    '{L_STATUS_UNKNOWN}',
        activate:   '{L_ACTION_ACTIVATE}',
        deactivate: '{L_ACTION_DEACTIVATE}',
        uninstall:  '{L_ACTION_UNINSTALL}',
        localInstall: '{L_ACTION_LOCAL_INSTALL}',
        confirm:    '{L_UNINSTALL_CONFIRM}',
        confirmSoft: '{L_UNINSTALL_SOFT_CONFIRM}',
        confirmHard: '{L_UNINSTALL_HARD_CONFIRM}'
    };

    // -----------------------------------------------------------------------
    // Onglets
    // -----------------------------------------------------------------------
    var tabButtons  = document.querySelectorAll('.pbtm-tab');
    var tabContents = document.querySelectorAll('.pbtm-tab-content');
    var remoteLoaded = false;

    tabButtons.forEach(function(btn) {
        btn.addEventListener('click', function() {
            var target = btn.dataset.tab;

            tabButtons.forEach(function(b) { b.classList.remove('active'); });
            tabContents.forEach(function(c) { c.classList.remove('active'); });

            btn.classList.add('active');
            document.getElementById('pbtm-tab-' + target).classList.add('active');

            // Charger le dépôt distant au premier affichage de l'onglet
            if (target === 'remote' && !remoteLoaded) {
                remoteLoaded = true;
                if (repoSelect.options.length) loadBranches();
            }
        });
    });

    // Cache current repo metadata
    var currentRepo   = null;
    var currentBranch = null;

    // -----------------------------------------------------------------------
    // Helpers
    // -----------------------------------------------------------------------
    function post(url, data, cb) {
        jQuery.ajax({
            url: url,
            type: 'post',
            data: data,
            dataType: 'json',
            success: cb,
            error: function() { cb({ success: false, error: 'Network error' }); }
        });
    }

    function setFeedback(msg, type) {
        var el = document.getElementById('pbtm-remote-feedback');
        el.className = 'pbtm-feedback pbtm-feedback-' + (type || 'info');
        el.textContent = msg;
        el.style.display = 'block';
        setTimeout(function() { el.style.display = 'none'; }, 5000);
    }

    function showEl(id) { document.getElementById(id).style.display = ''; }
    function hideEl(id) { document.getElementById(id).style.display = 'none'; }

    // -----------------------------------------------------------------------
    // Repo selector → load branches
    // -----------------------------------------------------------------------
    var repoSelect   = document.getElementById('pbtm-repo-select');
    var branchSelect = document.getElementById('pbtm-branch-select');

    function loadBranches() {
        var opt = repoSelect.options[repoSelect.selectedIndex];
        if (!opt) return;

        try { currentRepo = JSON.parse(opt.dataset.repo); } catch(e) { return; }

        branchSelect.disabled = true;
        branchSelect.innerHTML = '<option>' + L.loading + '</option>';
        hideEl('pbtm-remote-modules');
        hideEl('pbtm-remote-none');
        hideEl('pbtm-remote-error');
        showEl('pbtm-remote-loading');

        post(URL_BRANCHES, { owner: currentRepo.owner, repo: currentRepo.repo, token: CSRF_TOKEN }, function(data) {
            hideEl('pbtm-remote-loading');
            if (!data.success || !data.branches.length) {
                showEl('pbtm-remote-error');
                return;
            }
            branchSelect.innerHTML = '';
            data.branches.forEach(function(b) {
                var o = document.createElement('option');
                o.value = b; o.textContent = b;
                branchSelect.appendChild(o);
            });
            branchSelect.disabled = false;
            loadFolders();
        });
    }

    // -----------------------------------------------------------------------
    // Branch selector → load module folders
    // -----------------------------------------------------------------------
    function loadFolders() {
        currentBranch = branchSelect.value;
        if (!currentRepo || !currentBranch) return;

        document.getElementById('pbtm-remote-tbody').innerHTML = '';
        hideEl('pbtm-remote-modules');
        hideEl('pbtm-remote-none');
        hideEl('pbtm-remote-error');
        showEl('pbtm-remote-loading');

        post(URL_FOLDERS, {
            owner:  currentRepo.owner,
            repo:   currentRepo.repo,
            branch: currentBranch,
            path:   currentRepo.path || '',
            token:  CSRF_TOKEN
        }, function(data) {
            hideEl('pbtm-remote-loading');
            if (!data.success) { showEl('pbtm-remote-error'); return; }
            if (!data.folders.length) { showEl('pbtm-remote-none'); return; }

            var tbody = document.getElementById('pbtm-remote-tbody');
            data.folders.forEach(function(f) {
                var statusLabel, statusClass;
                if (f.installed && f.activated) {
                    statusLabel = L.active; statusClass = 'pbtm-status-active';
                } else if (f.installed) {
                    statusLabel = L.inactive; statusClass = 'pbtm-status-inactive';
                } else {
                    statusLabel = L.notInst; statusClass = 'pbtm-status-none';
                }

                var versionLabel = L.unknown;
                var versionClass = '';
                if (f.remote_version && f.local_version) {
                    if (f.remote_version === f.local_version) {
                        versionLabel = L.upToDate; versionClass = 'pbtm-version-ok';
                    } else {
                        versionLabel = L.updateAvail; versionClass = 'pbtm-version-update';
                    }
                }

                var tr = document.createElement('tr');
                tr.innerHTML =
                    '<td class="pbtm-col-check"><input type="checkbox" class="pbtm-module-check" value="' + esc(f.name) + '"></td>' +
                    '<td>' + esc(f.name) + '</td>' +
                    '<td>' + (f.remote_version ? esc(f.remote_version) : '—') + '</td>' +
                    '<td>' + (f.local_version  ? esc(f.local_version)  : '—') + '</td>' +
                    '<td><span class="pbtm-status ' + statusClass + '">' + statusLabel + '</span>' +
                        (f.local_version && f.remote_version && f.remote_version !== f.local_version
                            ? ' <span class="pbtm-badge-update">' + versionLabel + '</span>' : '') +
                    '</td>';
                tbody.appendChild(tr);

                // Mettre à jour la colonne version remote dans le tableau local
                var localCell = document.querySelector('.pbtm-remote-version[data-id="' + esc(f.name) + '"]');
                if (localCell) {
                    localCell.textContent = f.remote_version || '—';
                    if (f.remote_version && f.local_version && f.remote_version !== f.local_version)
                        localCell.classList.add('pbtm-version-update');
                }
            });

            showEl('pbtm-remote-modules');
        });
    }

    function esc(str) {
        return String(str)
            .replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;')
            .replace(/"/g,'&quot;').replace(/'/g,'&#39;');
    }

    // -----------------------------------------------------------------------
    // Select all / deselect all
    // -----------------------------------------------------------------------
    document.getElementById('pbtm-check-all').addEventListener('change', function() {
        document.querySelectorAll('.pbtm-module-check').forEach(function(cb) { cb.checked = this.checked; }, this);
    });
    document.getElementById('pbtm-select-all').addEventListener('click', function() {
        document.querySelectorAll('.pbtm-module-check').forEach(function(cb) { cb.checked = true; });
    });
    document.getElementById('pbtm-deselect-all').addEventListener('click', function() {
        document.querySelectorAll('.pbtm-module-check').forEach(function(cb) { cb.checked = false; });
    });

    // -----------------------------------------------------------------------
    // Install selection
    // -----------------------------------------------------------------------
    document.getElementById('pbtm-install-sel').addEventListener('click', function() {
        var selected = [];
        document.querySelectorAll('.pbtm-module-check:checked').forEach(function(cb) { selected.push(cb.value); });
        if (!selected.length) { setFeedback(L.noSel, 'warn'); return; }

        post(URL_INSTALL, {
            owner:   currentRepo.owner,
            repo:    currentRepo.repo,
            branch:  currentBranch,
            path:    currentRepo.path || '',
            modules: selected,
            token:   CSRF_TOKEN
        }, function(data) {
            if (data.success) {
                setFeedback(L.success, 'ok');
                setTimeout(function() { location.reload(); }, 1500);
            } else {
                var msg = L.errPrefix;
                if (data.errors) msg += Object.values(data.errors).join(', ');
                setFeedback(msg, 'error');
            }
        });
    });

    // -----------------------------------------------------------------------
    // Local table: activate / deactivate / install / uninstall
    // -----------------------------------------------------------------------
    document.getElementById('pbtm-local-table').addEventListener('click', function(e) {
        var btn = e.target.closest('button[data-id]');
        if (!btn) return;
        var id  = btn.dataset.id;
        var tok = btn.dataset.token || CSRF_TOKEN;

        if (btn.classList.contains('pbtm-action-activate')) {
            post(URL_ACTIVATE, { id: id, token: tok }, function(d) {
                if (d.success) location.reload(); else setFeedback(d.error, 'error');
            });
        } else if (btn.classList.contains('pbtm-action-deactivate')) {
            post(URL_DEACTIVATE, { id: id, token: tok }, function(d) {
                if (d.success) location.reload(); else setFeedback(d.error, 'error');
            });
        } else if (btn.classList.contains('pbtm-action-local-install')) {
            post(URL_LOCAL_INSTALL, { id: id, token: tok }, function(d) {
                if (d.success) location.reload(); else setFeedback(d.error, 'error');
            });
        } else if (btn.classList.contains('pbtm-action-uninstall')) {
            var dropFiles = btn.dataset.drop || '0';
            var confirmMsg = dropFiles === '1' ? L.confirmHard : L.confirmSoft;
            if (!confirm(confirmMsg)) return;
            post(URL_UNINSTALL, { id: id, token: tok, drop_files: dropFiles }, function(d) {
                if (d.success) location.reload(); else setFeedback(d.error, 'error');
            });
        }
    });

    // -----------------------------------------------------------------------
    // Ajout de dépôt depuis l'onglet distant
    // -----------------------------------------------------------------------
    var addPanel     = document.getElementById('pbtm-add-repo-panel');
    var addOrgInput  = document.getElementById('pbtm-add-org');
    var addRepoSel   = document.getElementById('pbtm-add-repo-select');
    var addError     = document.getElementById('pbtm-add-repo-error');

    document.getElementById('pbtm-show-add-repo').addEventListener('click', function() {
        addPanel.style.display = addPanel.style.display === 'none' ? 'block' : 'none';
        if (addPanel.style.display === 'block') loadOrgRepos();
    });

    document.getElementById('pbtm-cancel-add-repo').addEventListener('click', function() {
        addPanel.style.display = 'none';
    });

    document.getElementById('pbtm-load-org-repos').addEventListener('click', loadOrgRepos);

    function loadOrgRepos() {
        var org = addOrgInput.value.trim();
        if (!org) return;
        addRepoSel.innerHTML = '<option>' + L.loading + '</option>';
        addRepoSel.disabled = true;
        post(URL_REPOS, { org: org, token: CSRF_TOKEN }, function(data) {
            addRepoSel.innerHTML = '<option value="">—</option>';
            if (data.success && data.repos && data.repos.length) {
                data.repos.forEach(function(r) {
                    var o = document.createElement('option');
                    o.value = r.name;
                    o.textContent = r.name + (r.description ? ' — ' + r.description : '');
                    addRepoSel.appendChild(o);
                });
            } else {
                addRepoSel.innerHTML = '<option value="">' + L.error + '</option>';
            }
            addRepoSel.disabled = false;
        });
    }

    document.getElementById('pbtm-confirm-add-repo').addEventListener('click', function() {
        var org   = addOrgInput.value.trim();
        var repo  = addRepoSel.value;
        var path  = document.getElementById('pbtm-add-path').value.trim();
        var label = document.getElementById('pbtm-add-label').value.trim();

        if (!org || !repo) {
            addError.textContent = 'Sélectionnez un dépôt.';
            addError.style.display = 'block';
            return;
        }
        addError.style.display = 'none';

        post(URL_SAVE_REPOS, { org: org, repo: repo, path: path, label: label, token: CSRF_TOKEN }, function(data) {
            if (data.success) {
                // Ajouter dans le select et recharger
                var o = document.createElement('option');
                o.value = data.repos.length - 1;
                o.dataset.repo = JSON.stringify(data.repos[data.repos.length - 1]);
                o.textContent = label || org + '/' + repo;
                repoSelect.appendChild(o);
                repoSelect.value = o.value;
                addPanel.style.display = 'none';
                loadBranches();
            } else {
                addError.textContent = data.error || L.error;
                addError.style.display = 'block';
            }
        });
    });

    // -----------------------------------------------------------------------
    // Init — dépôt distant chargé uniquement à l'ouverture de l'onglet
    // -----------------------------------------------------------------------
    repoSelect.addEventListener('change', loadBranches);
    branchSelect.addEventListener('change', loadFolders);

    document.getElementById('pbtm-refresh-local').addEventListener('click', function() {
        location.reload();
    });

    document.getElementById('pbtm-refresh-remote').addEventListener('click', function() {
        loadBranches();
    });

})();
</script>
