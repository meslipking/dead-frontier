# ═══════════════════════════════════════════════════════════════
#  EXPLORATION REPORT CONTROLLER (exploration_report.gd)
#  Popup báo cáo phần thưởng Idle / Offline khi mở lại game
# ═══════════════════════════════════════════════════════════════
extends Control

@export var duration_label: Label
@export var gold_label: Label
@export var exp_label: Label
@export var kills_label: Label
@export var btn_claim: Button

func setup(report: Dictionary) -> void:
	var sec: int = report.get("duration_seconds", 0)
	var hrs := sec / 3600
	var mins := (sec % 3600) / 60
	
	if duration_label: duration_label.text = "Thời gian vắng mặt: %d giờ %d phút" % [hrs, mins]
	if gold_label: gold_label.text = "🪙 Vàng thu thập: +" + str(report.get("gold_earned", 0))
	if exp_label: exp_label.text = "⭐ Kinh nghiệm: +" + str(report.get("exp_earned", 0))
	if kills_label: kills_label.text = "💀 Zombie đã diệt: " + str(report.get("enemies_slain", 0))
	
	if btn_claim:
		btn_claim.pressed.connect(func(): hide())
