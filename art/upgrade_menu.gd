extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	#get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func open():
	#get_tree().paused = true
	$AnimationPlayer.play("blur")


func testTab():
	if Input.is_action_just_pressed("upgrade") and get_tree().paused == false:
		open()
	elif Input.is_action_just_pressed("upgrade") and get_tree().paused == true:
		resume()
		

	
func _process(delta):
	testTab()
	


func _on_close_pressed() -> void:
	resume()


func _on_open_upgrade_pressed() -> void:
	open()
