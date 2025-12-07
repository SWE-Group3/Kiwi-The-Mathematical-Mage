extends Node

var selectedSpell := 0
var enemiesToSpawn

signal mana_generated(float)

func _ready() -> void:
	GameController.tilemap_layer = $TileMapLayer  # assign the TileMap node
	randomize()

func _on_spell_1_pressed() -> void:
	SpellManager.select_spell("Fire")  # Changed
	print("Casting Spell 1")

func _on_spell_2_pressed() -> void:
	SpellManager.select_spell("Ice")  # Changed
	print("Casting Spell 2")

func _on_spell_3_pressed() -> void:
	SpellManager.select_spell("Lightning")  # Changed
	print("Casting Spell 3")

#takes in a number of spawn points, loops till there are no more points
#and returns how many enemies where spawned and the list of enemies to spawn
func pick_enemies(points: int) -> Dictionary:
	var enemies: Array[PackedScene] = []
	var points_left = points
	# loops while there are still points
	while points_left > 0:
		var pickEnemy = randi_range(1, 3) # pick which enemy to buy
		var cost = 0 # init cost
		var enemy_scene: PackedScene = null # init enemy_scene to null
		match pickEnemy:
			1: # stoats
				cost = 1 # cost of one stoat
				if points_left >= cost: # if can buy then buy
					enemy_scene = preload("res://predators/stoat/stoat_path_follow.tscn") # loads the stoat scene in 
			2: # cats
				cost = 12 # cost of one cat
				if points_left >= cost: # if can buy then buy
					enemy_scene = preload("res://predators/cat/cat_path_follow.tscn") # loads the cat scene in
			3: # dogs
				cost = 24 # cost of one dog
				if points_left >= cost: # if can buy then buy
					enemy_scene = preload("res://predators/dog/dog_path_follow.tscn") # loads the dog scene in
			_: # default
				print("no enemy chosen")
		# Add to the list
		if enemy_scene != null: # only adds if there is an enemy_scene
			enemies.append(enemy_scene) # adds the enemy_scene to an array
			points_left -= cost # subtracts cost of enemy from total points
	# Return both values
	return {
		"count": enemies.size(), # number of enemies spawned
		"list": enemies # list of enmies to spawn
	}

# Takes in an Array of enemy_scenes and spawns them with a one second delay
func spawn_enemies(enemies: Array):
	for enemy in enemies: # gets one enemy from the array
		var spawn = enemy.instantiate() 
		
		spawn.connect("enemy_died", GameController.on_enemy_death) # recieves signal on enemy death and calls on_enemy_death function
		spawn.connect("reached_end", GameController.on_enemy_reached_end) # recieves signal when enemy reaches the end of path and calles oon_enemy_reached_end functionn
		
		var pickPath = randi_range(1,3) # picks which path to spawn enemy on
		match pickPath:
			1: # top path
				$TopPath.add_child(spawn) # makes the enemy a child of the path
			2: # middle path
				$MiddlePath.add_child(spawn)
			3: # bottom path
				$BottomPath.add_child(spawn)
				
		await get_tree().create_timer(1.0).timeout # waits one second before moving on

# generates .1 mana every one second
func _on_mana_generator_timeout() -> void:
	mana_generated.emit(0.1) # emits a signel of .1
