class_name MixedNumberProblem extends MathProblem

var _answer_numerator: int
var _answer_denominator: int

@warning_ignore("shadowed_variable_base_class")
func _init(question: String, answer_numerator: int, answer_denominator, mana_reward: int):
	self.question = question
	self._answer_numerator = answer_numerator
	self._answer_denominator = answer_denominator
	self.mana_reward = mana_reward

func verify_answer(answer: String) -> bool:
	var whole: int
	var numerator: int
	var denominator: int
	answer = answer.strip_edges()
	if "/" not in answer:
		# Just a whole number
		whole = int(answer)
		if whole == 0:
			return false
		numerator = 0
		denominator = 1
	else:
		# It's a mixed number.
		var mixed_number: PackedStringArray = answer.split("/")
		# Invalid mixed number if true.
		if mixed_number.size() != 2:
			return false
		denominator = int(mixed_number[1].strip_edges())
		if denominator == 0:
			return false
		var whole_and_numerator: PackedStringArray = mixed_number[0].strip_edges().split(" ")
		if whole_and_numerator.size() == 1:
			# No whole part, just a fraction.
			whole = 0
			numerator = int(whole_and_numerator[0].strip_edges())
			if numerator == 0:
				return false
		elif whole_and_numerator.size() == 2:
			# Whole part and fraction.
			whole = int(whole_and_numerator[0].strip_edges())
			numerator = int(whole_and_numerator[1].strip_edges())
			if whole == 0 or numerator == 0:
				return false
		else:
			# Invalid mixed number.
			return false
	# Invalid mixed number if true.
	if numerator >= denominator and denominator != 1:
		return false
	# Allow whole numbers. Everything else should not be simplified.
	if denominator == 1:
		denominator = _answer_denominator
	numerator += whole * denominator
	return numerator == _answer_numerator && denominator == _answer_denominator
