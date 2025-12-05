extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_options_menu_ready() -> void:
	_on_music_volume_changed($OptionsMenu.get_options().music_volume)

func _on_music_volume_changed(value: float) -> void:
	$BackgroundMusic.volume_linear = value
