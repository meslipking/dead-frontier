# ═══════════════════════════════════════════════════════════════
#  MARKET ROOM CONTROLLER (market_room.gd) — Trading Post Modal
#  Giao Thương Bán Phế Liệu Niken, Thỏi Thép & Đá Ngọc Lấy Vàng (Image 1 Match)
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var items_container: VBoxContainer
@export var lbl_gold: Label
@export var btn_close: Button

var market_goods := [
	{ "name": "Niken Alloy (Phế Liệu Niken)", "price": 100, "count": 10, "icon": "Plasma Rifle" },
	{ "name": "Energy Battery (Pin Năng Lượng)", "price": 250, "count": 5, "icon": "Cyber Visor" },
	{ "name": "Ruby Ore (Quặng Ruby Đỏ)", "price": 500, "count": 2, "icon": "Titan Exo" }
]

func _ready() -> void:
	_update_display()
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)

func _update_display() -> void:
	if lbl_gold: lbl_gold.text = "🟡 " + str(GameManager.get_currency(Constants.Currency.GOLD))
	if not items_container: return
	
	for child in items_container.get_children():
		child.queue_free()
		
	for good in market_goods:
		var panel := PanelContainer.new()
		panel.custom_minimum_size = Vector2(0, 56)
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 8)
		margin.add_theme_constant_override("margin_top", 4)
		margin.add_theme_constant_override("margin_right", 8)
		margin.add_theme_constant_override("margin_bottom", 4)
		panel.add_child(margin)
		
		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 10)
		margin.add_child(hbox)
		
		var icon_rect := TextureRect.new()
		icon_rect.custom_minimum_size = Vector2(44, 44)
		icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon_rect.texture = MasterPixel.get_modern_gear_texture(str(good["icon"]))
		hbox.add_child(icon_rect)
		
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_child(vbox)
		
		var name_lbl := Label.new()
		name_lbl.text = str(good["name"])
		name_lbl.add_theme_font_size_override("font_size", 13)
		name_lbl.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
		vbox.add_child(name_lbl)
		
		var price_lbl := Label.new()
		price_lbl.text = "GIÁ BÁN: " + str(good["price"]) + "🟡 (CÒN " + str(good["count"]) + ")"
		price_lbl.add_theme_font_size_override("font_size", 10)
		price_lbl.add_theme_color_override("font_color", Color(0.95, 0.8, 0.25))
		vbox.add_child(price_lbl)
		
		var btn_sell := Button.new()
		btn_sell.custom_minimum_size = Vector2(80, 32)
		btn_sell.text = "BÁN NGAY"
		btn_sell.add_theme_font_size_override("font_size", 10)
		var cur_good: Dictionary = good
		btn_sell.pressed.connect(func():
			AnimEng.animate_button_click(btn_sell)
			AudioManager.play_sfx("ui_click")
			GameManager.add_currency(Constants.Currency.GOLD, int(cur_good["price"]))
			ToastMgr.show_toast("💰 Đã bán " + str(cur_good["name"]) + " nhận +" + str(cur_good["price"]) + " Vàng!", Color(0.95, 0.8, 0.25))
			_update_display()
		)
		hbox.add_child(btn_sell)
		
		items_container.add_child(panel)
