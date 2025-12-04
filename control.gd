extends Control

	
@onready var problem_label = $VBoxContainer/ProblemLabel
@onready var answer_input = $VBoxContainer/AnswerInput
@onready var submit_button = $VBoxContainer/SubmitButton
@onready var feedback_label = $VBoxContainer/FeedbackLabel


var wave_number: int = 1;
var math_problem: MathProblem

func complete_wave() -> void:
	wave_number += 1
	
func base_difficulty():
	return ((wave_number)/ 3.0) * 10.

func difficulty() -> int:
	var base_diff = base_difficulty()
	var jitter =  randi_range(0, 7) - int(randi_range(-5, 10) * ((100. - base_diff) / 100.))
	return mini(ceili(base_diff + jitter), 100)

func _ready() -> void:
	_focus_answer_box()
	feedback_label.visible = false
	generate_problem()

func generate_problem() -> void:
	math_problem = Global.math_problem_factory.call(difficulty());
	problem_label.text = math_problem.question
	answer_input.text = ""
	_focus_answer_box()

func _on_submit_button_pressed() -> void:
	if math_problem.verify_answer(answer_input.text):
		feedback_label.text = "Correct!"
		feedback_label.add_theme_color_override("font_color", Color.GREEN)
		await get_tree().create_timer(1.0).timeout
		feedback_label.visible = false
		generate_problem()
	else:
		feedback_label.text = "Incorrect, try again!"
		feedback_label.add_theme_color_override("font_color", Color.RED)
	feedback_label.visible = true
	_focus_answer_box()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_on_submit_button_pressed()
		_focus_answer_box()

func _focus_answer_box() -> void:
	answer_input.grab_focus()
	
