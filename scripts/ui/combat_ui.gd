# ═══════════════════════════════════════════════════════════════
#  COMBAT UI CONTROLLER (combat_ui.gd)
#  Quản lý màn hình chiến đấu trực quan 2D, tốc độ trận đấu & phần thưởng
# ═══════════════════════════════════════════════════════════════
extends Control

@export var visual_controller: VisualCombatController
@export var log_text_edit: TextEdit
@export var btn_close: Button
@export var result_label: Label
@export var loot_container: VBoxContainer

func start_battle(player_team: Array, enemies: Array) -> void:
	show()
	if result_label: result_label.text = "⚔️ ĐANG CHIẾN ĐẤU..."
	if visual_controller:
		visual_controller.start_visual_battle(player_team, enemies)

func _ready() -> void:
	if btn_close:
		btn_close.pressed.connect(func(): hide())
		
	if visual_controller:
		visual_controller.battle_finished.connect(_on_battle_finished)

func _on_battle_finished(victory: bool, rewards: Dictionary) -> void:
	var gold: int = rewards.get("gold_reward", 0)
	var exp_pts: int = rewards.get("exp_reward", 0)
	
	if victory:
		if result_label: result_label.text = "🏆 CHIẾN THẮNG! +%d Vàng | +%d EXP" % [gold, exp_pts]
		GameManager.add_currency(Constants.Currency.GOLD, gold)
		AchievementSystem.check_achievement("ach_first_blood")
	else:
		if result_label: result_label.text = "💀 THẤT BẠI! Thử lại sau."
