extends PathFollow2D

@export var strength: int = 1
@export var speed: float = 100.0
@export var health: int = 100
var base_speed: float
var current_speed: float
var is_frozen = false
var is_burning = false
var is_charged = false
var burn_damage = 0
var burn_timer = 0.0
var charge_timer = 0.0

signal enemy_died
signal reached_end

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
	# Handle charge color effect
	if charge_timer > 0:
		charge_timer -= delta
		if charge_timer <= 0:
			is_charged = false
			modulate = Color.WHITE

func _physics_process(delta):
	if not is_frozen:
		progress += current_speed * delta
	if progress_ratio >= 1.0:
		reached_end.emit(strength)
		queue_free()

func take_damage(amount: int):
	health -= amount
	print("Enemy took ", amount, " damage. Health: ", health)
	if health <= 0:
		die()

func die():
	print("Enemy died!")
	enemy_died.emit()
	queue_free()

# Unified status effect function
func apply_status(status_type: String, damage: int, potency: float, duration: float):
	match status_type:
		"Burn":
			apply_burn(damage, duration * potency)
		"Freeze":
			apply_freeze(duration * potency)
		"Shock":
			take_damage(damage - 15)  # Instant damage
			apply_charge(duration * potency)
		"Direct Shock":
			take_damage(damage)
			apply_charge(duration * potency) 
		_:
			push_error("Unknown status: ", status_type)

func apply_charge(duration: float):
	is_charged = true
	charge_timer = duration
	modulate = Color(1.061, 0.887, 0.321, 0.812)

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
