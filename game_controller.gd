extends Node

func _ready() -> void:
	add_child(preload("res://ui/menu/main_menu.tscn").instantiate())
