# ═══════════════════════════════════════════════════════════════
#  MECHA HANGAR ROOM CONTROLLER (mecha_hangar_room.gd)
# ═══════════════════════════════════════════════════════════════
extends Control

const MechSys = preload("res://scripts/systems/mecha_system.gd")

@export var lbl_count: Label
@export var btn_assemble: Button
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	if btn_assemble:
		btn_assemble.pressed.connect(func():
			MechSys.assemble_mecha(
				"Mecha Vệ Binh",
				"head_scout", "torso_assault",
				"arms_plasma", "legs_hover"
			)
			update_ui()
		)
	update_ui()

func update_ui() -> void:
	var count: int = GameManager.get_mechas().size()
	if lbl_count:
		lbl_count.text = "Số Mecha sở hữu: %d robot" % count
