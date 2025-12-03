extends PathFollow2D

@export var speed: float = 15.0

func _physics_process(delta):
	progress += speed * delta
