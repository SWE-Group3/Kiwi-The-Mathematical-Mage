class_name DivisionProblemFactory extends MathProblemFactory

func generate(difficulty: int) -> MathProblem:
	var dividend_digits: int = difficulty / 20 + 1 + randi_range(0, 1)
	var divisor: int = randi_range(2, 10)
	var dividend: int = randi_range(int(pow(10, dividend_digits - 1)), int(pow(10, dividend_digits)) - 1)
	var mana_reward: int = dividend_digits * 7 + 5
	var answer: int
	var question: String
	# 50/50 chance of either remainder or quotient problem.
	if randi_range(0, 1):
		question = "What is the quotient of %d ÷ %d?" % [dividend, divisor]
		answer = dividend / divisor
	else:
		question = "What is the remainder of %d ÷ %d?" % [dividend, divisor]
		answer = dividend % divisor
	return WholeNumberProblem.new(question, answer, mana_reward)
