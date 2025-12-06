extends Control

var _settings: Settings

signal music_volume_changed()
signal sound_effects_volume_changed()

func get_settings() -> Settings:
	return _settings

func _ready() -> void:
	_settings = load("res://settings/settings.tres")
	if _settings == null:
		_settings = Settings.new()
		ResourceSaver.save(_settings, "res://settings/settings.tres")
	($Background/MusicVolumeContainer/Slider as HSlider).value = _settings.music_volume
	($Background/SoundEffectsVolumeContainer/Slider as HSlider).value = _settings.sound_effects_volume

func _on_music_volume_slider_value_changed(value: float) -> void:
	_settings.music_volume = value
	music_volume_changed.emit()

func _on_sound_effects_slider_value_changed(value: float) -> void:
	_settings.sound_effects_volume = value
	sound_effects_volume_changed.emit()

func _on_save_and_close_button_pressed() -> void:
	ResourceSaver.save(_settings, "res://settings/settings.tres")
	visible = not visible
