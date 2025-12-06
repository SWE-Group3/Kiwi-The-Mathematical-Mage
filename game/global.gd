extends Node

#var spawn_enemies = load("res://game/game.gd").new()

const SAVE_PATH = "user://highscore.bin"
const max_eggs = 10

var math_problem_factory: Callable
var wave_number: int = 1
var berry_count: int = 0
var enemies_alive: int = 0
var math_problem: MathProblem
var egg_count: int = 10
var highest_wave: int = 0

signal wave_started(int)
signal wave_completed(int)

func save_highscore(highscore: int) -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_64(highscore)
	else:
		push_warning("Couldn't save highscore file: ", error_string(FileAccess.get_open_error()))

func load_highscore() -> int:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		return file.get_64()
	else:
		push_warning("Couldn't load highscore file: ", error_string(FileAccess.get_open_error()))
		return 0  # Changed from -1 to 0 for wave numbers

func lose_egg():
	egg_count -=1
	print("eggs", egg_count)
	if egg_count <= 0:
		game_over()

func get_egg_health_percent() -> float:
	return (float(egg_count) / float(max_eggs)) * 100.0

func game_over():
	if wave_number > highest_wave:
		highest_wave = wave_number
		save_highscore(highest_wave)
		print("New high score!")
	get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")

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

func on_enemy_reached_end():
	enemies_alive -=1
	Global.lose_egg()
	if enemies_alive <= 0:
		complete_wave()

func complete_wave() -> void:
	var prev_wave_number = wave_number
	print("wave ", prev_wave_number, " Completed")
	wave_number += 1
	berry_count += 1
	wave_completed.emit(prev_wave_number)

func base_difficulty():
	return ((wave_number)/ 3.0) * 10.

func difficulty() -> int:
	var base_diff = base_difficulty()
	var jitter =  randi_range(0, 7) - int(randi_range(-5, 10) * ((100. - base_diff) / 100.))
	return mini(ceili(base_diff + jitter), 100)

func reset():
	wave_number = 1
	egg_count = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	highest_wave = load_highscore()
