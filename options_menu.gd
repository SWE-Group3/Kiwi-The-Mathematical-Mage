extends Control

var _options: Options

signal music_volume_changed(value: float)
signal sound_effects_volume_changed(value: float)

func get_music_volume_slider() -> HSlider:
	return $Background/MusicVolumeContainer/Slider as HSlider

func get_sound_effects_volume_slider() -> HSlider:
	return $Background/SoundEffectsVolumeContainer/Slider as HSlider

func get_options() -> Options:
	return _options

func _ready() -> void:
	_options = load('res://options.tres')
	if _options == null:
		_options = Options.new()
		ResourceSaver.save(_options, 'res://options.tres')
	get_music_volume_slider().value = _options.music_volume
	get_sound_effects_volume_slider().value = _options.sound_effects_volume

func _on_music_volume_slider_value_changed(value: float) -> void:
	_options.music_volume = value
	music_volume_changed.emit(value)

func _on_sound_effects_slider_value_changed(value: float) -> void:
	_options.sound_effects_volume = value
	sound_effects_volume_changed.emit(value)

func _on_save_and_close_button_pressed() -> void:
	ResourceSaver.save(_options, 'res://options.tres')
	visible = not visible
