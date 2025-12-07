extends Node

const EFFECT_DURATION = 3.0  # All effects last 3 seconds

var spells: Dictionary[String, Spell]
var selected_spell: Spell = null # Currently selected spell

signal mana_used(float)

func select_spell(spell_name: String):
	if spell_name in spells:
		selected_spell = spells[spell_name]
		prints("Selected spell:", spell_name)
	else:
		prints("Invalid spell:", spell_name)

func cast_spell_at(position: Vector2):
	if selected_spell == null:
		return
	prints("Casting", selected_spell.name, "at", position)
	mana_used.emit(selected_spell.cost)
	# Create visual effect
	create_spell_effect(position)
	# Apply spell effects based on type
	match selected_spell.effect:
		"Burn":  # Fire - damage over time
			apply_burn_effect(position)
		"Freeze":  # Ice - freeze enemies
			apply_freeze_effect(position)
		"Charge":  # Lightning - damage nearby enemies
			apply_charge_effect(position)

func create_spell_effect(position: Vector2):
	# Create a simple circle visual effect
	var sprite := Sprite2D.new()
	sprite.texture = selected_spell.texture
	# Center the image on the clicked position
	sprite.position = position
	# --- SCALE TO MATCH PREVIOUS SIZE ---
	var tex_size = sprite.texture.get_size()
	var target_size = selected_spell.radius * 2
	var scale_factor = target_size / tex_size.x  # assuming square image
	sprite.scale = Vector2(scale_factor, scale_factor)
	sprite.modulate.a = 0.7
	get_tree().root.add_child(sprite)
	# --- ANIMATE ---
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, 0.5)
	tween.tween_callback(sprite.queue_free)

func deal_damage_in_radius(position: Vector2, radius: int, damage: int):
	# Get all enemies in the "enemies" group
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy.global_position.distance_to(position) <= radius:
			if enemy.has_method("take_damage"):
				enemy.take_damage(damage)
				print("Hit enemy for ", damage, " damage")

# Unified status effect system
func apply_burn_effect(position: Vector2):
	var enemies = get_enemies_in_radius(position, selected_spell.radius)
	for enemy in enemies:
		if enemy.has_method("apply_status"):
			enemy.apply_status("Burn", selected_spell.damage, selected_spell.potency, EFFECT_DURATION)

func apply_freeze_effect(position: Vector2):
	var enemies = get_enemies_in_radius(position, selected_spell.radius)
	for enemy in enemies:
		if enemy.has_method("apply_status"):
			enemy.apply_status("Freeze", selected_spell.damage, selected_spell.potency, EFFECT_DURATION)

func apply_charge_effect(position: Vector2):
	var directEnemies = get_enemies_in_radius(position, selected_spell.radius)
	var chainEnemies = get_enemies_in_radius(position, selected_spell.radius + 100)
	for enemy in chainEnemies:
		if enemy in directEnemies:
			if enemy.has_method("apply_status"):
				enemy.apply_status("Direct Shock", selected_spell.damage, selected_spell.potency, EFFECT_DURATION)  # Instant damage
		else:
			if enemy.has_method("apply_status"):
				enemy.apply_status("Shock", selected_spell.damage, selected_spell.potency, EFFECT_DURATION)  # Instant damage

func get_enemies_in_radius(pos: Vector2, radius: float) -> Array:
	var enemies_in_range = []
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy.global_position.distance_to(pos) <= radius:
			enemies_in_range.append(enemy)
	return enemies_in_range

func _ready() -> void:
	spells = {
		"Fire" : preload("res://spells/fire.tres"),
		"Ice" : preload("res://spells/ice.tres"),
		"Lightning" : preload("res://spells/lightning.tres")
		}
