class_name Options extends Resource

@export var music_volume: float
@export var sound_effects_volume: float

@warning_ignore('shadowed_variable')
func _init(music_volume := 1.0, sound_effects_volume := 1.0) -> void:
	self.music_volume = music_volume
	self.sound_effects_volume = sound_effects_volume
