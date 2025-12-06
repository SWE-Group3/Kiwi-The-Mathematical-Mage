extends Node
var selectedSpell := 0
var enemiesToSpawn

@export var burnMana: float = 4.0
@export var freezeMana: float = 2.0
@export var chargeMana: float = 5.0

signal mana_generated(float)

func _ready() -> void:
	randomize()

func _on_pause_pressed() -> void:
	print("Pause Pressed")

func _on_spell_1_pressed() -> void:
	SpellManager.select_spell("fireball")  # Changed

	print("Casting Spell 1")

func _on_spell_2_pressed() -> void:
	SpellManager.select_spell("ice_blast")  # Changed
	print("Casting Spell 2")

func _on_spell_3_pressed() -> void:
	SpellManager.select_spell("lightning")  # Changed
	print("Casting Spell 3")

	
#takes in a number of spawn points, loops till there are no more points
#and returns how many enemies where spawned and the list of enemies to spawn
func pick_enemies(points: int) -> Dictionary:
	print("hello from pick_enemies")
	var enemies: Array[PackedScene] = []
	var points_left = points
	print("points: ", points)
	print("pointsleft:", points_left)
	
	while points_left > 0:
		print("made it into the loop")
		var pickEnemy = randi_range(1, 3)
		var cost = 0
		var enemy_scene: PackedScene = null
		print ("enemy who will be picked: ", pickEnemy)
		match pickEnemy:
			1:
				cost = 1
				if points_left >= cost:
					enemy_scene = preload("res://predators/stoat/stoat_path_follow.tscn")
					print("stoat chosen")
			2:
				cost = 12
				if points_left >= cost:
					enemy_scene = preload("res://predators/cat/cat_path_follow.tscn")
					print("cat chosen")
			3:
				cost = 24
				if points_left >= cost:
					enemy_scene = preload("res://predators/dog/dog_path_follow.tscn")
					print("dog chosen")
			_:
				print("no enemy chosen")

		# Add to the list
		if enemy_scene != null:
			enemies.append(enemy_scene)
			points_left -= cost

	# Return both values
	return {
		"count": enemies.size(),
		"list": enemies
	}
	
func spawn_enemies(enemies: Array):
	#var global = get_node("res://game/global.gd")
	for enemy in enemies:
		var spawn = enemy.instantiate()
		
		spawn.connect("enemy_died", Callable(Global, "on_enemy_death"))
		spawn.connect("reached_end", Callable(Global, "on_enemy_reached_end"))  
		
		var pickPath = randi_range(1,3)
		match pickPath:
			1: 
				$TopPath.add_child(spawn)
			2:
				$MiddlePath.add_child(spawn)
			3: 
				$BottomPath.add_child(spawn)
				
		print("enemy spawned")
		await get_tree().create_timer(1.0).timeout

func _on_mana_generator_timeout() -> void:
	mana_generated.emit(0.1)
