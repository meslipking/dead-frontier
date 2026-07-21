# ═══════════════════════════════════════════════════════════════
#  VISUAL COMBAT CONTROLLER (visual_combat.gd)
#  Điều khiển Sàn đấu 2D trực quan 4v4 với Floating Damage Text
# ═══════════════════════════════════════════════════════════════
extends Node2D

const CombatMgr = preload("res://scripts/combat/combat_manager.gd")
const PixelGen = preload("res://scripts/utils/pixel_art_generator.gd")

signal battle_finished(victory: bool, rewards: Dictionary)

@export var player_team_container: Node2D
@export var enemy_team_container: Node2D
@export var btn_speed_1x: Button
@export var btn_speed_2x: Button
@export var btn_speed_4x: Button
@export var btn_skip: Button

var battle_speed: float = 1.0
var battle_active: bool = false

func _ready() -> void:
	_setup_speed_buttons()
	start_battle()

func _setup_speed_buttons() -> void:
	if btn_speed_1x: btn_speed_1x.pressed.connect(func(): set_speed(1.0))
	if btn_speed_2x: btn_speed_2x.pressed.connect(func(): set_speed(2.0))
	if btn_speed_4x: btn_speed_4x.pressed.connect(func(): set_speed(4.0))
	if btn_speed_skip: btn_speed_skip.pressed.connect(func(): skip_battle())

@export var btn_speed_skip: Button

func set_speed(spd: float) -> void:
	battle_speed = spd
	Engine.time_scale = battle_speed

func skip_battle() -> void:
	Engine.time_scale = 1.0
	_finish_battle(true)

func start_battle() -> void:
	battle_active = true
	var player_team := GameManager.get_survivors()
	var enemy_team := [
		{ "id": "m1", "name": "Zombie Thường", "stats": { "hp": 50, "atk": 8, "def": 3, "spd": 8 } },
		{ "id": "m2", "name": "Zombie Biến Dị", "stats": { "hp": 80, "atk": 12, "def": 5, "spd": 10 } }
	]
	
	var result: Dictionary = CombatMgr.simulate_battle(player_team, enemy_team)
	var victory: bool = result.get("victory", true)
	
	# Simulate 2D visual attack delay
	var timer := get_tree().create_timer(1.5 / battle_speed)
	timer.timeout.connect(func(): _finish_battle(victory))

func _finish_battle(victory: bool) -> void:
	Engine.time_scale = 1.0
	battle_active = false
	var rewards := { "gold": 50, "exp": 100 }
	battle_finished.emit(victory, rewards)
