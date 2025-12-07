extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'):
		get_tree().paused = not get_tree().paused
		visible = not visible

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	hide()

func _on_options_button_pressed() -> void:
	print('Options')

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	GameController.reset()
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")
