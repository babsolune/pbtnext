<span id="scroll-to-bottom" class="scroll-to" role="button" aria-label="{@common.scroll.to.bottom}"><i class="fa fa-chevron-down" aria-hidden="true"></i></span>

<header id="header-admin">
    <h1 id="site-name-container">
        <span class="adminboost-toggle"><i class="fa fa-bars" aria-hidden="true"></i></span>
        {SITE_NAME}
    </h1>
	<nav id="adminboost" class="pushnav">
        <ul>
            # INCLUDE SUBHEADER_MENU #
        </ul>
        <ul>
            <li><a href="#separator"></a></li>
        </ul>
        <ul>
            <li>
                <a href="https://www.phpboost.com/forum" target="_blank" rel="noopener">
                    <i class="fa fa-fw fa-globe" aria-hidden="true"></i> {@menu.support}
                </a>
            </li>
            <li>
                <a href="https://www.phpboost.com/faq" target="_blank" rel="noopener">
                    <i class="fa fa-fw fa-question-circle" aria-hidden="true"></i> {@menu.faq}
                </a>
            </li>
            <li>
                <a href="https://www.phpboost.com/wiki" target="_blank" rel="noopener">
                    <i class="fa fa-fw fa-book" aria-hidden="true"></i> {@menu.documentation}
                </a>
            </li>
        </ul>
        <ul class="bottom-nav align-center">
            <li>
                    <a href="{PATH_TO_ROOT}/" aria-label="{@menu.site}">
                        <i class="fa fa-fw fa-home" aria-hidden="true"></i>
                    </a>
            </li>
            <li>
                    <a href="{PATH_TO_ROOT}/admin/admin_index.php" aria-label="{@menu.dashboard}">
                        <i class="fa fa-fw fa-cogs" aria-hidden="true"></i>
                    </a>
            </li>
            <li>
                    <a href="{PATH_TO_ROOT}/admin/admin_extend.php" aria-label="{@menu.extended}">
                        <i class="fa fa-fw fa-th" aria-hidden="true"></i>
                    </a>
            </li>
            <li>
                    <a href="${relative_url(UserUrlBuilder::disconnect())}" aria-label="{@menu.sign.out}">
                        <i class="fa fa-fw fa-sign-out-alt" aria-hidden="true"></i>
                    </a>
            </li>
        </ul>
	</nav>
</header>

<div id="preloader-status">
	<i class="fa iboost fa-iboost-logo fa-5x blink link-color"></i>
</div>
<div id="global" class="body-wrapper content-preloader">
	<div id="admin-main">
		# INCLUDE KERNEL_MESSAGE #
		{CONTENT}
	</div>

	<footer id="footer">
		<span>
			{@common.powered.by} <i class="fa iboost fa-iboost-logo" aria-hidden="true"></i> <a class="powered-by" href="https://www.phpboost.com" aria-label="{@common.phpboost.link}"> PHPBoost </a> | <span aria-label="{@common.phpboost.right}"><i class="fab fa-osi" aria-hidden="true"></i></span>
		</span>
		# IF C_DISPLAY_BENCH #
			<span>
			| {@common.achieved} {BENCH}{@date.unit.seconds} - {REQ} {@common.sql.request} - {MEMORY_USED}
			</span>
		# ENDIF #
		# IF C_DISPLAY_AUTHOR_THEME #
			<span>
			| {@common.theme} {L_THEME_NAME} ${TextHelper::strtolower(@common.by)} <a href="{U_THEME_AUTHOR_LINK}">{L_THEME_AUTHOR}</a>
			</span>
		# ENDIF #
	</footer>

	<span id="scroll-to-top" class="scroll-to" role="button" aria-label="{@common.scroll.to.top}"><i class="fa fa-chevron-up" aria-hidden="true"></i></span>
</div>

<script>
    jQuery('#adminboost').pushmenu({
        // expanded: true,
        expanded:  window.innerWidth > 769,
        insertClose: false,
        width: 230,
        customToggle: jQuery('.adminboost-toggle'), // null
        // navTitle: '{SITE_NAME}', // null
        // pushContent: true,
        // position: 'left', // left, right, top, bottom
        // levelOpen: 'overlap', // 'overlap', 'expand'
        // levelTitles: true, // overlap only
        // levelSpacing: 40, // px - overlap only
        // navClass: 'fwkboost-admin',
        disableBody: false,
        // closeOnClick: true, // if disableBody is true
        // insertClose: true,
        labelClose: ${escapejs(@common.close)},
        // insertBack: true,
        labelBack: ${escapejs(@common.back)}
    });
</script>
