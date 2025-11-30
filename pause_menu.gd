extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'):
		if get_tree().paused:
			_on_resume_pressed()
		else:
			_on_pause_pressed()

func _on_pause_pressed() -> void:
	#$AnimationPlayer.play('blur')
	get_tree().paused = true
	visible = true

func _on_resume_pressed() -> void:
	#$AnimationPlayer.play_backwards('blur')
	get_tree().paused = false
	visible = false

func _on_quit_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file('res://main_menu.tscn')
