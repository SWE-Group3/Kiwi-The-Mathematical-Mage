
extends Node

# Currently selected spell
var selected_spell = null

# Spell data structure
var spells = {
	"fireball": {
		"name": "Fireball",
		"damage": 50,
		"radius": 100,
		"color": Color.RED
	},
	"ice_blast": {
		"name": "Ice Blast",
		"damage": 30,
		"radius": 150,
		"color": Color.CYAN
	},
	"lightning": {
		"name": "Lightning",
		"damage": 75,
		"radius": 50,
		"color": Color.YELLOW
	}
}

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
	
	# Create visual effect (spawn a simple effect scene)
	create_spell_effect(position, spell)
	
	# Deal damage to enemies in radius
	deal_damage_in_radius(position, spell["radius"], spell["damage"])

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
