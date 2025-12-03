extends Node

@export var mob_scene: PackedScene
var score

func _ready() -> void:
	$MobTimer.start()

func _on_pause_pressed() -> void:
	print("Pause Pressed")

func _on_spell_1_pressed() -> void:
	print("Casting Spell 1")

func _on_spell_2_pressed() -> void:
	print("Casting Spell 2")

func _on_spell_3_pressed() -> void:
	print("Casting Spell 3")

func _on_spell_4_pressed() -> void:
	print("Casting Spell 4")


func _on_mob_timer_timeout():
	var follower := PathFollow2D.new()
	follower.set_script(load("res://follower_script.gd"))
	
	var mob := mob_scene.instantiate()

	# Add follower to your path
	$EnemyPath.add_child(follower)

	# Add mob as a child of the follower
	follower.add_child(mob)

	# Ensure mob starts at center of follower
	mob.position = Vector2.ZERO
	mob.rotation = 0
