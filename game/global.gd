extends Node

#var spawn_enemies = load("res://game/game.gd").new()

signal wave_started(int)
signal wave_completed(int)
var math_problem_factory: Callable
var wave_number: int = 1;
var enemies_alive: int =0;
var math_problem: MathProblem

func regen_math_problem():
	math_problem = math_problem_factory.call(difficulty());
	
func start_wave() -> void:
	var game_node = get_node("/root/Game")
	wave_started.emit(wave_number)
	var spawn_points = wave_number * 5
	var results = game_node.pick_enemies(spawn_points)
	enemies_alive = results.count
	game_node.spawn_enemies(results.list)
	
func on_enemy_death():
	enemies_alive -= 1
	print("Enemy died. Enemies left:", enemies_alive)
	
	if enemies_alive <= 0:
		complete_wave()


func complete_wave() -> void:
	var prev_wave_number = wave_number
	print("wave ", prev_wave_number, " Completed")
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
