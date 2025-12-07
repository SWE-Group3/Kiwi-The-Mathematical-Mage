extends Control

func _on_upgrade_requested(sender: UpgradeButton) -> void:
	if GameController.berry_count == 0:
		return
	var spell: Spell = SpellManager.spells[sender.spell_name]
	match sender.property_name:
		"Damage":
			spell.damage += 10
		"Potency":
			spell.potency += 0.5
		"Cooldown":
			spell.cooldown -= 1.0
		"Cost":
			spell.cost -= 1
		_:
			push_error("Invalid Property!")
	GameController.berry_count -= 1
	$TitleLabel.text = "Upgrades"
	sender.disabled = true
	prints(sender.spell_name, sender.property_name)
