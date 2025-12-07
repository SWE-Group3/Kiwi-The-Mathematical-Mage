extends TileMapLayer

func _input(event):
	# Only do anything if a spell is selected
	if SpellManager.selected_spell == null:
		return
	# Detect left mouse click
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		var mouse_position = get_global_mouse_position()
		print("Casting spell at: ", mouse_position)
		# Call the spell manager to do the effect + damage
		SpellManager.cast_spell_at(mouse_position)
		# Reset selection (must click button again)
		SpellManager.selected_spell = null
		$AudioStreamPlayer.volume_linear = GameController.settings.sound_effects_volume
		$AudioStreamPlayer.play()
