# ═══════════════════════════════════════════════════════════════
#  SIEGES TAB CONTROLLER (sieges_tab.gd) — Reference Image 4 Match
#  Hiển thị Thẻ Raids Boss Phụ Bản & Thanh Đếm Giờ Reset 23h 21m
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
		{ "name": "Ancient Grave Digging", "color": Color(0.2, 0.25, 0.35) },
		{ "name": "The Cultist Rebels", "color": Color(0.25, 0.35, 0.3) },
		{ "name": "The Lost Expedition", "color": Color(0.35, 0.3, 0.25) }
	]
	
	for r in raids:
		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(0, 110)
		card.mouse_filter = Control.MOUSE_FILTER_STOP
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
