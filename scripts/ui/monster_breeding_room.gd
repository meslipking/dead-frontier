# ═══════════════════════════════════════════════════════════════
#  MONSTER BREEDING ROOM CONTROLLER (monster_breeding_room.gd)
#  Phòng Thí Nghiệm Đột Biến & Lai Tạo Quái Vật 2 Hệ Nguyên Tố
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var parent1_icon: TextureRect
@export var parent2_icon: TextureRect
@export var offspring_icon: TextureRect
@export var lbl_offspring_name: Label
@export var btn_fuse: Button
@export var btn_close: Button

var fusion_recipes := [
	{ "p1": "Night Terror", "p2": "Hailstorm", "child": "🐲 FROZEN HELL DRAKE (BĂNG + LỬA)" },
	{ "p1": "Iron Defender", "p2": "Tempest", "child": "🦁 TITAN CHIMERA (THÉP + PHONG)" },
	{ "p1": "Shadow Dancer", "p2": "King's Hand", "child": "🐉 CYBER VOID HYDRA (HƯ KHÔNG + PLASMA)" }
]

var cur_recipe_idx := 0

func _ready() -> void:
	_update_display()
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)
		
	if btn_fuse:
		btn_fuse.pressed.connect(func():
			AnimEng.animate_button_click(btn_fuse)
			AudioManager.play_sfx("ui_click")
			if GameManager.spend_currency(Constants.Currency.GOLD, 2):
				cur_recipe_idx = (cur_recipe_idx + 1) % fusion_recipes.size()
				_update_display()
				ToastMgr.show_toast("🧬 LAI TẠO ĐỘT BIẾN THÀNH CÔNG!", Color(0.8, 0.4, 0.9))
			else:
				ToastMgr.show_toast("❌ Không đủ Vàng!", Color(0.9, 0.3, 0.3))
		)

func _update_display() -> void:
	var rec: Dictionary = fusion_recipes[cur_recipe_idx]
	if parent1_icon: parent1_icon.texture = MasterPixel.get_adventurer_texture(rec["p1"])
	if parent2_icon: parent2_icon.texture = MasterPixel.get_adventurer_texture(rec["p2"])
	if offspring_icon: offspring_icon.texture = MasterPixel.get_adventurer_texture("King's Hand")
	if lbl_offspring_name: lbl_offspring_name.text = rec["child"]
