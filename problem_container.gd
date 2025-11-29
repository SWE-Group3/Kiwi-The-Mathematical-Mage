extends VBoxContainer

var a: int
var b: int

func _ready() -> void:
	_focus_answer_box()
	$FeedbackLabel.visible = false
	generate_problem()

func generate_problem() -> void:
	a = randi() % 10 + 1
	b = randi() % 10 + 1
	$ProblemLabel.text = "What is %d + %d ?" % [a, b]
	$AnswerTextField.text = ""
	_focus_answer_box()

func _on_submit_button_pressed() -> void:
	var feedback_label = $FeedbackLabel
	var user_answer = int($AnswerTextField.text)
	var correct_answer = a + b
	if user_answer == correct_answer:
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
		print($AnswerTextField.has_focus())

func _focus_answer_box() -> void:
	$AnswerTextField.grab_focus()
	# or generate a new problem after correct
