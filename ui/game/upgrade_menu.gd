extends Control

func _on_upgrade_requested(sender: UpgradeButton) -> void:
	if Global.berry_count == 0:
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
			print("Invalid Property")
	Global.berry_count -= 1
	sender.disabled = true
	print(sender.spell_name, " ", sender.property_name)
