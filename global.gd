extends Node

signal wave_started(int)
signal wave_completed(int)
var math_problem_factory: Callable
var wave_number: int = 1;
var math_problem: MathProblem

func regen_math_problem():
	math_problem = math_problem_factory.call(difficulty());
	
func start_wave() -> void:
	wave_started.emit(wave_number)
	
func complete_wave() -> void:
	var prev_wave_number = wave_number
	wave_number += 1
	wave_completed.emit(prev_wave_number)
	
func base_difficulty():
	return ((wave_number)/ 3.0) * 10.

func difficulty() -> int:
	var base_diff = base_difficulty()
	var jitter =  randi_range(0, 7) - int(randi_range(-5, 10) * ((100. - base_diff) / 100.))
	return mini(ceili(base_diff + jitter), 100)
	
func reset():
	wave_number = 1
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
