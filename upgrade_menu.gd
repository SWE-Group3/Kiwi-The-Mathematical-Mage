extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('upgrade'):
		visible = not visible

func _on_upgrade_button_pressed() -> void:
	print('Upgrade Pressed')
