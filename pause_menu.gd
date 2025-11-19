extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()
		


func _on_resume_pressed() -> void:
	resume()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_quit_to_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	
func _process(delta):
	testEsc()
	
func _on_pause_pressed() -> void:
	pause()
