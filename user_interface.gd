extends CanvasLayer

# TODO - Add functionality to UI

func _ready() -> void:
	Global.wave_started.connect(_on_start_wave)
 
func _on_start_wave(wave: int) -> void:
	$SpawnTimer.start()
	$TopHUD/WaveLabel.text = "Wave %d" % wave
	
func _on_start_wave_button_pressed() -> void:
	Global.start_wave()
	
