# ═══════════════════════════════════════════════════════════════
#  COMBAT UI CONTROLLER (combat_ui.gd)
#  Quản lý màn hình chiến đấu, combat log và phần thưởng
# ═══════════════════════════════════════════════════════════════
extends Control

@export var log_text_edit: TextEdit
@export var btn_close: Button
@export var result_label: Label

func start_battle(player_team: Array, enemies: Array) -> void:
	show()
	if log_text_edit: log_text_edit.text = "Đang bắt đầu trận đấu...\n"
	
	var res := CombatManager.simulate_battle(player_team, enemies)
	var logs: Array = res.get("logs", [])
	
	if log_text_edit:
		var full_log := ""
		for line in logs:
			full_log += line + "\n"
		log_text_edit.text = full_log
		
	if result_label:
		result_label.text = "CHIẾN THẮNG! +%d Vàng" % res.get("gold_reward", 0) if res.get("victory", false) else "THẤT BẠI!"
		
	if res.get("victory", false):
		GameManager.add_currency(Constants.Currency.GOLD, res.get("gold_reward", 0))

func _ready() -> void:
	if btn_close:
		btn_close.pressed.connect(func(): hide())
