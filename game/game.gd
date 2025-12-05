extends Node
var selectedSpell := 0
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

func _on_spawn_timer_timeout() -> void:
	var pickEnemy = randi_range(1, 3)
	var pickPath = randi_range(1,3)

	var _enemy: Resource
	match pickEnemy:
		1:
			_enemy = preload("res://predators/stoat/stoat_path_follow.tscn")
		2:
			_enemy = preload("res://predators/cat/cat_path_follow.tscn")
		3:
			_enemy = preload("res://predators/dog/dog_path_follow.tscn")
	
	match pickPath:
		1: 
			$TopPath.add_child(_enemy.instantiate())
		2:
			$MiddlePath.add_child(_enemy.instantiate())
		3: 
			$BottomPath.add_child(_enemy.instantiate())
