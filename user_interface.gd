extends CanvasLayer

# TODO - Add functionality to UI


func _on_start_wave_button_pressed() -> void:
	$SpawnTimer.start()
	$TopHUD/WaveLabel.text = ("Wave 1")
	
