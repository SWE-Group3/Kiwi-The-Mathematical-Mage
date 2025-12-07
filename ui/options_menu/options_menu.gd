extends Control

signal music_volume_changed()
signal sound_effects_volume_changed()

func _ready() -> void:
	$Background/MusicVolumeContainer/Slider.value = GameController.settings.music_volume
	$Background/SoundEffectsVolumeContainer/Slider.value = GameController.settings.sound_effects_volume

func _on_music_volume_slider_value_changed(value: float) -> void:
	GameController.settings.music_volume = value
	music_volume_changed.emit()

func _on_sound_effects_slider_value_changed(value: float) -> void:
	GameController.settings.sound_effects_volume = value
	sound_effects_volume_changed.emit()

func _on_save_and_close_button_pressed() -> void:
	ResourceSaver.save(GameController.settings, GameController.SETTINGS_PATH)
	visible = not visible
