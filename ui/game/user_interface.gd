extends CanvasLayer

# TODO - Add functionality to UI

func _ready() -> void:
	Global.wave_started.connect(_on_start_wave)
	Global.wave_completed.connect(_on_wave_completed)
	$BottomHUD/ProblemContainer.visible = false
	$BottomHUD/ProblemBackground.visible = false
 
func _on_start_wave(wave: int) -> void:
	$SpawnTimer.start()
	$TopHUD/WaveLabel.text = "Wave %d" % wave
	
func _on_start_wave_button_pressed() -> void:
	print("start wave button pressed")
	$BottomHUD/StartWaveButton.visible = false
	$BottomHUD/UpgradesButton.visible = false
	$BottomHUD/ProblemContainer.visible = true
	$BottomHUD/ColorRect.visible = true


	Global.start_wave()
	
	
func _on_wave_completed(wave: int):
	$BottomHUD/StartWaveButton.visible = true
	$BottomHUD/UpgradesButton.visible =true
	$BottomHUD/ProblemContainer.visible = false
	$BottomHUD/ColorRect.visible = false


	
