extends VBoxContainer

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
	$FeedbackLabel.visible = false
	generate_problem()

func generate_problem() -> void:
	math_problem = Global.math_problem_factory.call(difficulty());
	$ProblemLabel.text = math_problem.question
	$AnswerTextField.text = ""
	_focus_answer_box()

func _on_submit_button_pressed() -> void:
	if math_problem.verify_answer($AnswerTextField.text):
		$FeedbackLabel.text = "Correct!"
		$FeedbackLabel.add_theme_color_override("font_color", Color.GREEN)
		await get_tree().create_timer(1.0).timeout
		$FeedbackLabel.visible = false
		generate_problem()
	else:
		$FeedbackLabel.text = "Incorrect, try again!"
		$FeedbackLabel.add_theme_color_override("font_color", Color.RED)
	$FeedbackLabel.visible = true
	_focus_answer_box()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_on_submit_button_pressed()
		_focus_answer_box()

func _focus_answer_box() -> void:
	$AnswerTextField.grab_focus()
