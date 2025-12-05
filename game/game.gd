extends Node
var selectedSpell := 0
var enemiesToSpawn

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

func _on_spell_4_pressed() -> void:
	SpellManager.select_spell("fireball")  # Changed (or add a 4th spell)
	print("Casting Spell 4")
	
#takes in a number of spawn points, loops till there are no more points
#and returns how many enemies where spawned
#func pick_enemies(points:int) -> int:
	#var pickEnemy = randi_range(1, 3)
	#var pickPath = randi_range(1,3)
	#var enemiesSpawned = 0
#
	#var _enemy: Resource
	#while points:
		#match pickEnemy:
			#1:
				#if points >= 1:
					#_enemy = preload("res://predators/stoat/stoat_path_follow.tscn")
					#enemiesSpawned += 1
					#points -= 1
			#2:
				#if points >= 12:
					#_enemy = preload("res://predators/cat/cat_path_follow.tscn")
					#enemiesSpawned += 1
					#points -= 12
			#3:
				#if points >= 24:
					#_enemy = preload("res://predators/dog/dog_path_follow.tscn")
					#enemiesSpawned += 1
					#points -= 24
#
		#match pickPath:
			#1: 
				#$TopPath.add_child(_enemy.instantiate())
			#2:
				#$MiddlePath.add_child(_enemy.instantiate())
			#3: 
				#$BottomPath.add_child(_enemy.instantiate())
				#
	#return enemiesSpawned

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
		# If enemy_scene wasn’t valid (points too low), break to avoid infinite loop
		#if enemy_scene == null:
			#print("im taking a break!")
			#break

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

#func _on_spawn_timer_timeout() -> void:
	#var pickEnemy = randi_range(1, 3)
	#var pickPath = randi_range(1,3)
#
	#var _enemy: Resource
	#match pickEnemy:
		#1:
			#_enemy = preload("res://predators/stoat/stoat_path_follow.tscn")
		#2:
			#_enemy = preload("res://predators/cat/cat_path_follow.tscn")
		#3:
			#_enemy = preload("res://predators/dog/dog_path_follow.tscn")
	#
	#match pickPath:
		#1: 
			#$TopPath.add_child(_enemy.instantiate())
		#2:
			#$MiddlePath.add_child(_enemy.instantiate())
		#3: 
			#$BottomPath.add_child(_enemy.instantiate())
