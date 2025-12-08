extends TileMapLayer

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	var mouse_event := event as InputEventMouseButton
	# Only do anything if a spell is selected upon left click.
	if (SpellManager.selected_spell != null and
		mouse_event and mouse_event.pressed and
		mouse_event.button_index == MOUSE_BUTTON_LEFT):
			prints("Casting spell at:", mouse_event.position)
			# Call the spell manager to do the effect + damage
			SpellManager.cast_spell_at(mouse_event.position)
			# Reset selection (must click button again)
			SpellManager.selected_spell = null
			$KiwiBlastSoundEffect.volume_linear = GameController.settings.sound_effects_volume
			$KiwiBlastSoundEffect.play()
