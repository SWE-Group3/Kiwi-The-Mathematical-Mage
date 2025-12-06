extends Node

func _ready() -> void:
	add_child(preload("res://ui/main_menu.tscn").instantiate())
