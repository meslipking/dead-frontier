# ═══════════════════════════════════════════════════════════════
#  MECHA HANGAR ROOM CONTROLLER (mecha_hangar_room.gd)
#  Quản lý Nhà Kho Mecha: Lắp ráp Robot & Nạp Nhiên liệu
# ═══════════════════════════════════════════════════════════════
extends Control

@export var lbl_info: Label
@export var btn_assemble: Button
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	update_info()
	
	if btn_assemble:
		btn_assemble.pressed.connect(func():
			if GameManager.spend_currency(Constants.Currency.ALLOYS, 10):
				var mname := "Mecha-V" + str(randi() % 100)
				MechaSystem.assemble_mecha(mname, "head_scout", "torso_assault", "arms_plasma", "legs_hover")
				update_info()
		)

func update_info() -> void:
	var count: int = GameManager.get_mechas().size()
	if lbl_info: lbl_info.text = "Số lượng Mecha đã lắp ráp: %d robot" % count
