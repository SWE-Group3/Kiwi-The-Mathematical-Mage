class_name AdditionSubtractionProblemFactory extends MathProblemFactory

var _operator: String

func _init(adding: bool) -> void:
	self._operator = "+" if adding else "-"

func generate(difficulty: int) -> MathProblem:
	# Early waves should be just basic addition and subtraction.
	if difficulty > 20:
		# Calculate probability of generating a fraction problem.
		var probability: float
		if difficulty < 50:
			# Earlier waves should ease in the fractions.
			probability = (difficulty + 10.0) / 80.0
		else:
			# Later waves should be mostly fractions.
			probability = 0.75
		if randf() < probability:
			return _add_subtract_fractions_problem(difficulty, _operator)
	return _add_subtract_integers_problem(difficulty, _operator)

static func _add_subtract_integers_problem(difficulty: int, operator: String) -> MathProblem:
	var max_digits: int = difficulty / 20 + 2 - (randi() & 1)
	var upper := int(pow(10.0, max_digits)) - 1
	var left: int = randi_range(0, upper)
	var right: int = randi_range(0, upper)
	var answer: int
	if operator == "+":
		answer = left + right
	else:
		if left < right:
			var temp: int = left
			left = right
			right = temp
		answer = left - right
	var question: String = "%d %s %d = ?" % [left, operator, right]
	var mana_reward: int = 5 * (max_digits - 1);
	return WholeNumberProblem.new(question, answer, mana_reward)

static func _add_subtract_fractions_problem(difficulty: int, operator: String) -> MathProblem:
	var probability: float = (difficulty + 20.0) / 120.0
	var denominator: int = randi_range(2, 10)
	var numerator1: int = randi_range(0, denominator) + 1
	var numerator2: int = randi_range(0, denominator) + 1
	var numerator_answer: int
	if randf() < probability:
		var whole1: int = randi_range(1, 10)
		var whole2: int = randi_range(1, 10)
		var full_numerator1: int = numerator1 + whole1 * denominator
		var full_numerator2: int = numerator2 + whole2 * denominator
		if operator == '-' and full_numerator1 < full_numerator2:
			var temp: int = whole1
			whole1 = whole2
			whole2 = temp
			temp = numerator1
			numerator1 = numerator2
			numerator2 = temp
		var question: String = ("%d %d/%d %s %d %d/%d = ?" %
			[whole1, numerator1, denominator, operator, whole2, numerator2, denominator])
		numerator1 += whole1 * denominator
		numerator2 += whole2 * denominator
		if operator == "+":
			numerator_answer = numerator1 + numerator2
		else:
			numerator_answer = numerator1 - numerator2
		# These problems are all around the same difficulty.
		var mana_reward: int = 25 
		return MixedNumberProblem.new(question, numerator_answer, denominator, mana_reward)
	else:
		if operator == '-' and numerator1 < numerator2:
			var temp: int = numerator1
			numerator1 = numerator2
			numerator2 = temp
		var question = "%d/%d %s %d/%d = ?/%d" % [numerator1, denominator, operator, numerator2, denominator, denominator]
		if operator == "+":
			numerator_answer = numerator1 + numerator2
		else:
			numerator_answer = numerator1 - numerator2
		# These problems are all around the same difficulty.
		var mana_reward = 10 
		return WholeNumberProblem.new(question, numerator_answer, mana_reward)
