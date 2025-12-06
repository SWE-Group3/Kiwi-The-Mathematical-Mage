class_name UpgradeButton extends TextureButton

@export var spell_name: String
@export var property_name: String

signal upgrade_requested(sender: UpgradeButton)

func _on_pressed() -> void:
	upgrade_requested.emit(self)
