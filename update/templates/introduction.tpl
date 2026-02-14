<div class="content">
	<div class="float-right pbt-box align-center">
		<img src="templates/images/installboost.webp" alt="{@phpboost.logo}" />
	</div>

    <header>
        <h2>{@step.introduction.message}</h2>
    </header>

	{@H|step.introduction.explanation}
	# IF C_PUT_UNDER_MAINTENANCE #{@H|step.introduction.maintenance_notice}# ENDIF #
	{@H|step.introduction.team_signature}
</div>

<footer>
	<div class="next-step">
		# INCLUDE SERVER_FORM #
	</div>
</footer>
