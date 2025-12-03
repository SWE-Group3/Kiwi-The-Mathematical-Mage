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
	$EnemyPath.add_child(mob_scene.instantiate())
