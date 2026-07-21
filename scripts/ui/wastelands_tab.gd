# ═══════════════════════════════════════════════════════════════
#  WASTELANDS TAB CONTROLLER (wastelands_tab.gd) — Reference Image 1 Match
#  Hiển thị Thẻ Vùng Hoang Dungeons với Bìa Pixel Art Ngang & Active Looting
# ═══════════════════════════════════════════════════════════════
extends Control

const PixelGen = preload("res://scripts/utils/pixel_art_generator.gd")
const CBridge = preload("res://scripts/utils/c_pixel_engine_bridge.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

@export var list_container: VBoxContainer

func _ready() -> void:
	populate_dungeons()

func populate_dungeons() -> void:
	if not list_container: return
	for child in list_container.get_children():
		child.queue_free()
		
	# 1. Active Dungeon Card (Obsidian Mines - Matching Reference Image 1)
	var active_card := PanelContainer.new()
	active_card.custom_minimum_size = Vector2(0, 150)
	active_card.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var active_margin := MarginContainer.new()
	active_margin.add_theme_constant_override("margin_left", 12)
	active_margin.add_theme_constant_override("margin_top", 10)
	active_margin.add_theme_constant_override("margin_right", 12)
	active_margin.add_theme_constant_override("margin_bottom", 10)
	active_card.add_child(active_margin)
	
	var active_vbox := VBoxContainer.new()
	active_vbox.add_theme_constant_override("separation", 6)
	active_margin.add_child(active_vbox)
	
	var active_title := Label.new()
	active_title.text = "Obsidian Mines"
	active_title.add_theme_font_size_override("font_size", 16)
	active_title.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
	active_vbox.add_child(active_title)
	
	# 4 Active Adventurer Avatars
	var party_hbox := HBoxContainer.new()
	party_hbox.add_theme_constant_override("separation", 8)
	active_vbox.add_child(party_hbox)
	
	for i in range(4):
		var adv_box := VBoxContainer.new()
		var spr := TextureRect.new()
		spr.custom_minimum_size = Vector2(36, 36)
		spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		spr.texture = CBridge.render_c_survivor_texture(Color(0.3 + i * 0.15, 0.4, 0.6), 48, 48)
		adv_box.add_child(spr)
		
		# HP bar under avatar
		var hp := ProgressBar.new()
		hp.custom_minimum_size = Vector2(36, 4)
		hp.show_percentage = false
		hp.value = 85.0 - i * 10
		adv_box.add_child(hp)
		party_hbox.add_child(adv_box)
		
	# Looting progress text & bar
	var loot_lbl := Label.new()
	loot_lbl.text = "Looting items..."
	loot_lbl.add_theme_font_size_override("font_size", 10)
	loot_lbl.add_theme_color_override("font_color", Color(0.7, 0.75, 0.8))
	active_vbox.add_child(loot_lbl)
	
	var loot_bar := ProgressBar.new()
	loot_bar.custom_minimum_size = Vector2(160, 6)
	loot_bar.show_percentage = false
	loot_bar.value = 65.0
	active_vbox.add_child(loot_bar)
	
	list_container.add_child(active_card)
	
	# 2. Inactive Dungeon Banners (The Southern Grove & Barren Wastelands)
	var dungeons := [
		{ "name": "The Southern Grove", "color": Color(0.15, 0.35, 0.2) },
		{ "name": "Barren Wastelands", "color": Color(0.4, 0.25, 0.15) }
	]
	
	for d in dungeons:
		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(0, 110)
		card.mouse_filter = Control.MOUSE_FILTER_STOP
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 12)
		margin.add_theme_constant_override("margin_top", 10)
		margin.add_theme_constant_override("margin_right", 12)
		margin.add_theme_constant_override("margin_bottom", 10)
		card.add_child(margin)
		
		var title := Label.new()
		title.text = d["name"]
		title.add_theme_font_size_override("font_size", 16)
		title.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
		margin.add_child(title)
		
		list_container.add_child(card)
