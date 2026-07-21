# ═══════════════════════════════════════════════════════════════
#  RADIO TOWER ROOM CONTROLLER (radio_tower_room.gd)
#  Quản lý phát tín hiệu tuyển mộ Người sống sót mới
# ═══════════════════════════════════════════════════════════════
extends Control

@export var btn_scan: Button
@export var btn_close: Button
@export var lbl_status: Label

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	if btn_scan:
		btn_scan.pressed.connect(func():
			if GameManager.spend_currency(Constants.Currency.GOLD, 50):
				var new_surv := SurvivorDatabase.generate_random_survivor(str(randi() % 10000))
				GameManager.get_survivors().append(new_surv)
				if lbl_status: lbl_status.text = "Đã tuyển mộ: " + new_surv["name"] + " (" + new_surv["class_name"] + ")"
			else:
				if lbl_status: lbl_status.text = "Không đủ Vàng (Cần 50 Vàng)"
		)
