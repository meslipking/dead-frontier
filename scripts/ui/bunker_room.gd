# ═══════════════════════════════════════════════════════════════
#  BUNKER ROOM CONTROLLER (bunker_room.gd)
# ═══════════════════════════════════════════════════════════════
extends Control

const ProgSys = preload("res://scripts/systems/progression_system.gd")

@export var lbl_capacity: Label
@export var btn_upgrade: Button
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	if btn_upgrade:
		btn_upgrade.pressed.connect(func():
			if ProgSys.upgrade_room("bunker"):
				update_ui()
		)
	update_ui()

func update_ui() -> void:
	var lvl: int = GameManager.game_data.get("outpost_levels", {}).get("bunker", 1)
	var cap: int = 4 + (lvl - 1) * 2
	var count: int = GameManager.get_survivors().size()
	if lbl_capacity:
		lbl_capacity.text = "Sức chứa đội hình: %d / %d (Cấp %d)" % [count, cap, lvl]
