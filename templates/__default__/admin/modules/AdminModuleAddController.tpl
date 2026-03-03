# INCLUDE MESSAGE_HELPER_WARNING #
# INCLUDE MESSAGE_HELPER_SUCCESS #
# INCLUDE CONTENT #

<!-- GitHub Module Installation Form -->
<section class="github-module-installation">
	<div class="fieldset-content">
		<fieldset class="fieldset">
			<legend>{@addon.modules.github.install}</legend>
			<div class="fieldset-inset">
				<div class="form-element form-element-text">
					<label for="github-repo-url">{@addon.modules.github.repository.url}</label>
					<div class="form-field">
						<input type="text" id="github-repo-url" class="input-field" placeholder="https://github.com/PHPBoost/Modules" value="{DEFAULT_GITHUB_REPOSITORY}">
						<span id="repo-url-error" class="form-field-error" style="display: none;"></span>
					</div>
					<span class="form-field-description">{@addon.modules.github.repository}</span>
				</div>

				<div class="form-element form-element-select">
					<label for="github-branch">{@addon.modules.github.branch}</label>
					<div class="form-field">
						<select id="github-branch" class="input-field" disabled>
							<option value="">{@addon.modules.github.select.branch}</option>
						</select>
						<span id="branch-loading" style="display: none;" class="pinned bgc notice">
							<i class="fa fa-spinner fa-spin fa-fw" aria-hidden="true"></i> {@addon.modules.github.loading}
						</span>
						<span id="branch-error" class="form-field-error" style="display: none;"></span>
					</div>
				</div>

				<!-- Available modules from GitHub repository -->
				<div id="github-modules-container" style="display: none;">
					<h3>{@addon.modules.available}</h3>
					<span id="modules-loading" style="display: none;" class="pinned bgc notice">
						<i class="fa fa-spinner fa-spin fa-fw" aria-hidden="true"></i> {@addon.modules.github.loading.modules}
					</span>
					<span id="modules-error" class="form-field-error" style="display: none;"></span>
					
					<div id="github-modules-list" class="cell-flex cell-columns-3 cell-tile">
						<!-- Modules will be populated here by JavaScript -->
					</div>
				</div>

				<div class="form-element">
					<button type="button" id="github-install-btn" class="button button-main" disabled>
						<i class="fa fa-download fa-fw" aria-hidden="true"></i> {@addon.install}
					</button>
				</div>
			</div>
		</fieldset>
	</div>
</section>

<form action="{REWRITED_SCRIPT}" method="post" class="fieldset-content" id="github-install-form" style="display: none;">
	<input type="hidden" name="token" value="{TOKEN}">
	<input type="hidden" name="install_github_module" value="true">
	<input type="hidden" id="github_repo_url_input" name="github_repo_url" value="">
	<input type="hidden" id="github_branch_input" name="github_branch" value="">
</form>

