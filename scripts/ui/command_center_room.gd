# ═══════════════════════════════════════════════════════════════
#  COMMAND CENTER ROOM CONTROLLER (command_center_room.gd)
# ═══════════════════════════════════════════════════════════════
extends Control

const AchSys = preload("res://scripts/systems/achievement_system.gd")

@export var lbl_stats: Label
@export var btn_prestige: Button
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	if btn_prestige:
		btn_prestige.pressed.connect(func():
			var p_lvl: int = GameManager.game_data.get("prestige_level", 0) + 1
			GameManager.game_data["prestige_level"] = p_lvl
			GameManager.add_currency(Constants.Currency.CRYSTALS, 50)
			EventBus.prestige_activated.emit(50)
			update_ui()
		)
	update_ui()

func update_ui() -> void:
	var achs: Array = GameManager.game_data.get("achievements", [])
	var p_lvl: int = GameManager.game_data.get("prestige_level", 0)
	if lbl_stats:
		lbl_stats.text = "Thành tựu đã mở: %d / 35 | Cấp Prestige: %d" % [achs.size(), p_lvl]
