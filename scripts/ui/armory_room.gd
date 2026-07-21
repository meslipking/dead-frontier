# ═══════════════════════════════════════════════════════════════
#  ARMORY ROOM CONTROLLER (armory_room.gd) — FlipFight Blacksmith
#  Lưới Trang bị 4x4, Cường hóa +1..+10 & Tháo rỡ phế liệu
# ═══════════════════════════════════════════════════════════════
extends Control

const PixelGen = preload("res://scripts/utils/pixel_art_generator.gd")
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
			if not selected_item.is_empty():
				var res := EquipForge.upgrade_equipment(selected_item)
				if res.get("success", false):
					ToastMgr.show_toast("🔨 Cường hóa thành công + " + str(res["new_level"]) + "!", Color(0.2, 0.9, 0.5))
				else:
					ToastMgr.show_toast("❌ " + res.get("reason", "Cường hóa thất bại!"), Color(0.9, 0.3, 0.3))
				populate_inventory()
			else:
				ToastMgr.show_toast("⚠️ Hãy chọn 1 trang bị để cường hóa!", Color(0.9, 0.8, 0.2))
		)

func populate_inventory() -> void:
	if not item_grid: return
	for child in item_grid.get_children():
		child.queue_free()
		
	var inv: Array = GameManager.get_inventory()
	var cap: int = GameManager.game_data.get("inventory_capacity", 40)
	if lbl_capacity:
		lbl_capacity.text = "Sức chứa kho: " + str(inv.size()) + " / " + str(cap)
		
	for item in inv:
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(54, 54)
		var lvl: int = item.get("upgrade_level", 0)
		btn.text = item.get("name", "Vật phẩm") + ("\n+" + str(lvl) if lvl > 0 else "")
		
		var itype: int = item.get("type", Constants.ItemType.WEAPON)
		var rcolor := Color(0.7, 0.7, 0.7)
		var tex := PixelGen.create_item_icon(itype, rcolor)
		btn.icon = tex
		btn.expand_icon = true
		
		var cur_item: Dictionary = item
		btn.pressed.connect(func():
			AnimEng.animate_button_click(btn)
			AudioManager.play_sfx("ui_click")
			selected_item = cur_item
			ToastMgr.show_toast("🔍 Đã chọn: " + cur_item.get("name", ""), Color(0.3, 0.7, 1.0))
		)
		item_grid.add_child(btn)
