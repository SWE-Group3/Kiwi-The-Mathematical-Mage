extends ProgressBar

func _ready():
	update_health()

func _process(_delta: float):
	update_health()

func update_health():
	value = GameController.get_egg_health_percent()
