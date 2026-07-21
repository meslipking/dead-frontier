# ═══════════════════════════════════════════════════════════════
#  WORKSHOP MODAL CONTROLLER (workshop_room.gd) — Reference Image 3 Match
#  Quản lý 6 Công thức chế tạo & Rèn trang bị tại WORKSHOP
# ═══════════════════════════════════════════════════════════════
extends Control

const PixelGen = preload("res://scripts/utils/pixel_art_generator.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var lbl_capacity: Label
@export var craft_list: VBoxContainer
@export var btn_close: Button

func _ready() -> void:
	populate_recipes()
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)

func populate_recipes() -> void:
	if not craft_list: return
	for child in craft_list.get_children():
		child.queue_free()
		
	var recipes := [
		{ "name": "Weapon Refining +1", "cost": "⚔️ 10 Materials", "type": Constants.ItemType.WEAPON, "color": Color(0.7, 0.3, 0.2) },
		{ "name": "Armor Forging +1", "cost": "🛡️ 12 Materials", "type": Constants.ItemType.ARMOR, "color": Color(0.3, 0.5, 0.3) },
		{ "name": "Accessory Polish +1", "cost": "💍 8 Materials", "type": Constants.ItemType.ACCESSORY, "color": Color(0.2, 0.5, 0.7) },
		{ "name": "Gem Socketing", "cost": "💎 2 Crystals", "type": Constants.ItemType.MATERIAL, "color": Color(0.8, 0.2, 0.8) },
		{ "name": "Rune Inscription", "cost": "📜 15 Materials", "type": Constants.ItemType.MATERIAL, "color": Color(0.9, 0.7, 0.2) },
		{ "name": "Alloy Melting", "cost": "⛏️ 20 Scrap", "type": Constants.ItemType.MATERIAL, "color": Color(0.5, 0.6, 0.7) },
	]
	
	for rec in recipes:
		var panel := PanelContainer.new()
		panel.custom_minimum_size = Vector2(0, 50)
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 8)
		margin.add_theme_constant_override("margin_top", 6)
		margin.add_theme_constant_override("margin_right", 8)
		margin.add_theme_constant_override("margin_bottom", 6)
		panel.add_child(margin)
		
		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 10)
		margin.add_child(hbox)
		
		var spr := TextureRect.new()
		spr.custom_minimum_size = Vector2(36, 36)
		spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		spr.texture = PixelGen.create_item_icon(rec["type"], rec["color"])
		hbox.add_child(spr)
		
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_child(vbox)
		
		var name_lbl := Label.new()
		name_lbl.text = rec["name"]
		name_lbl.add_theme_font_size_override("font_size", 13)
		vbox.add_child(name_lbl)
		
		var cost_lbl := Label.new()
		cost_lbl.text = rec["cost"]
		cost_lbl.add_theme_color_override("font_color", Color(0.7, 0.75, 0.8))
		cost_lbl.add_theme_font_size_override("font_size", 10)
		vbox.add_child(cost_lbl)
		
		var btn_craft := Button.new()
		btn_craft.custom_minimum_size = Vector2(65, 28)
		btn_craft.text = "CRAFT"
		btn_craft.add_theme_font_size_override("font_size", 10)
		
		var cur_rec: Dictionary = rec
		btn_craft.pressed.connect(func():
			AnimEng.animate_button_click(btn_craft)
			AudioManager.play_sfx("ui_click")
			ToastMgr.show_toast("🔨 Bắt đầu chế tạo: " + cur_rec["name"], Color(0.9, 0.8, 0.2))
		)
		hbox.add_child(btn_craft)
		
		craft_list.add_child(panel)
