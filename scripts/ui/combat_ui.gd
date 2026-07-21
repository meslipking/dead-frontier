# ═══════════════════════════════════════════════════════════════
#  COMBAT UI CONTROLLER (combat_ui.gd)
#  Xử lý kết quả trận đấu 2D, Payouts & Achievements
# ═══════════════════════════════════════════════════════════════
extends Control

const AchievSys = preload("res://scripts/systems/achievement_system.gd")

@export var visual_combat: Node
@export var result_modal: Control
@export var result_title_label: Label
@export var rewards_label: Label
@export var btn_close: Button

func _ready() -> void:
	if result_modal: result_modal.visible = false
	if visual_combat:
		visual_combat.battle_finished.connect(_on_battle_finished)
	if btn_close:
		btn_close.pressed.connect(func(): queue_free())

func _on_battle_finished(victory: bool, rewards: Dictionary) -> void:
	if result_modal: result_modal.visible = true
	
	if victory:
		if result_title_label: result_title_label.text = "🎉 CHIẾN THẮNG RỰC RỠ!"
		var gold: int = rewards.get("gold", 0)
		var exp: int = rewards.get("exp", 0)
		GameManager.add_currency(Constants.Currency.GOLD, gold)
		if rewards_label: rewards_label.text = "Phần thưởng: +" + str(gold) + " Vàng | +" + str(exp) + " EXP"
		AchievSys.check_achievements()
	else:
		if result_title_label: result_title_label.text = "💀 THẤT BẠI!"
		if rewards_label: rewards_label.text = "Đội hình đã bị tiêu diệt. Hãy tăng cấp trang bị!"
