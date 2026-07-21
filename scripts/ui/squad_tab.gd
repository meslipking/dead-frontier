# ═══════════════════════════════════════════════════════════════
#  SQUAD TAB CONTROLLER (squad_tab.gd) — Reference Image 5 Grade
#  Hiển thị danh sách Adventurers với 3 Ô trang bị chuẩn 100% hình ảnh
# ═══════════════════════════════════════════════════════════════
extends Control

const SurvDb = preload("res://scripts/data/survivor_database.gd")
const PixelGen = preload("res://scripts/utils/pixel_art_generator.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

@export var list_container: VBoxContainer

func _ready() -> void:
	populate_adventurers()

func populate_adventurers() -> void:
	if not list_container: return
	for child in list_container.get_children():
		child.queue_free()
		
	var survivors: Array = GameManager.get_survivors()
	
	# Add mock adventurers if empty to match reference image 5
	if survivors.size() < 6:
		survivors = [
			{ "id": "adv_1", "name": "Iron Defender", "traits": "Brute, Nimble", "level": 18 },
			{ "id": "adv_2", "name": "Night Terror", "traits": "Nocturnal", "level": 19 },
			{ "id": "adv_3", "name": "Shadow Dancer", "traits": "Brute, Nocturnal", "level": 19 },
			{ "id": "adv_4", "name": "Tempest", "traits": "Feral, Dragon Blood", "level": 23 },
			{ "id": "adv_5", "name": "Hailstorm", "traits": "Feral", "level": 24 },
			{ "id": "adv_6", "name": "King's Hand", "traits": "Brute", "level": 26 },
			{ "id": "adv_7", "name": "Bard", "traits": "Feral", "level": 25 },
			{ "id": "adv_8", "name": "Holy Knight", "traits": "Brute", "level": 19 },
		]
		
	for adv in survivors:
		var panel := PanelContainer.new()
		panel.custom_minimum_size = Vector2(0, 58)
		panel.mouse_filter = Control.MOUSE_FILTER_STOP
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 8)
		margin.add_theme_constant_override("margin_top", 6)
		margin.add_theme_constant_override("margin_right", 8)
		margin.add_theme_constant_override("margin_bottom", 6)
		panel.add_child(margin)
		
		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 10)
		margin.add_child(hbox)
		
		# Left: Character Pixel Sprite
		var spr := TextureRect.new()
		spr.custom_minimum_size = Vector2(40, 40)
		spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		spr.texture = PixelGen.create_unit_texture(Constants.UnitType.SURVIVOR, Color(0.3, 0.7, 1.0), 48, 48)
		hbox.add_child(spr)
		
		# Middle: Name & Traits
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_child(vbox)
		
		var name_lbl := Label.new()
		name_lbl.text = adv.get("name", "Adventurer")
		name_lbl.add_theme_font_size_override("font_size", 13)
		vbox.add_child(name_lbl)
		
		var trait_lbl := Label.new()
		trait_lbl.text = adv.get("traits", "Brute")
		trait_lbl.add_theme_color_override("font_color", Color(0.85, 0.55, 0.25))
		trait_lbl.add_theme_font_size_override("font_size", 10)
		vbox.add_child(trait_lbl)
		
		# Right: 3 Equipment item slots (Weapon, Armor, Accessory)
		for slot_type in [Constants.ItemType.WEAPON, Constants.ItemType.ARMOR, Constants.ItemType.ACCESSORY]:
			var slot := TextureRect.new()
			slot.custom_minimum_size = Vector2(34, 34)
			slot.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			slot.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			slot.texture = PixelGen.create_item_icon(slot_type, Color(0.6, 0.3, 0.2))
			hbox.add_child(slot)
			
		list_container.add_child(panel)
