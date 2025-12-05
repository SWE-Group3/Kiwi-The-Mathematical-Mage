extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'):
		if get_tree().paused:
			_on_resume_button_pressed()
		else:
			_on_pause_button_pressed()

func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	show()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	hide()

func _on_options_button_pressed() -> void:
	print('Options')

func pause():
	get_tree().paused = true
func resume():
	get_tree().paused = false
	
func _on_quit_to_menu_pressed() -> void:
	resume()
	Global.reset()
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc") and not get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_pause_pressed() -> void:
	pause()

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file('res://main_menu.tscn')
