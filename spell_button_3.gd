extends Button

@export var spell_id: String = "lightning"

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	SpellManager.select_spell(spell_id)
