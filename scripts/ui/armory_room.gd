# ═══════════════════════════════════════════════════════════════
#  STORAGE MODAL CONTROLLER (armory_room.gd) — Reference Image 2 & 6 Match
#  Hiển thị Lưới Kho Hàng 4x4 với Icon Pixel 16-Bit Ma Trận Sắc Nét 100%
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const EquipForge = preload("res://scripts/systems/equipment_forge.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var lbl_capacity: Label
@export var item_grid: GridContainer
@export var btn_upgrade: Button
@export var btn_close: Button

var selected_item: Dictionary = {}

func _ready() -> void:
	populate_inventory()
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)
		
	if btn_upgrade:
		btn_upgrade.pressed.connect(func():
			AnimEng.animate_button_click(btn_upgrade)
			AudioManager.play_sfx("ui_click")
			var cost_gold := 2
			if GameManager.spend_currency(Constants.Currency.GOLD, cost_gold):
				var cap: int = GameManager.game_data.get("inventory_capacity", 68)
				GameManager.game_data["inventory_capacity"] = cap + 1
				populate_inventory()
				ToastMgr.show_toast("📦 Mở rộng kho thành công! (+1 ô)", Color(0.2, 0.9, 0.5))
			else:
				ToastMgr.show_toast("❌ Không đủ Vàng!", Color(0.9, 0.3, 0.3))
		)

func populate_inventory() -> void:
	if not item_grid: return
	for child in item_grid.get_children():
		child.queue_free()
		
	var inv: Array = GameManager.get_inventory()
	var cap: int = GameManager.game_data.get("inventory_capacity", 68)
	if lbl_capacity:
		lbl_capacity.text = "Stored items: " + str(inv.size()) + "/" + str(cap)
		
	for item in inv:
		var slot_panel := PanelContainer.new()
		slot_panel.custom_minimum_size = Vector2(58, 58)
		slot_panel.mouse_filter = Control.MOUSE_FILTER_STOP
		
		var slot_box := Control.new()
		slot_box.custom_minimum_size = Vector2(58, 58)
		slot_panel.add_child(slot_box)
		
		var spr := TextureRect.new()
		spr.custom_minimum_size = Vector2(44, 44)
		spr.position = Vector2(7, 7)
		spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		
		var itype: int = item.get("type", Constants.ItemType.WEAPON)
		spr.texture = MasterPixel.get_item_texture(itype)
		slot_box.add_child(spr)
		
		var count: int = item.get("count", item.get("upgrade_level", 1))
		if count > 0:
			var count_lbl := Label.new()
			count_lbl.text = str(count)
			count_lbl.add_theme_font_size_override("font_size", 9)
			count_lbl.add_theme_color_override("font_color", Color(0.9, 0.9, 0.9))
			count_lbl.position = Vector2(36, 38)
			slot_box.add_child(count_lbl)
			
		var cur_item: Dictionary = item
		slot_panel.gui_input.connect(func(ev):
			if ev is InputEventMouseButton and ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
				AnimEng.animate_button_click(slot_panel)
				AudioManager.play_sfx("ui_click")
				ToastMgr.show_toast("🔍 " + cur_item.get("name", "Vật phẩm"), Color(0.3, 0.7, 1.0))
		)
		item_grid.add_child(slot_panel)
