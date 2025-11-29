extends Control

@onready var is_open: bool = false

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('upgrade'):
		if is_open:
			_on_close_pressed()
		else:
			_on_open_upgrade_pressed()

func _on_close_pressed() -> void:
	is_open = false
	$AnimationPlayer.play_backwards("blur")

func _on_open_upgrade_pressed() -> void:
	is_open = true
	$AnimationPlayer.play("blur")
