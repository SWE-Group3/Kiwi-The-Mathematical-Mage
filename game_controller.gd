extends Node

const SETTINGS_PATH: String = "res://game_settings.tres"
const SAVE_PATH: String = "res://game_save.tres"
const MAX_EGG_COUNT: int = 3
const MAX_EGG_HEALTH: int = 3

var settings: GameSettings
var save: GameSave
var math_problem_factory: MathProblemFactory
var math_problem: MathProblem
var tile_map_layer: TileMapLayer
var wave_number: int
var berry_count: int
var enemies_alive: int
var egg_count: int
var egg_health: int

signal wave_started(wave: int)
signal wave_completed(wave: int)

func get_egg_health_percent() -> float:
	var numerator: float = (egg_count - 1) * MAX_EGG_HEALTH + egg_health
	var denominator: float = MAX_EGG_COUNT * MAX_EGG_HEALTH
	return numerator / denominator * 100.0

func generate_math_problem():
	math_problem = math_problem_factory.generate(get_difficulty());

func start_wave() -> void:
	var wave_controller = get_node("/root/WaveController")
	wave_started.emit(wave_number)
	var spawn_points: int = wave_number * 5
	var results = wave_controller.pick_enemies(spawn_points)
	enemies_alive = results.count
	wave_controller.spawn_enemies(results.list)

func on_enemy_death():
	enemies_alive -= 1
	prints("Enemy died. Enemies left:", enemies_alive)
	if enemies_alive <= 0:
		complete_wave()

func on_enemy_reached_end(damage: int):
	# Enemies disappear after hitting egg.
	enemies_alive -= 1
	egg_health -= damage
	prints("Egg Health:", egg_health)
	# Egg was consumed if true.
	if egg_health <= 0:
		egg_count -= 1
		if tile_map_layer == null:
			push_error("TileMapLayer is not assigned!")
		tile_map_layer.set_cell(Vector2i(1, 9), 2, Vector2i((egg_count - 1) * MAX_EGG_HEALTH + egg_health, 0), 0)
		# Game over if true.
		if egg_count <= 0:
			# New high score if true.
			if save.high_score < wave_number:
				save.high_score = wave_number
				ResourceSaver.save(save, SAVE_PATH)
				print("New high score!")
			get_tree().change_scene_to_file("res://ui/menu/main_menu.tscn")
		# Roll in next egg.
		egg_health = MAX_EGG_HEALTH
	if enemies_alive <= 0:
		complete_wave()

func complete_wave() -> void:
	var previous_wave_number: int = wave_number
	prints("Wave", previous_wave_number, "completed.")
	wave_number += 1
	berry_count += 1
	wave_completed.emit(previous_wave_number)

func get_difficulty() -> int:
	var base: float = wave_number / 0.3
	var jitter = randi_range(0, 7) - int(randi_range(-5, 10) * ((100.0 - base) / 100.0))
	return mini(ceili(base + jitter), 100)

func reset():
	wave_number = 1
	berry_count = 0
	enemies_alive = 0
	egg_count = MAX_EGG_COUNT
	egg_health = MAX_EGG_HEALTH

func _ready() -> void:
	settings = preload(SETTINGS_PATH)
	save = preload(SAVE_PATH)
