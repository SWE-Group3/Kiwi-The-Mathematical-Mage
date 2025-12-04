class_name IntegerMathProblem extends MathProblem

var answer_value: int

func _init(string: String, answer: int, reward: int):
	question = string
	answer_value = answer
	mana_reward = reward

func verify_answer(input: String) -> bool:
	# yes, this means that users can type random nonsense and have it count as 0.
	# yes, this means that you can have arbitrary nonsense between digits.
	# I am intentionally allowing loosening these restrictions so that fast typers
	# screwing up under pressure won't be penalized for accidentally pressing
	# multiple buttons they didn't expect. Totally not because the mixed numbers
	# have the same quirk and I'm too lazy to fix it.
	return int(input.strip_edges(true, true)) == answer_value
