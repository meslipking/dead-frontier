# ═══════════════════════════════════════════════════════════════
#  WASTELANDS TAB CONTROLLER (wastelands_tab.gd)
#  Hiển thị Danh Sách Dungeons với Bìa Phong Cảnh Pixel Art 16-Bit Tuyệt Đẹp
# ═══════════════════════════════════════════════════════════════
extends Control

const BannerGen = preload("res://scripts/utils/pixel_art/landscape_banner_generator.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

@export var list_container: VBoxContainer

func _ready() -> void:
	populate_dungeons()

func populate_dungeons() -> void:
	if not list_container: return
	for child in list_container.get_children():
		child.queue_free()
		
	var zones := [
		{ "name": "Obsidian Mines", "desc": "Looting items...", "progress": 0.42 },
		{ "name": "The Southern Grove", "desc": "Explore Zone 2", "progress": 0.0 },
		{ "name": "Barren Wastelands", "desc": "Explore Zone 3", "progress": 0.0 }
	]
	
	for zone in zones:
		var panel := PanelContainer.new()
		panel.custom_minimum_size = Vector2(0, 110)
		panel.mouse_filter = Control.MOUSE_FILTER_STOP
		
		var banner_tex := BannerGen.create_landscape_banner(zone["name"], 320, 110)
		var bg_img := TextureRect.new()
		bg_img.texture = banner_tex
		bg_img.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		bg_img.stretch_mode = TextureRect.STRETCH_SCALE
		panel.add_child(bg_img)
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 12)
		margin.add_theme_constant_override("margin_top", 10)
		margin.add_theme_constant_override("margin_right", 12)
		margin.add_theme_constant_override("margin_bottom", 10)
		panel.add_child(margin)
		
		var vbox := VBoxContainer.new()
		margin.add_child(vbox)
		
		var title_lbl := Label.new()
		title_lbl.text = zone["name"]
		title_lbl.add_theme_font_size_override("font_size", 16)
		title_lbl.add_theme_color_override("font_color", Color(0.98, 0.98, 0.98))
		vbox.add_child(title_lbl)
		
		var desc_lbl := Label.new()
		desc_lbl.text = zone["desc"]
		desc_lbl.add_theme_font_size_override("font_size", 11)
		desc_lbl.add_theme_color_override("font_color", Color(0.85, 0.75, 0.35))
		vbox.add_child(desc_lbl)
		
		var prog: float = zone["progress"]
		if prog > 0.0:
			var pbar := ProgressBar.new()
			pbar.custom_minimum_size = Vector2(0, 10)
			pbar.value = prog * 100.0
			pbar.show_percentage = false
			vbox.add_child(pbar)
			
		list_container.add_child(panel)
