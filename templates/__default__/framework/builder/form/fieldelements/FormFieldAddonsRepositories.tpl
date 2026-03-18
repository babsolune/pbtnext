<script>
    //sortable
	jQuery(document).ready(function() {
		if (jQuery("#input_fields_${escape(ID)}")[0]) {
			Sortable.create(document.getElementById('input_fields_${escape(ID)}'), {
				handle: '.sortable-selector',
				animation: 150,
				onEnd: function() {
					change_ids();
				}
			});
		}
	});

    function move(id, direction)
    {
        var li = jQuery('#' + id).closest('li');
        if(direction === 'up')
            li.insertBefore( li.prev() );
        if(direction === 'down')
            li.insertAfter( li.next() );
        change_ids();
    }

    function change_ids()
    {
        let li = jQuery("#input_fields_${escape(ID)} li");
        li.each(function() {
            jQuery(this).attr('id', '${escape(ID)}_' + jQuery(this).index());
            jQuery(this).find('.input-owner').attr('name', 'field_owner_${escape(ID)}_' + jQuery(this).index()).attr('id', 'field_owner_${escape(ID)}_' + jQuery(this).index());
            jQuery(this).find('.input-repository').attr('name', 'field_repository_${escape(ID)}_' + jQuery(this).index()).attr('id', 'field_repository_${escape(ID)}_' + jQuery(this).index());
            jQuery(this).find('.input-directory').attr('name', 'field_directory_${escape(ID)}_' + jQuery(this).index()).attr('id', 'field_directory_${escape(ID)}_' + jQuery(this).index());
            jQuery(this).find('.move-up').attr('id', 'move-up-${escape(ID)}_' + jQuery(this).index());
            jQuery(this).find('.move-down').attr('id', 'move-down-${escape(ID)}_' + jQuery(this).index());
            jQuery(this).find('.delete-item').attr('href', 'javascript:FormFieldAddonsRepositories.delete_field(' + jQuery(this).index() + ')').attr('id', 'delete_${escape(ID)}' + jQuery(this).index());
        })
    }

    // fields
	var FormFieldAddonsRepositories = function(){
		this.integer       = {FIELDS_NUMBER};
		this.id_input      = ${escapejs(ID)};
		this.max_input     = {MAX_INPUT};
	};

	FormFieldAddonsRepositories.prototype = {
		add_field : function (field_id, id, field_nb) {
			if (this.integer <= this.max_input)
            {
                var new_field = id + '_' + field_nb;

				jQuery('<li/>', {id : new_field}).appendTo('#' + field_id);

				jQuery('<div/>', {class: 'grouped-inputs flex-wide'}).appendTo('#' + new_field);

                    jQuery('<span/>', {class : 'sortable-selector grouped-element', 'aria-label' : ${escapejs(@common.move)}}).html('&nbsp;').appendTo('#' + new_field + ' .grouped-inputs');
                    jQuery('<input/>', {class : 'input-owner grouped-element', type : 'text', id : 'field_owner_' + new_field, name : 'field_owner_' + new_field, placeholder : ${escapejs(@addon.repos.owner)}}).appendTo('#' + new_field + ' .grouped-inputs');
                    jQuery('#field_owner_' + id).after(' ');
                    jQuery('<input/>', {class : 'input-repository grouped-element', type : 'text', id : 'field_repository_' + new_field, name : 'field_repository_' + new_field, placeholder : ${escapejs(@addon.repos.repository)}}).appendTo('#' + new_field + ' .grouped-inputs');
                    jQuery('#field_repository_' + id).after(' ');
                    jQuery('<input/>', {class : 'input-directory grouped-element', type : 'text', id : 'field_directory_' + new_field, name : 'field_directory_' + new_field, placeholder : ${escapejs(@addon.sub.directory)}}).appendTo('#' + new_field + ' .grouped-inputs');
                    jQuery('#field_directory_' + id).after(' ');
                    jQuery('<a/>', {class : 'delete-item grouped-element bgc-full error', href : 'javascript:FormFieldAddonsRepositories.delete_field("'+ id +'", "' + field_nb + '");', id : 'delete_' + new_field, 'aria-label' : ${escapejs(@common.delete)}}).html('<i class="far fa-trash-alt" aria-hidden="true"></i>').appendTo('#' + new_field + ' .grouped-inputs');
                    jQuery('<a/>', {class : 'move-up grouped-element', href : '#', id : 'move-up-' + new_field, 'aria-label' : ${escapejs(@common.move.up)}, onclick : "move(this.id, 'up');change_ids();return false;"}).html('<i class="fa fa-arrow-up" aria-hidden="true"></i>').appendTo('#' + new_field + ' .grouped-inputs');
                    jQuery('<a/>', {class : 'move-down grouped-element', href : '#', id : 'move-down-' + new_field, 'aria-label' : ${escapejs(@common.move.down)}, onclick : "move(this.id, 'down');change_ids();return false;"}).html('<i class="fa fa-arrow-down" aria-hidden="true"></i>').appendTo('#' + new_field + ' .grouped-inputs');

				this.integer++;
				field_nb++;
                jQuery('#add-' + id).attr('href', "javascript:FormFieldAddonsRepositories.add_field('input_fields_" + id + "', '" + id + "', '" + field_nb + "');");
			}
			if (this.integer == this.max_input) {
				jQuery('#add-' + id).hide();
			}
		},
		delete_field : function (id, field_nb) {
            var field = id + '_' + field_nb;
			jQuery('#' + field).remove();
			this.integer--;
			jQuery('#add-' + id).show();
		},
	};

	var FormFieldAddonsRepositories = new FormFieldAddonsRepositories();
