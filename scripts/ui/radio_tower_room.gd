# ═══════════════════════════════════════════════════════════════
#  RADIO TOWER ROOM CONTROLLER (radio_tower_room.gd) — Tavern Recruit Modal
#  Chiêu mộ Anh Hùng Tân Binh tại Quán Rượu Tavern (Matching Reference Image 4)
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var guest_container: VBoxContainer
@export var btn_refresh: Button
@export var btn_close: Button

var available_guests := [
	{ "name": "Viper Sentry", "class": "Nimble, Nocturnal", "cost": 150, "lvl": 19 },
	{ "name": "Titan Colossus", "class": "Brute, Heavy", "cost": 250, "lvl": 24 },
	{ "name": "Dragon Archer", "class": "Feral, Dragon Blood", "cost": 200, "lvl": 22 }
]

func _ready() -> void:
	_populate_guests()
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)
		
	if btn_refresh:
		btn_refresh.pressed.connect(func():
			AnimEng.animate_button_click(btn_refresh)
			AudioManager.play_sfx("ui_click")
			if GameManager.spend_currency(Constants.Currency.GOLD, 50):
				_populate_guests()
				ToastMgr.show_toast("🍺 Đã làm mới danh sách Quán Rượu TAVERN!", Color(0.95, 0.8, 0.25))
			else:
				ToastMgr.show_toast("❌ Không đủ Vàng!", Color(0.9, 0.3, 0.3))
		)

func _populate_guests() -> void:
	if not guest_container: return
	for child in guest_container.get_children():
		child.queue_free()
		
	for guest in available_guests:
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
		icon_rect.texture = MasterPixel.get_adventurer_texture(guest["name"])
		hbox.add_child(icon_rect)
		
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_child(vbox)
		
		var name_lbl := Label.new()
		name_lbl.text = guest["name"] + " (Lv." + str(guest["lvl"]) + ")"
		name_lbl.add_theme_font_size_override("font_size", 13)
		name_lbl.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
		vbox.add_child(name_lbl)
		
		var class_lbl := Label.new()
		class_lbl.text = guest["class"]
		class_lbl.add_theme_font_size_override("font_size", 10)
		class_lbl.add_theme_color_override("font_color", Color(0.85, 0.55, 0.25))
		vbox.add_child(class_lbl)
		
		var btn_hire := Button.new()
		btn_hire.custom_minimum_size = Vector2(90, 32)
		btn_hire.text = "CHIÊU MỘ (" + str(guest["cost"]) + "🟡)"
		btn_hire.add_theme_font_size_override("font_size", 10)
		var cur_guest: Dictionary = guest
		btn_hire.pressed.connect(func():
			AnimEng.animate_button_click(btn_hire)
			AudioManager.play_sfx("ui_click")
			if GameManager.spend_currency(Constants.Currency.GOLD, cur_guest["cost"]):
				ToastMgr.show_toast("🍻 Đã chiêu mộ " + cur_guest["name"] + " vào Đội!", Color(0.3, 0.9, 0.5))
				btn_hire.disabled = true
				btn_hire.text = "ĐÃ THU THẬP"
			else:
				ToastMgr.show_toast("❌ Không đủ Vàng!", Color(0.9, 0.3, 0.3))
		)
		hbox.add_child(btn_hire)
		
		guest_container.add_child(panel)
