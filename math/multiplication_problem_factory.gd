class_name MultiplicationProblemFactory extends MathProblemFactory

func generate(difficulty: int) -> MathProblem:
	if difficulty > 20:
		# Calculate probability of generating a fraction problem.
		var probability: float
		if difficulty < 50:
			# Earlier waves should ease in the fractions.
			probability = (difficulty + 10.0) / 80.0
		else:
			# Maximum probability is 75%.
			probability = 0.75
		if randf() < probability:
			return _integer_times_fraction_problem(difficulty)
	return _integer_times_integer_problem(difficulty)

static func _integer_times_integer_problem(difficulty: int) -> MathProblem:
	var top_num_digits: int
	var bottom_num_digits: int
	if difficulty <= 20:
		# Early waves are easy multiplication table review.
		top_num_digits = 1
		bottom_num_digits = 1
	else:
		# Starts with heavy bias towards multiplying by single digit
		# but then as the game goes on, becomes slightly biased towards 
		# 2 by 2.
		var probability: float = (difficulty + 30.0) / 200.0
		if randf() < probability:
			top_num_digits = 2
			bottom_num_digits = 2
		else:
			top_num_digits = difficulty / 20 + 2 - (randi() & 1)
			bottom_num_digits = 1
	var top: int
	var bottom: int
	# Just make it a multiplication table instead if top and bottom is 1.
	# It's more interesting.
	if top_num_digits == 1 && bottom_num_digits == 1:
		top = randi_range(0, 12)
		bottom = randi_range(0, 12)
	else:
		top = randi_range(int(pow(10., top_num_digits - 1)), int(pow(10., top_num_digits)) - 1)
		bottom = randi_range(1, int(pow(10., bottom_num_digits)) - 1)
	var answer: int = top * bottom
	var question: String = "%d × %d = ?" % [top, bottom]
	var reward: int = top_num_digits * 5 + 5
	return IntegerMathProblem.new(question, answer, reward)

static func _integer_times_fraction_problem(_difficulty: int) -> MathProblem:
	var denominator: int = randi() % 10 + 2
	var numerator: int = randi_range(1, denominator - 1)
	var multiple: int = randi() % 10 + 2
	var question: String
	if randf() < 0.5:
		question = "%d × %d / %d = ?" % [multiple, numerator, denominator]
	else:
		question = "%d / %d × %d = ?" % [numerator, denominator, multiple]
	var answer: int = numerator * multiple
	var reward: int = 20
	return MixedNumberMathProblem.new(question, answer, denominator, reward)
