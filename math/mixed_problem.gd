class_name MixedNumberMathProblem extends MathProblem

var answer_num: int
var answer_den: int
func _init(string: String, answer_numerator: int, answer_denominator, reward: int):
	question = string
	mana_reward = reward
	answer_num = answer_numerator
	answer_den = answer_denominator
	
func verify_answer(input: String) -> bool:
	input = input.strip_edges(true, true)
	var whole
	var num
	var den
	# Just a whole number
	if not "/" in input:
		whole = int(input)
		if whole == 0: return false
		num = 0
		den = 1
	else:
		var parts = input.split("/")
		if parts.size() != 2:
			return false
		var whole_and_num = parts[0]
		var den_str = parts[1]
		den = int(den_str.strip_edges(true, true))
		if den == 0:
			return false
		var whole_and_num_arr = whole_and_num.strip_edges(true, true).split(" ")
		
		# no whole part, just fraction
		if whole_and_num_arr.size() == 1:
			whole = 0
			num = int(whole_and_num_arr[0].strip_edges(true, true))
			if num == 0: return false
		elif whole_and_num_arr.size() == 2:
			whole = int(whole_and_num_arr[0].strip_edges(true, true))
			num = int(whole_and_num_arr[1].strip_edges(true, true))
			if whole == 0 or num == 0: return false
		else: return false
			
	if num >= den and den != 1:
		return false
	# allow using whole numbers. Everything else should not be simplified
	if den == 1:
		den = answer_den
	num += whole * den
	return num == answer_num && den == answer_den
			
				
	
