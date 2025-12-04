class_name MathProblemFactories extends Object


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


static func add_sub_problem_factory(difficulty: int, is_sub: bool) -> MathProblem:
	
	# early waves should be just basic addition and subtraction
	if difficulty <= 20:
		return _gen_simple_add_sub_int_problem(difficulty, is_sub)
	
	
	if difficulty >= 50:
		# later waves should be mostly fractions 
		var prob_fraction = 0.75
		if randf() < prob_fraction:
			return _gen_add_sub_fraction_problem(difficulty, is_sub)
	else:
		# earlier waves should ease in the fractions. 
		var prob_fraction = (difficulty + 10) / 70.
		if randf() < prob_fraction:
			return _gen_add_sub_fraction_problem(difficulty, is_sub)
	return _gen_simple_add_sub_int_problem(difficulty, is_sub)
	
static func _gen_simple_add_sub_int_problem(difficulty: int, is_sub: bool) -> MathProblem:
	var operands = _gen_int_add_sub_operands(difficulty)
	var left  = operands[0]
	var right = operands[1]
	var max_digits = operands[2];
	if is_sub and left < right:
		var tmp = left
		left = right
		right = tmp
	
	var op = "-" if is_sub else "+"
	var answer = left - right if is_sub else left + right
	var question = "%d %s %d = ?" % [left, op, right]
	var mana_reward = 5 * (max_digits - 1);
	return IntegerMathProblem.new(question, answer, mana_reward)
	

static func _gen_int_add_sub_operands(difficulty: int) -> Array[int]:
	@warning_ignore( "integer_division" )
	var max_digits = max(difficulty / 20 + 2 - (randi() & 1), 1)
	var upper = int(pow(10., max_digits))
	return  [randi() % upper, randi() % upper, max_digits]

static func _gen_add_sub_fraction_problem(difficulty: int, is_sub: bool) -> MathProblem:
	var prob_mixed = (float(difficulty) + 20) / 120.
	var is_mixed = randf() < prob_mixed
	var den = randi() % 9 + 2
	var num1 = randi_range(1, den - 1)
	var num2 = randi_range(1, den - 1)
	var op = "-" if is_sub else "+"
	if is_mixed:
		var whole_part1 = randi() % 10 + 1
		var whole_part2 = randi() % 10 + 1
		var full_num1 = num1 + whole_part1 * den
		var full_num2 = num2 + whole_part2 * den
		if full_num1 < full_num2 and is_sub:
			var tmp1 = whole_part1
			var tmp2 = num1
			whole_part1 = whole_part2
			num1 = num2
			whole_part2 = tmp1
			num2 = tmp2
			
		var question = "%d %d/%d %s %d %d/%d = ?" % [whole_part1, num1, den, op, whole_part2, num2, den]
		num1 += whole_part1 * den
		num2 += whole_part2 * den
		
		# these problems are all around the same difficulty 
		var mana_reward = 25 
		var answer_num = num1 - num2 if is_sub else num1 + num2
		return MixedNumberMathProblem.new(question, answer_num, den, mana_reward)
	else:
		if is_sub and num1 > num2:
			var tmp = num2
			num2 = num1
			num1 = tmp
		
		var question = "%d/%d %s %d/%d = ?/%d" % [num1, den, op, num2, den, den]
		var answer = num1 - num2 if is_sub else num1 + num2
		# these problems are all around the same difficulty 
		var mana_reward = 10 
		return IntegerMathProblem.new(question, answer, mana_reward)
		
		
static func multiplication_problem_factory(difficulty: int) -> MathProblem:
	if difficulty <= 20:
		return _gen_int_times_int_problem(difficulty)
	return _gen_int_times_int_problem(difficulty)
	
static func _gen_int_times_int_problem(difficulty: int) -> MathProblem:
	var top_num_digits: int
	var bottom_num_digits: int
	if difficulty <= 20:
		# early waves are easy multiplication table review
		top_num_digits = 1
		bottom_num_digits = 1
	else:
		# starts with heavy bias towards multiplying by single digit
		# but then as the game goes on, becomes slightly biased towards 
		# 2 by 2
		var prob_2_digits_bottom = ((difficulty + 30.) / 200.)
		bottom_num_digits = 2 if randf() < prob_2_digits_bottom else 1
		if bottom_num_digits == 2:
			top_num_digits = 2
		else:
			@warning_ignore( "integer_division" )
			top_num_digits = difficulty / 20 + 2 - (randi() & 1)
	var top: int
	var bottom: int
	# just make it a multiplication table instead if top and bottom is 1.
	# it's more interesting.
	if top_num_digits == 1 && bottom_num_digits == 1:
		top = randi_range(1, 12)
		bottom = randi_range(1, 12)
		
	else:
		@warning_ignore("narrowing_conversion")
		top = randi_range(pow(10., top_num_digits - 1), pow(10., top_num_digits) - 1)
		@warning_ignore("narrowing_conversion")
		bottom = randi_range(1, pow(10., bottom_num_digits) - 1)
	
	var answer = top * bottom
	
	var question: String
	var reward: int
	
	question = "%d × %d = ?" % [top, bottom]
	reward = top_num_digits * 5 + 5
	return IntegerMathProblem.new(question, answer, reward)