</script>
<ul id="input_fields_${escape(ID)}" class="sortable-block form-field-values">
    # START fieldelements #
        <li id="${escape(ID)}_{fieldelements.ID}">
            <div class="grouped-inputs flex-wide">
                <span class="sortable-selector grouped-element" aria-label="{@common.move}">&nbsp;</span>
                <input class="input-owner grouped-element" type="text" name="field_owner_${escape(ID)}_{fieldelements.ID}" id="field_owner_${escape(ID)}_{fieldelements.ID}" value="{fieldelements.OWNER}" placeholder="{@addon.repos.owner}"# IF NOT C_DELETE # disabled="disabled"# ENDIF # />
                <input class="input-repository grouped-element" type="text" name="field_repository_${escape(ID)}_{fieldelements.ID}" id="field_repository_${escape(ID)}_{fieldelements.ID}" value="{fieldelements.REPO}" placeholder="{@addon.repos.repository}"# IF NOT C_DELETE # disabled="disabled"# ENDIF # />
                <input class="input-directory grouped-element" type="text" name="field_directory_${escape(ID)}_{fieldelements.ID}" id="field_directory_${escape(ID)}_{fieldelements.ID}" value="{fieldelements.DIR}" placeholder="{@addon.sub.directory}"# IF NOT C_DELETE # disabled="disabled"# ENDIF # />
                # IF fieldelements.C_DELETE #<a class="delete-item grouped-element bgc-full error# IF NOT C_DELETE # icon-disabled# ENDIF #" href="javascript:FormFieldAddonsRepositories.delete_field('${escape(ID)}', '{fieldelements.ID}');" id="delete_${escape(ID)}_{fieldelements.ID}" aria-label="{@common.delete}"  data-confirmation="delete-element"><i class="far fa-trash-alt" aria-hidden="true"></i></a># ENDIF #
                <a href="#" class="move-up grouped-element" aria-label="{@common.move.up}" id="move-up-${escape(ID)}_{fieldelements.ID}" onclick="move(this.id, 'up');return false;"><i class="fa fa-arrow-up" aria-hidden="true"></i></a>
                <a href="#" class="move-down grouped-element" aria-label="{@common.move.down}" id="move-down-${escape(ID)}_{fieldelements.ID}" onclick="move(this.id, 'down');return false;"><i class="fa fa-arrow-down" aria-hidden="true"></i></a>
            </div>
        </li>
    # END fieldelements #
</ul>
<a href="javascript:FormFieldAddonsRepositories.add_field('input_fields_${escape(ID)}', '${escape(ID)}', '{FIELDS_NUMBER}');" id="add-${escape(ID)}" class="add-more-values" aria-label="{@common.add}"><i class="far fa-lg fa-plus-square" aria-hidden="true"></i></a>
