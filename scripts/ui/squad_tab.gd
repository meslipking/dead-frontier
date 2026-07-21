# ═══════════════════════════════════════════════════════════════
#  SQUAD TAB CONTROLLER (squad_tab.gd) — Reference Image 5 Grade
#  Hiển thị danh sách Adventurers với 16-Bit Pixel Art Ma Trận Chấn Động 100% Sharp
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

@export var list_container: VBoxContainer

func _ready() -> void:
	populate_adventurers()
	EventBus.tab_changed.connect(func(idx): if idx == 1: populate_adventurers())

func populate_adventurers() -> void:
	if not list_container: return
	for child in list_container.get_children():
		child.queue_free()
		
	var survivors: Array = GameManager.get_survivors()
	
	for adv in survivors:
		var panel := PanelContainer.new()
		panel.custom_minimum_size = Vector2(0, 68)
		panel.mouse_filter = Control.MOUSE_FILTER_STOP
		panel.gui_input.connect(func(ev):
			if ev is InputEventMouseButton and ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
				AnimEng.animate_button_click(panel)
				AudioManager.play_sfx("ui_click")
		)
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 8)
		margin.add_theme_constant_override("margin_top", 6)
		margin.add_theme_constant_override("margin_right", 8)
		margin.add_theme_constant_override("margin_bottom", 6)
		panel.add_child(margin)
		
		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 12)
		margin.add_child(hbox)
		
		# Left: Character 16-Bit Handcrafted Pixel Avatar Container with Level Badge
		var avatar_box := Control.new()
		avatar_box.custom_minimum_size = Vector2(52, 52)
		hbox.add_child(avatar_box)
		
		var spr := TextureRect.new()
		spr.custom_minimum_size = Vector2(52, 52)
		spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		
		var cname: String = str(adv.get("name", "Iron Defender"))
		spr.texture = MasterPixel.get_adventurer_texture(cname)
		avatar_box.add_child(spr)
		
		# Level Badge Overlay (bottom right of avatar)
		var lvl_lbl := Label.new()
		lvl_lbl.text = str(adv.get("level", 18))
		lvl_lbl.add_theme_font_size_override("font_size", 10)
		lvl_lbl.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
		lvl_lbl.position = Vector2(34, 34)
		avatar_box.add_child(lvl_lbl)
		
		# Middle: Name & Orange Traits
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_child(vbox)
		
		var name_lbl := Label.new()
		name_lbl.text = cname
		name_lbl.add_theme_font_size_override("font_size", 14)
		name_lbl.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
		vbox.add_child(name_lbl)
		
		var trait_lbl := Label.new()
		trait_lbl.text = str(adv.get("traits", "Brute, Nimble"))
		trait_lbl.add_theme_color_override("font_color", Color(0.85, 0.55, 0.25))
		trait_lbl.add_theme_font_size_override("font_size", 10)
		vbox.add_child(trait_lbl)
		
		# Right: 3 Equipment item slot boxes (Weapon, Armor, Accessory)
		for slot_type in [Constants.ItemType.WEAPON, Constants.ItemType.ARMOR, Constants.ItemType.ACCESSORY]:
			var slot_panel := PanelContainer.new()
			slot_panel.custom_minimum_size = Vector2(40, 40)
			
			var slot_icon := TextureRect.new()
			slot_icon.custom_minimum_size = Vector2(36, 36)
			slot_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			slot_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			slot_icon.texture = MasterPixel.get_item_texture(slot_type)
			
			slot_panel.add_child(slot_icon)
			hbox.add_child(slot_panel)
			
		list_container.add_child(panel)
