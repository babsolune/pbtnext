<header></header>

<div class="cell-flex cell-columns-2">
	<div class="next-step">
		# INCLUDE DATABASE_FORM #
	</div>
    <div class="content">
        # IF ERROR #
            <div class="message-helper bgc error">{ERROR}</div>
        # END #
        <div class="pbt-box align-center">
            <a href="https://www.mysql.com/" target="_blank" rel="noopener noreferrer">
                <img src="templates/images/mysql.webp" alt="MySQL" />
            </a>
        </div>
        {@H|db.parameters.config.clue}
    </div>
</div>

<footer></footer>
