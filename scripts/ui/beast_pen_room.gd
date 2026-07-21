# ═══════════════════════════════════════════════════════════════
#  BEAST PEN ROOM CONTROLLER (beast_pen_room.gd)
#  Quản lý Chuồng Thú: Thu phục, Nuôi dưỡng & Tiến hóa Quái vật
# ═══════════════════════════════════════════════════════════════
extends Control

@export var lbl_info: Label
@export var btn_test_capture: Button
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	update_info()
	
	if btn_test_capture:
		btn_test_capture.pressed.connect(func():
			var species_keys := MonsterDatabase.SPECIES.keys()
			var random_species: String = species_keys[randi() % species_keys.size()]
			MonsterSystem.add_captured_monster(random_species)
			update_info()
		)

func update_info() -> void:
	var count: int = GameManager.get_monsters().size()
	if lbl_info: lbl_info.text = "Số lượng quái vật hiện có trong chuồng: %d quái" % count
