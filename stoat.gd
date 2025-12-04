# Add to your existing stoat script
extends Area2D

@export var health = 100  # Add if you don't have health already


func _ready():
	add_to_group("enemies")  # This makes spells detect it
	# ... your existing _ready() code

# Add this new function
func take_damage(amount: int):
	health -= amount
	print("Stoat took ", amount, " damage. Health: ", health)
	if health <= 0:
		die()

func die():
	queue_free()  # Remove from scene
	# Add death animation/effects here if you want
