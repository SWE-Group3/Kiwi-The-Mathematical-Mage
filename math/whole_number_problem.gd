class_name WholeNumberProblem extends MathProblem

var _answer: int

@warning_ignore("shadowed_variable_base_class")
func _init(question: String, answer: int, mana_reward: int):
	self.question = question
	self._answer = answer
	self.mana_reward = mana_reward

func verify_answer(answer: String) -> bool:
	# Yes, this means that users can type random nonsense and have it count as 0.
	# Yes, this means that you can have arbitrary nonsense between digits.
	# I am intentionally allowing loosening these restrictions so that fast typers
	# screwing up under pressure won't be penalized for accidentally pressing
	# multiple buttons they didn't expect. Totally not because the mixed numbers
	# have the same quirk and I'm too lazy to fix it. - Lily
	return int(answer.strip_edges()) == self._answer
