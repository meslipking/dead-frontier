# ═══════════════════════════════════════════════════════════════
#  COMMAND CENTER ROOM CONTROLLER (command_center_room.gd)
#  Quản lý Trung Tâm Chỉ Huy: Thống kê, Thành tựu, Prestige & Cài đặt
# ═══════════════════════════════════════════════════════════════
extends Control

@export var lbl_stats: Label
@export var btn_prestige: Button
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	update_stats()
	
	if btn_prestige:
		btn_prestige.pressed.connect(func():
			var p_level: int = GameManager.game_data.get("prestige_level", 0) + 1
			GameManager.game_data["prestige_level"] = p_level
			GameManager.add_currency(Constants.Currency.CRYSTALS, 50)
			AchievementSystem.check_achievement("ach_apocalypse")
			update_stats()
		)

func update_stats() -> void:
	var p_lvl: int = GameManager.game_data.get("prestige_level", 0)
	var ach_count: int = GameManager.game_data.get("achievements", []).size()
	if lbl_stats: lbl_stats.text = "Tận Thế Reset Level: %d | Thành tựu unlocked: %d / 50" % [p_lvl, ach_count]
