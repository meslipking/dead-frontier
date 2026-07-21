# ═══════════════════════════════════════════════════════════════
#  RADIO TOWER ROOM CONTROLLER (radio_tower_room.gd) — Tavern Recruit Modal
#  Chiêu Mộ Anh Hùng Tân Binh Sinh Ngẫu Nhiên 100% 5 Phẩm Cấp
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")
const TavernEngine = preload("res://scripts/systems/procedural_tavern_engine.gd")

@export var guest_container: VBoxContainer
@export var btn_refresh: Button
@export var btn_close: Button

var current_guests: Array = []

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
				ToastMgr.show_toast("🍺 Đã làm mới dàn Anh Hùng Tân Binh mới!", Color(0.95, 0.8, 0.25))
			else:
				ToastMgr.show_toast("❌ Không đủ Vàng!", Color(0.9, 0.3, 0.3))
		)

func _populate_guests() -> void:
	if not guest_container: return
	for child in guest_container.get_children():
		child.queue_free()
		
	current_guests = TavernEngine.generate_guest_recruits(3)
	
	for guest in current_guests:
		var panel := PanelContainer.new()
		panel.custom_minimum_size = Vector2(0, 60)
		
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
		icon_rect.texture = MasterPixel.get_adventurer_texture("Iron Defender")
		hbox.add_child(icon_rect)
		
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_child(vbox)
		
		var name_lbl := Label.new()
		name_lbl.text = guest["name"] + " (Lv." + str(guest["level"]) + ")"
		name_lbl.add_theme_font_size_override("font_size", 13)
		name_lbl.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
		vbox.add_child(name_lbl)
		
		var rarity_lbl := Label.new()
		rarity_lbl.text = "PHẨM: " + str(guest["rarity_tier"])
		rarity_lbl.add_theme_font_size_override("font_size", 10)
		rarity_lbl.add_theme_color_override("font_color", guest["rarity_color"])
		vbox.add_child(rarity_lbl)
		
		var btn_hire := Button.new()
		btn_hire.custom_minimum_size = Vector2(95, 32)
		btn_hire.text = "CHIÊU MỘ (" + str(guest["cost"]) + "🟡)"
		btn_hire.add_theme_font_size_override("font_size", 10)
		var cur_guest: Dictionary = guest
		btn_hire.pressed.connect(func():
			AnimEng.animate_button_click(btn_hire)
			AudioManager.play_sfx("ui_click")
			if GameManager.spend_currency(Constants.Currency.GOLD, int(cur_guest["cost"])):
				ToastMgr.show_toast("🍻 Đã chiêu mộ " + cur_guest["name"] + "!", Color(0.3, 0.9, 0.5))
				btn_hire.disabled = true
				btn_hire.text = "ĐÃ THU THẬP"
			else:
				ToastMgr.show_toast("❌ Không đủ Vàng!", Color(0.9, 0.3, 0.3))
		)
		hbox.add_child(btn_hire)
		
		guest_container.add_child(panel)
