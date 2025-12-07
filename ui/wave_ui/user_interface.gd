extends CanvasLayer

@export var max_mana: float = 10.0
var current_mana: float = 0.0
var game
var problem

func _ready() -> void:
	GameController.wave_started.connect(_on_start_wave)
	GameController.wave_completed.connect(_on_wave_completed)
	game = get_node("/root/WaveController")
	problem = $BottomHUD/ProblemContainer
	SpellManager.mana_used.connect(_on_mana_use)
	game.mana_generated.connect(_on_mana_generation)
	problem.mana_generated.connect(_on_mana_generation)
	$PauseMenu/OptionsMenu.music_volume_changed.connect(_on_music_volume_changed)
 
func _on_start_wave(wave: int) -> void:
	$ManaGenerator.start()
	$TopHUD/WaveLabel.text = "Wave %d" % wave

func _on_start_wave_button_pressed() -> void:
	$BottomHUD/StartWaveButton.hide()
	$BottomHUD/UpgradesButton.hide()
	$BottomHUD/ProblemContainer.show()
	$BottomHUD/ProblemBackground.show()
	$IntermissionMusic.stop()
	$WaveMusic.play()
	GameController.start_wave()

func _on_wave_completed(_wave: int):
	$BottomHUD/StartWaveButton.show()
	$BottomHUD/UpgradesButton.show()
	$BottomHUD/ProblemContainer.hide()
	$BottomHUD/ProblemBackground.hide()
	$IntermissionMusic.play()
	$WaveMusic.stop()
	$ManaGenerator.stop()
	$UpgradeMenu/TitleLabel.text = "Upgrades\nBerry Count: %d" % [GameController.berry_count]

func _on_mana_generation(mana: float):
	current_mana = $BottomHUD/ResourceBarContainer/ManaBar.value
	current_mana += mana
	$BottomHUD/ResourceBarContainer/ManaBar.value = current_mana
	# Enable spells if we have enough total mana
	$BottomHUD/SpellContainer/FireSpellButton.disabled = current_mana < SpellManager.spells["Fire"].cost
	$BottomHUD/SpellContainer/IceSpellButton.disabled = current_mana < SpellManager.spells["Ice"].cost
	$BottomHUD/SpellContainer/LightningSpellButton.disabled = current_mana < SpellManager.spells["Lightning"].cost

func _on_mana_use(mana: float):
	current_mana = $BottomHUD/ResourceBarContainer/ManaBar.value
	current_mana -= mana
	$BottomHUD/ResourceBarContainer/ManaBar.value = current_mana
	# Enable spells if we have enough total mana
	$BottomHUD/SpellContainer/FireSpellButton.disabled = current_mana < SpellManager.spells["Fire"].cost
	$BottomHUD/SpellContainer/IceSpellButton.disabled = current_mana < SpellManager.spells["Ice"].cost
	$BottomHUD/SpellContainer/LightningSpellButton.disabled = current_mana < SpellManager.spells["Lightning"].cost

func _on_spell_button_pressed(spell_name: String) -> void:
	SpellManager.select_spell(spell_name)

func _on_music_volume_changed() -> void:
	var volume: float = GameController.settings.music_volume
	$IntermissionMusic.volume_linear = volume
	$WaveMusic.volume_linear = volume
