extends PathFollow2D

@export var speed: float = 100.0
@export var health: int = 100

var base_speed: float
var current_speed: float
var is_frozen = false
var is_burning = false
var burn_damage = 0
var burn_timer = 0.0

func _ready():
	add_to_group("enemies")
	base_speed = speed
	current_speed = speed

func _process(delta):
	# Handle burning DOT
	if burn_timer > 0:
		burn_timer -= delta
		# Apply damage every 0.5 seconds
		if int(burn_timer * 2) != int((burn_timer + delta) * 2):
			take_damage(burn_damage)
		if burn_timer <= 0:
			is_burning = false
			modulate = Color.WHITE

func _physics_process(delta):
	if not is_frozen:
		progress += current_speed * delta

func take_damage(amount: int):
	health -= amount
	print("Enemy took ", amount, " damage. Health: ", health)
	if health <= 0:
		die()

func die():
	print("Enemy died!")
	queue_free()

# Unified status effect function
func apply_status(status_type: String, damage: int, duration: float):
	match status_type:
		"burn":
			apply_burn(damage, duration)
		"freeze":
			apply_freeze(duration)
		"shock":
			take_damage(damage + 10)  # Instant damage
		_:
			print("Unknown status: ", status_type)

func apply_burn(damage_per_tick: int, duration: float):
	is_burning = true
	burn_damage = damage_per_tick
	burn_timer = duration
	modulate = Color(1.5, 0.5, 0.5)  # Red tint
	print("Enemy is burning!")

func apply_freeze(duration: float):
	is_frozen = true
	current_speed = 0
	modulate = Color(0.5, 0.5, 1.5)  # Blue tint
	print("Enemy is frozen!")
	await get_tree().create_timer(duration).timeout
	is_frozen = false
	current_speed = base_speed
	modulate = Color.WHITE
