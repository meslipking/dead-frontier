# ═══════════════════════════════════════════════════════════════
#  RADIO TOWER ROOM CONTROLLER (radio_tower_room.gd)
# ═══════════════════════════════════════════════════════════════
extends Control

const SurvDb = preload("res://scripts/data/survivor_database.gd")

@export var btn_scan: Button
@export var lbl_status: Label
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	if btn_scan:
		btn_scan.pressed.connect(func():
			if GameManager.spend_currency(Constants.Currency.GOLD, 50):
				var new_surv: Dictionary = SurvDb.generate_random_survivor()
				GameManager.get_survivors().append(new_surv)
				if lbl_status: lbl_status.text = "📻 ĐÃ CHUYỂN MỘ: " + new_surv.get("name", "")
			else:
				if lbl_status: lbl_status.text = "❌ Không đủ 50 Vàng!"
		)