<form action="{REWRITED_SCRIPT}" method="post" class="fieldset-content">
	<input type="hidden" name="token" value="{TOKEN}">
	<section id="not-installed-modules-container" class="addons-container modules-elements-container not-installed-elements-container">
		<header><h1>{@addon.modules.available}</h1></header>
		# IF C_MODULE_AVAILABLE #
			<div class="cell-flex cell-columns-3 cell-tile">
				# START modules_not_installed #
					<article class="cell addon# IF NOT modules_not_installed.C_COMPATIBLE # not-compatible error# ENDIF #">
						<header class="cell-header">
							# IF C_SEVERAL_MODULES_AVAILABLE #
								# IF modules_not_installed.C_COMPATIBLE #
									<div class="mini-checkbox">
										<label class="checkbox" for="multiple-checkbox-{modules_not_installed.MODULE_NUMBER}">
											<input type="checkbox" class="multiple-checkbox add-checkbox" id="multiple-checkbox-{modules_not_installed.MODULE_NUMBER}" name="add-checkbox-{modules_not_installed.MODULE_NUMBER}"/>
											<span>&nbsp;</span>
										</label>
									</div>
								# ENDIF #
							# ENDIF #
							<h3 class="cell-name">{modules_not_installed.MODULE_NAME}</h3>
							<div class="addon-menu-container">
								# IF modules_not_installed.C_COMPATIBLE #
									<button type="submit" class="button submit addon-menu-title" name="add-{modules_not_installed.MODULE_ID}" value="true">{@addon.install}</button>
								# ELSE #
									<span class="addon-menu-title bgc-full error">{@addon.not.compatible}</span>
								# ENDIF #
							</div>
						</header>
						<div class="cell-list">
							<ul>
								<li class="li-stretch">
									# IF modules_not_installed.C_THUMBNAIL #
										<img class="valign-middle" src="{PATH_TO_ROOT}/{modules_not_installed.MODULE_ID}/{modules_not_installed.MODULE_ID}.png" alt="{modules_not_installed.MODULE_NAME}" />
									# ELSE #
										# IF modules_not_installed.C_FA_ICON #
											<i class="{modules_not_installed.FA_ICON} fa-2x"></i>
										# ELSE #
											# IF modules_not_installed.C_HEXA_ICON #
												<span class="hexa-icon bigger">{modules_not_installed.HEXA_ICON}</span>
											# ELSE #
												{@addon.modules.no.icon}
											# ENDIF #
										# ENDIF #
									# ENDIF #
								</li>
								<li class="li-stretch">
									<span class="text-strong">{@common.version} :</span>
									{modules_not_installed.VERSION}
								</li>
								<li class="li-stretch">
									<span class="text-strong">{@addon.compatibility} :</span>
									<span# IF NOT modules_not_installed.C_COMPATIBLE_VERSION # class="not-compatible bgc-full error"# ENDIF #>PHPBoost {modules_not_installed.COMPATIBILITY}</span>
								</li>
								<li class="li-stretch">
									<span class="text-strong">{@common.author} :</span>
									<span>
										{modules_not_installed.AUTHOR}
										# IF modules_not_installed.C_AUTHOR_EMAIL # <a href="mailto:{modules_not_installed.AUTHOR_EMAIL}" class="pinned bgc notice" aria-label="{@common.email}"><i class="fa iboost fa-iboost-email fa-fw" aria-hidden="true"></i></a># ENDIF #
										# IF modules_not_installed.C_AUTHOR_WEBSITE # <a href="{modules_not_installed.AUTHOR_WEBSITE}" class="pinned bgc question" aria-label="{@common.website}"><i class="fa fa-share-square fa-fw" aria-hidden="true"></i></a> # ENDIF #
									</span>
								</li>
								<li class="li-stretch">
									<span class="text-strong">{@common.creation.date} :</span>
									{modules_not_installed.CREATION_DATE}
								</li>
								<li class="li-stretch">
									<span class="text-strong">{@common.last.update} :</span>
									{modules_not_installed.LAST_UPDATE}
								</li>
								<li>
									<span class="text-strong">{@common.description} :</span>
									{modules_not_installed.DESCRIPTION}
								</li>
                                # IF NOT modules_not_installed.C_COMPATIBLE_ADDON #
                                    <li class="bgc-full error">{@addon.modules.not.module}</li>
                                # ENDIF #
							</ul>
						</div>

						<footer></footer>
					</article>
				# END modules_not_installed #
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

