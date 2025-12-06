extends CanvasLayer

# TODO - Add functionality to UI

var Game 
var Problem
@export var maxMana: float  = 10.0

var currentMana: float = 0.0

func _ready() -> void:
	Global.wave_started.connect(_on_start_wave)
	Global.wave_completed.connect(_on_wave_completed)
	Game = get_node("/root/Game")
	Problem = get_node("BottomHUD/ProblemContainer")
	SpellManager.mana_used.connect(_on_mana_use)
	Game.mana_generated.connect(_on_mana_generation)
	Problem.mana_generated.connect(_on_mana_generation)
	$BottomHUD/ProblemContainer.visible = false
	$BottomHUD/ProblemBackground.visible = false
 
func _on_start_wave(wave: int) -> void:
	$ManaGenerator.start()
	$TopHUD/WaveLabel.text = "Wave %d" % wave
	
func _on_start_wave_button_pressed() -> void:
	$BottomHUD/StartWaveButton.visible = false
	$BottomHUD/UpgradesButton.visible = false
	$BottomHUD/ProblemContainer.visible = true
	$BottomHUD/ProblemBackground.visible = true
	Global.start_wave()
	
	
func _on_wave_completed(_wave: int):
	$BottomHUD/StartWaveButton.visible = true
	$BottomHUD/UpgradesButton.visible =true
	$BottomHUD/ProblemContainer.visible = false
	$BottomHUD/ProblemBackground.visible = false
	$ManaGenerator.stop()


func _on_mana_generation(_mana: float):
	currentMana = $BottomHUD/ResourceBarContainer/ManaBar.value
	currentMana += _mana
	$BottomHUD/ResourceBarContainer/ManaBar.value = currentMana

	# Enable spells if we have enough total mana
	$BottomHUD/SpellContainer/SpellButton1.disabled = currentMana < Game.burnMana
	$BottomHUD/SpellContainer/SpellButton2.disabled = currentMana < Game.freezeMana
	$BottomHUD/SpellContainer/SpellButton3.disabled = currentMana < Game.chargeMana

	
func _on_mana_use(_mana: float):
	currentMana = $BottomHUD/ResourceBarContainer/ManaBar.value
	currentMana -= _mana
	$BottomHUD/ResourceBarContainer/ManaBar.value = currentMana

	# Enable spells if we have enough total mana
	$BottomHUD/SpellContainer/SpellButton1.disabled = currentMana < Game.burnMana
	$BottomHUD/SpellContainer/SpellButton2.disabled = currentMana < Game.freezeMana
	$BottomHUD/SpellContainer/SpellButton3.disabled = currentMana < Game.chargeMana
	
