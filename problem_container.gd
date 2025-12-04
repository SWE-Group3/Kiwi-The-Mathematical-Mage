extends VBoxContainer


func _ready() -> void:
	_focus_answer_box()
	$FeedbackLabel.visible = false
	generate_problem()

func generate_problem() -> void:
	Global.regen_math_problem()
	$ProblemLabel.text = Global.math_problem.question
	$AnswerTextField.text = ""
	_focus_answer_box()

func _on_submit_button_pressed() -> void:
	if Global.math_problem.verify_answer($AnswerTextField.text):
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