<script>
	// GitHub Module Installer ES6
	class GitHubModuleInstaller {
		constructor() {
			this.repoUrlInput = document.getElementById('github-repo-url');
			this.branchSelect = document.getElementById('github-branch');
			this.installBtn = document.getElementById('github-install-btn');
			this.branchLoading = document.getElementById('branch-loading');
			this.branchError = document.getElementById('branch-error');
			this.repoError = document.getElementById('repo-url-error');
			this.repoUrlHiddenInput = document.getElementById('github_repo_url_input');
			this.branchHiddenInput = document.getElementById('github_branch_input');
			this.githubInstallForm = document.getElementById('github-install-form');
			
			// GitHub modules elements
			this.modulesContainer = document.getElementById('github-modules-container');
			this.modulesLoading = document.getElementById('modules-loading');
			this.modulesError = document.getElementById('modules-error');
			this.modulesList = document.getElementById('github-modules-list');

			this.init();
		}

		init() {
			// Set default repository value
			this.repoUrlInput.addEventListener('blur', () => this.handleRepoUrlChange());
			this.branchSelect.addEventListener('change', () => this.handleBranchChange());
			this.installBtn.addEventListener('click', () => this.handleInstallClick());
		}

		handleBranchChange() {
			this.updateInstallButtonState();
			
			// Load modules from GitHub when branch is selected
			if (this.branchSelect.value) {
				this.loadModulesFromBranch();
			} else {
				this.hideModulesContainer();
			}
		}

		handleRepoUrlChange() {
			const repoUrl = this.repoUrlInput.value.trim();
			
			// Clear previous state
			this.clearBranchError();
			this.branchSelect.innerHTML = '<option value="">{@addon.modules.github.select.branch}</option>';
			this.branchSelect.disabled = true;
			this.updateInstallButtonState();

			if (!repoUrl) {
				this.clearRepoError();
				return;
			}

			// Validate URL format
			if (!this.validateGitHubUrl(repoUrl)) {
				this.showRepoError('{@addon.modules.github.invalid.url}');
				return;
			}

			this.clearRepoError();
			this.loadBranches(repoUrl);
		}

		validateGitHubUrl(url) {
			const pattern = /^https?:\/\/github\.com\/[^\/]+\/[^\/]+(\.git)?$/;
			return pattern.test(url);
		}

		loadBranches(repoUrl) {
			this.showBranchLoading();
			
			const params = new URLSearchParams();
			params.append('ajax_get_branches', 'true');
			params.append('repo_url', repoUrl);
			
			// Get CSRF token from hidden input
			const tokenInput = document.querySelector('input[name="token"]');
			if (tokenInput) {
				params.append('token', tokenInput.value);
			}

			fetch(window.location.href, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded',
				},
				body: params.toString()
			})
			.then(response => {
				if (!response.ok) {
					throw new Error('HTTP Error ' + response.status);
				}
				return response.text();
			})
			.then(text => {
				this.hideBranchLoading();
				try {
					const data = JSON.parse(text);
					if (data.success && data.branches && data.branches.length > 0) {
						this.populateBranches(data.branches);
						this.branchSelect.disabled = false;
					} else {
						this.showBranchError(data.message || '{@addon.modules.github.error}');
					}
				} catch (e) {
					console.error('Invalid JSON response:', text);
					this.showBranchError('{@addon.modules.github.error}');
				}
			})
			.catch(error => {
				this.hideBranchLoading();
				console.error('Fetch error:', error);
				this.showBranchError('{@addon.modules.github.error}');
			});
		}

		populateBranches(branches) {
			this.branchSelect.innerHTML = '<option value="">{@addon.modules.github.select.branch}</option>';
			
			branches.forEach(branch => {
				const option = document.createElement('option');
				option.value = branch;
				option.textContent = branch;
				this.branchSelect.appendChild(option);
			});
		}

		loadModulesFromBranch() {
			const repoUrl = this.repoUrlInput.value.trim();
			const branch = this.branchSelect.value;

			if (!repoUrl || !branch) {
				return;
			}

			this.showModulesLoading();

			const params = new URLSearchParams();
			params.append('ajax_get_modules', 'true');
			params.append('repo_url', repoUrl);
			params.append('branch', branch);

			// Get CSRF token from hidden input
			const tokenInput = document.querySelector('input[name="token"]');
			if (tokenInput) {
				params.append('token', tokenInput.value);
			}

			fetch(window.location.href, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded',
				},
				body: params.toString()
			})
			.then(response => {
				if (!response.ok) {
					throw new Error('HTTP Error ' + response.status);
				}
				return response.text();
			})
			.then(text => {
				this.hideModulesLoading();
				try {
					const data = JSON.parse(text);
					if (data.success && data.modules && data.modules.length > 0) {
						this.displayModules(data.modules);
						this.showModulesContainer();
					} else {
						this.showModulesError(data.message || '{@addon.modules.github.error}');
						this.hideModulesContainer();
					}
				} catch (e) {
					console.error('Invalid JSON response:', text);
					this.showModulesError('{@addon.modules.github.error}');
					this.hideModulesContainer();
				}
			})
			.catch(error => {
				this.hideModulesLoading();
				console.error('Fetch error:', error);
				this.showModulesError('{@addon.modules.github.error}');
				this.hideModulesContainer();
			});
		}

		displayModules(modules) {
			this.modulesList.innerHTML = '';
			const self = this;  // Capture 'this' for use in forEach

			modules.forEach(module => {
				const moduleCard = document.createElement('article');
				moduleCard.className = 'cell addon';

				// Escape HTML for all text values before using in template
				const escapedName = self.escapeHtml(module.name);
				const escapedId = self.escapeHtml(module.id);
				const escapedVersion = self.escapeHtml(module.version);
				const escapedCompatibility = self.escapeHtml(module.compatibility);
				const escapedAuthor = self.escapeHtml(module.author);
				const escapedDescription = self.escapeHtml(module.description);

				moduleCard.innerHTML = 
                    '<header class="cell-header">' +
                        '<h3 class="cell-name">' + escapedName + '</h3>' +
                        '<div class="addon-menu-container">'+
                            '<button type="button" class="button submit addon-menu-title github-install-module-btn" data-module-id="' + escapedId + '">' +
                                '<i class="fa fa-download fa-fw" aria-hidden="true"></i> {@addon.install}'+
                            '</button>'+
                        '</div>'+
                    '</header>'+
                    '<div class="cell-list">'+
                        '<ul>'+
                            '<li class="li-stretch"><span class="text-strong">{@common.version} :</span>' + escapedVersion + '</li>'+
                            '<li class="li-stretch"><span class="text-strong">{@addon.compatibility} :</span><span>' + escapedCompatibility + '</span></li>'+
                            '<li class="li-stretch"><span class="text-strong">{@common.author} :</span><span>' + escapedAuthor + '</span></li>' + 
                            (module.description ? '<li><span class="text-strong">{@common.description} :</span> ' + escapedDescription + '</li>' : '') + 
                        '</ul>'+
                    '</div>'+
                    '<footer></footer>';

				// Add click event to install button
				const installBtn = moduleCard.querySelector('.github-install-module-btn');
				installBtn.addEventListener('click', () => self.installGitHubModule(module.id));

				self.modulesList.appendChild(moduleCard);
			});
		}

		installGitHubModule(moduleId) {
			// This would need to be implemented based on how you want to handle individual module installation
			// For now, we'll create a form submission
			const form = document.createElement('form');
			form.method = 'POST';
			form.action = window.location.href;

			const inputs = [
				{ name: 'token', value: document.querySelector('input[name="token"]').value },
				{ name: 'install_github_module', value: 'true' },
				{ name: 'github_repo_url', value: this.repoUrlInput.value.trim() },
				{ name: 'github_branch', value: this.branchSelect.value },
				{ name: 'github_module_id', value: moduleId }
			];

			inputs.forEach(input => {
				const inp = document.createElement('input');
				inp.type = 'hidden';
				inp.name = input.name;
				inp.value = input.value;
				form.appendChild(inp);
			});

			document.body.appendChild(form);
			form.submit();
		}

		escapeHtml(text) {
			const map = {
				'&': '&amp;',
				'<': '&lt;',
				'>': '&gt;',
				'"': '&quot;',
				"'": '&#039;'
			};
			return String(text).replace(/[&<>"']/g, m => map[m]);
		}

		showModulesContainer() {
			this.modulesContainer.style.display = 'block';
		}

		hideModulesContainer() {
			this.modulesContainer.style.display = 'none';
		}

		showModulesLoading() {
			this.modulesLoading.style.display = 'inline-block';
			this.clearModulesError();
		}

		hideModulesLoading() {
			this.modulesLoading.style.display = 'none';
		}

		showModulesError(message) {
			this.hideModulesLoading();
			this.modulesError.textContent = message;
			this.modulesError.style.display = 'block';
		}

		clearModulesError() {
			this.modulesError.textContent = '';
			this.modulesError.style.display = 'none';
		}

		updateInstallButtonState() {
			const hasRepo = this.repoUrlInput.value.trim() !== '';
			const hasBranch = this.branchSelect.value !== '';
			this.installBtn.disabled = !(hasRepo && hasBranch && !this.branchSelect.disabled);
		}

		handleInstallClick() {
			const repoUrl = this.repoUrlInput.value.trim();
			const branch = this.branchSelect.value;

			if (!repoUrl || !branch) {
				this.showBranchError('{@addon.modules.github.invalid.url}');
				return;
			}

			// Fill hidden inputs and submit form
			this.repoUrlHiddenInput.value = repoUrl;
			this.branchHiddenInput.value = branch;
			this.githubInstallForm.submit();
		}

		showBranchLoading() {
			this.branchLoading.style.display = 'inline-block';
			this.clearBranchError();
		}

		hideBranchLoading() {
			this.branchLoading.style.display = 'none';
		}

		showBranchError(message) {
			this.hideBranchLoading();
			this.branchError.textContent = message;
			this.branchError.style.display = 'block';
		}

		clearBranchError() {
			this.branchError.textContent = '';
			this.branchError.style.display = 'none';
		}

		showRepoError(message) {
			this.repoError.textContent = message;
			this.repoError.style.display = 'block';
		}

		clearRepoError() {
			this.repoError.textContent = '';
			this.repoError.style.display = 'none';
		}
	}

	// Initialize on DOM ready
	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', () => {
			new GitHubModuleInstaller();
		});
	} else {
		new GitHubModuleInstaller();
	}

	opensubmenu('.addon-auth', {
		osmTarget: '.addon-auth-container',
		osmCloseExcept: '.addon-auth-content *',
		osmCloseButton: '.addon-auth-close i',
	});
</script>
