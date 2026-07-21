# ═══════════════════════════════════════════════════════════════
#  BUNKER ROOM CONTROLLER (bunker_room.gd)
#  Quản lý phòng Boong-ke: Danh sách và thông tin Người sống sót
# ═══════════════════════════════════════════════════════════════
extends Control

@export var lbl_capacity: Label
@export var btn_upgrade: Button
@export var btn_close: Button

func _ready() -> void:
	update_ui()
	if btn_close: btn_close.pressed.connect(func(): hide())
	if btn_upgrade:
		btn_upgrade.pressed.connect(func():
			if ProgressionSystem.upgrade_room("bunker"):
				update_ui()
		)

func update_ui() -> void:
	var lvl: int = GameManager.game_data.get("outpost_levels", {}).get("bunker", 1)
	var count: int = GameManager.get_survivors().size()
	var max_cap: int = 4 + (lvl - 1) * 2
	if lbl_capacity: lbl_capacity.text = "Sức chứa đội hình: %d / %d (Cấp %d)" % [count, max_cap, lvl]
