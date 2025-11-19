extends Control

@onready var isopen = false

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	isopen = false
	$AnimationPlayer.play_backwards("blur")
	
func open():
	isopen = true
	$AnimationPlayer.play("blur")


func testTab():
	if Input.is_action_just_pressed("upgrade") and isopen == false:
		open()
	elif Input.is_action_just_pressed("upgrade") and isopen == true:
		resume()
		

	
func _process(delta):
	testTab()
	


func _on_close_pressed() -> void:
	resume()


func _on_open_upgrade_pressed() -> void:
	open()
