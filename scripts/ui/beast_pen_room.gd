# ═══════════════════════════════════════════════════════════════
#  BEAST PEN ROOM CONTROLLER (beast_pen_room.gd)
# ═══════════════════════════════════════════════════════════════
extends Control

const MonDb = preload("res://scripts/data/monster_database.gd")
const MonSys = preload("res://scripts/systems/monster_system.gd")

@export var lbl_count: Label
@export var btn_capture: Button
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	if btn_capture:
		btn_capture.pressed.connect(func():
			var species_keys := MonDb.SPECIES.keys()
			var random_species: String = species_keys[randi() % species_keys.size()]
			MonSys.add_captured_monster(random_species)
			update_ui()
		)
	update_ui()

func update_ui() -> void:
	var count: int = GameManager.get_monsters().size()
	if lbl_count:
		lbl_count.text = "Số quái vật thu phục: %d loài" % count
