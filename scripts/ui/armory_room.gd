# ═══════════════════════════════════════════════════════════════
#  ARMORY ROOM CONTROLLER (armory_room.gd) — Storage Inventory Modal
#  Kho Hàng Lưới Item 4x4 Grid (Matching Reference Image 7)
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var grid_container: GridContainer
@export var lbl_capacity: Label
@export var btn_close: Button

var inventory_items := [
	{ "name": "Plasma Rifle", "count": 1, "type": "WEAPON" },
	{ "name": "Chainsaw Greatsword", "count": 1, "type": "WEAPON" },
	{ "name": "Titan Exo", "count": 2, "type": "ARMOR" },
	{ "name": "Cyber Visor", "count": 3, "type": "ACC" },
	{ "name": "Ruby Gem", "count": 5, "type": "GEM" },
	{ "name": "Sapphire Gem", "count": 4, "type": "GEM" },
	{ "name": "Niken Alloy", "count": 68, "type": "MAT" },
	{ "name": "Energy Battery", "count": 12, "type": "MAT" }
]

func _ready() -> void:
	_populate_storage()
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)

func _populate_storage() -> void:
	if not grid_container: return
	for child in grid_container.get_children():
		child.queue_free()
		
	if lbl_capacity: lbl_capacity.text = "SỨC CHỨA KHO: " + str(inventory_items.size()) + " / 68 Ô"
	
	for i in range(16): # 4x4 Grid
		var slot_panel := PanelContainer.new()
		slot_panel.custom_minimum_size = Vector2(56, 56)
		
		if i < inventory_items.size():
			var item: Dictionary = inventory_items[i]
			
			var slot_icon := TextureRect.new()
			slot_icon.custom_minimum_size = Vector2(48, 48)
			slot_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			slot_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			slot_icon.texture = MasterPixel.get_modern_gear_texture(str(item["name"]))
			slot_panel.add_child(slot_icon)
			
			var count_lbl := Label.new()
			count_lbl.text = "x" + str(item["count"])
			count_lbl.add_theme_font_size_override("font_size", 9)
			count_lbl.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
			slot_panel.add_child(count_lbl)
			
			var cur_item: Dictionary = item
			slot_panel.gui_input.connect(func(ev):
				if ev is InputEventMouseButton and ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
					AnimEng.animate_button_click(slot_panel)
					AudioManager.play_sfx("ui_click")
					ToastMgr.show_toast("📦 Trang Bị: " + str(cur_item["name"]) + " (Số lượng: " + str(cur_item["count"]) + ")", Color(0.2, 0.85, 1.0))
			)
			
		grid_container.add_child(slot_panel)
