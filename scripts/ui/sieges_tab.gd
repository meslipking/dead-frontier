# ═══════════════════════════════════════════════════════════════
#  SIEGES TAB CONTROLLER (sieges_tab.gd) — Reference Image 4 Match
#  Hiển thị Thẻ Raids Boss Phụ Bản với Bìa Pixel Art Ngang & Timer 23h 21m
# ═══════════════════════════════════════════════════════════════
extends Control

const PixelGen = preload("res://scripts/utils/pixel_art_generator.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var list_container: VBoxContainer

func _ready() -> void:
	populate_raids()

func populate_raids() -> void:
	if not list_container: return
	for child in list_container.get_children():
		child.queue_free()
		
	var raids := [
		{ "name": "Ancient Grave Digging" },
		{ "name": "The Cultist Rebels" },
		{ "name": "The Lost Expedition" }
	]
	
	for r in raids:
		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(0, 110)
		card.mouse_filter = Control.MOUSE_FILTER_STOP
		
		# Pixel Banner Background Header
		var card_bg := TextureRect.new()
		card_bg.texture = PixelGen.create_landscape_banner(r["name"], 320, 110)
		card_bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		card_bg.stretch_mode = TextureRect.STRETCH_SCALE
		card_bg.modulate = Color(0.65, 0.65, 0.7)
		card.add_child(card_bg)
		
		card.gui_input.connect(func(ev):
			if ev is InputEventMouseButton and ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
				AnimEng.animate_button_click(card)
				AudioManager.play_sfx("ui_click")
				ToastMgr.show_toast("⚔️ Khiêu chiến: " + r["name"], Color(0.9, 0.8, 0.2))
		)
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 12)
		margin.add_theme_constant_override("margin_top", 10)
		margin.add_theme_constant_override("margin_right", 12)
		margin.add_theme_constant_override("margin_bottom", 10)
		card.add_child(margin)
		
		var title := Label.new()
		title.text = r["name"]
		title.add_theme_font_size_override("font_size", 16)
		title.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
		margin.add_child(title)
		
		list_container.add_child(card)
