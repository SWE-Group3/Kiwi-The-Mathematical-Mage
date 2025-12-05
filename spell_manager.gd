extends Node

# Currently selected spell
var selected_spell = null


#### TO DO
### Add to the spells so they have a mana cost and subtract from the mana pool when 
### they are cast
###

# Spell data structure
var spells = {
	"fireball": {
		"name": "Fireball",
		"damage": 20,  # Damage per tick
		"radius": 75,
		"color": Color.RED,
		"type": "dot"  # Damage over time
	},
	"ice_blast": {
		"name": "Ice Blast",
		"damage": 30,
		"radius": 100,
		"color": Color.CYAN,
		"type": "freeze"
	},
	"lightning": {
		"name": "Lightning",
		"damage": 50,  # Damage per enemy hit
		"radius": 25,
		"color": Color.YELLOW,
		"type": "chain"  # Hits nearby enemies
	}
}

const EFFECT_DURATION = 3.0  # All effects last 3 seconds

func select_spell(spell_id: String):
	if spell_id in spells:
		selected_spell = spell_id
		print("Selected spell: ", spells[spell_id]["name"])
	else:
		print("Invalid spell ID: ", spell_id)

func cast_spell_at(position: Vector2):
	if selected_spell == null:
		return
	
	var spell = spells[selected_spell]
	print("Casting ", spell["name"], " at ", position)
	
	# Create visual effect
	create_spell_effect(position, spell)
	
	# Apply spell effects based on type
	match spell["type"]:
		"dot":  # Fireball - damage over time
			apply_dot_effect(position, spell)
		"freeze":  # Ice blast - freeze enemies
			apply_freeze_effect(position, spell)
		"chain":  # Lightning - damage nearby enemies
			apply_chain_effect(position, spell)

func create_spell_effect(pos: Vector2, spell: Dictionary):
	# Create a simple circle visual effect
	var effect = ColorRect.new()
	effect.size = Vector2(spell["radius"] * 2, spell["radius"] * 2)
	effect.position = pos - effect.size / 2
	effect.color = spell["color"]
	effect.color.a = 0.5
	
	# Add to scene
	get_tree().root.add_child(effect)
	
	# Animate and remove
	var tween = create_tween()
	tween.tween_property(effect, "modulate:a", 0.0, 0.5)
	tween.tween_callback(effect.queue_free)

func deal_damage_in_radius(pos: Vector2, radius: float, damage: int):
	# Get all enemies in the "enemies" group
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy.global_position.distance_to(pos) <= radius:
			if enemy.has_method("take_damage"):
				enemy.take_damage(damage)
				print("Hit enemy for ", damage, " damage")

# Unified status effect system
func apply_dot_effect(pos: Vector2, spell: Dictionary):
	var enemies = get_enemies_in_radius(pos, spell["radius"])
	for enemy in enemies:
		if enemy.has_method("apply_status"):
			enemy.apply_status("burn", spell["damage"], EFFECT_DURATION)

func apply_freeze_effect(pos: Vector2, spell: Dictionary):
	var enemies = get_enemies_in_radius(pos, spell["radius"])
	for enemy in enemies:
		if enemy.has_method("apply_status"):
			enemy.apply_status("freeze", spell["damage"], EFFECT_DURATION)

func apply_chain_effect(pos: Vector2, spell: Dictionary):
	var enemies = get_enemies_in_radius(pos, spell["radius"] + 50)
	for enemy in enemies:
		if enemy.has_method("apply_status"):
			enemy.apply_status("shock", spell["damage"], 0)  # Instant damage

func get_enemies_in_radius(pos: Vector2, radius: float) -> Array:
	var enemies_in_range = []
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy.global_position.distance_to(pos) <= radius:
			enemies_in_range.append(enemy)
	return enemies_in_range
