extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.math_problem_factory = MathProblemFactories.add_sub_problem_factory.bind(false);
	$MainButtonContainer/StartButton.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_addition_button_pressed() -> void:
	Global.math_problem_factory = MathProblemFactories.add_sub_problem_factory.bind(false);

func _on_subtraction_button_pressed() -> void:
	Global.math_problem_factory = MathProblemFactories.add_sub_problem_factory.bind(true);

func _on_multiplication_button_pressed() -> void:
	Global.math_problem_factory = MathProblemFactories.multiplication_problem_factory
	return

func _on_division_button_pressed() -> void:
	return
