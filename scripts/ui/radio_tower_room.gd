# ═══════════════════════════════════════════════════════════════
#  TAVERN MODAL CONTROLLER (radio_tower_room.gd) — Reference Image 3 Match
#  Quản lý 3 Khách tuyển mộ tại Quán Rượu Tavern
# ═══════════════════════════════════════════════════════════════
extends Control

const SurvDb = preload("res://scripts/data/survivor_database.gd")
const CBridge = preload("res://scripts/utils/c_pixel_engine_bridge.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var lbl_capacity: Label
@export var guests_list: VBoxContainer
@export var btn_refresh: Button
@export var btn_close: Button

var available_guests: Array = []

func _ready() -> void:
	_generate_guests()
	populate_guests()
	
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
			if GameManager.spend_currency(Constants.Currency.GOLD, 1):
				_generate_guests()
				populate_guests()
				ToastMgr.show_toast("🍺 Làm mới danh sách khách!", Color(0.9, 0.8, 0.2))
			else:
				ToastMgr.show_toast("❌ Không đủ Vàng!", Color(0.9, 0.3, 0.3))
		)

func _generate_guests() -> void:
	available_guests.clear()
	for i in range(3):
		available_guests.append(SurvDb.generate_random_survivor())

func populate_guests() -> void:
	if not guests_list: return
	for child in guests_list.get_children():
		child.queue_free()
		
	if lbl_capacity:
		lbl_capacity.text = str(available_guests.size()) + "/3 guests available"
		
	for idx in range(available_guests.size()):
		var guest: Dictionary = available_guests[idx]
		var panel := PanelContainer.new()
		panel.custom_minimum_size = Vector2(0, 52)
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 8)
		margin.add_theme_constant_override("margin_top", 6)
		margin.add_theme_constant_override("margin_right", 8)
		margin.add_theme_constant_override("margin_bottom", 6)
		panel.add_child(margin)
		
		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 10)
		margin.add_child(hbox)
		
		# Avatar Pixel Icon
		var spr := TextureRect.new()
		spr.custom_minimum_size = Vector2(38, 38)
		spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		spr.texture = CBridge.render_c_survivor_texture(Color(0.4, 0.3 + idx * 0.2, 0.6), 48, 48)
		hbox.add_child(spr)
		
		# Info VBox
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_child(vbox)
		
		var name_lbl := Label.new()
		name_lbl.text = str(guest.get("name", "Guest"))
		name_lbl.add_theme_font_size_override("font_size", 13)
		vbox.add_child(name_lbl)
		
		var trait_lbl := Label.new()
		trait_lbl.text = str(guest.get("traits", "Brute"))
		trait_lbl.add_theme_color_override("font_color", Color(0.85, 0.55, 0.25))
		trait_lbl.add_theme_font_size_override("font_size", 10)
		vbox.add_child(trait_lbl)
		
		# Hire Button
		var btn_hire := Button.new()
		btn_hire.custom_minimum_size = Vector2(70, 28)
		btn_hire.text = "HIRE (🟡 2)"
		btn_hire.add_theme_font_size_override("font_size", 10)
		
		var g_idx := idx
		var cur_guest: Dictionary = guest
		btn_hire.pressed.connect(func():
			AnimEng.animate_button_click(btn_hire)
			AudioManager.play_sfx("ui_click")
			if GameManager.spend_currency(Constants.Currency.GOLD, 2):
				GameManager.get_survivors().append(cur_guest)
				available_guests.remove_at(g_idx)
				populate_guests()
				ToastMgr.show_toast("🎉 Chiêu mộ " + str(cur_guest.get("name", "")) + " thành công!", Color(0.2, 0.9, 0.5))
			else:
				ToastMgr.show_toast("❌ Không đủ Vàng!", Color(0.9, 0.3, 0.3))
		)
		hbox.add_child(btn_hire)
		
		guests_list.add_child(panel)
