extends Control

func _ready() -> void:
	_on_addition_button_pressed()
	_on_music_volume_changed()
	if GameController.wave_number > 1:
		$ScoreLabel.text = "Wave Reached: %d\nHighest Wave: %d" % [GameController.wave_number, GameController.save.high_score]

func _on_start_button_pressed() -> void:
	GameController.reset()
	get_tree().change_scene_to_file("res://wave/wave_controller.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_addition_button_pressed() -> void:
	GameController.math_problem_factory = AdditionSubtractionProblemFactory.new(true);

func _on_subtraction_button_pressed() -> void:
	GameController.math_problem_factory = AdditionSubtractionProblemFactory.new(false);

func _on_multiplication_button_pressed() -> void:
	GameController.math_problem_factory = MultiplicationProblemFactory.new()

func _on_division_button_pressed() -> void:
	GameController.math_problem_factory = DivisionProblemFactory.new()

func _on_music_volume_changed() -> void:
	$BackgroundMusic.volume_linear = GameController.settings.music_volume
