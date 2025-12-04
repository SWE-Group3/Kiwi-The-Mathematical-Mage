class_name IntegerMathProblem extends MathProblem

var answer_value: int

func _init(string: String, answer: int, reward: int):
	question = string
	answer_value = answer
	mana_reward = reward
	
	
func verify_answer(input: String) -> bool:
	return input.strip_edges(true, true) == ("%d" % [answer_value])
