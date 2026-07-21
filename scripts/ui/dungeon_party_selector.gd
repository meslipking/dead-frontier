# ═══════════════════════════════════════════════════════════════
#  DUNGEON PARTY SELECTOR CONTROLLER (dungeon_party_selector.gd)
#  Cửa Sổ Chọn & Sắp Xếp 4 Anh Hùng Xuất Trận Trực Tiếp Tại Tab Dungeons
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var party_container: VBoxContainer
@export var lbl_squad_cp: Label
@export var btn_confirm: Button
@export var btn_close: Button

func _ready() -> void:
	_populate_party()
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)
		
	if btn_confirm:
		btn_confirm.pressed.connect(func():
			AnimEng.animate_button_click(btn_confirm)
			AudioManager.play_sfx("ui_click")
			ToastMgr.show_toast("✅ Đã cập nhật đội hình thám hiểm ải thành công!", Color(0.3, 0.9, 0.5))
			queue_free()
		)

func _populate_party() -> void:
	if not party_container: return
	for child in party_container.get_children():
		child.queue_free()
		
	var survivors: Array = GameManager.get_survivors()
	var squad_cp: int = GameManager.calculate_squad_cp()
	
	if lbl_squad_cp:
		lbl_squad_cp.text = "⚔️ TỔNG LỰC CHIẾN (SQUAD CP): " + str(squad_cp)
		
	for i in range(min(4, survivors.size())):
		var adv: Dictionary = survivors[i]
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
		
		var spr := TextureRect.new()
		spr.custom_minimum_size = Vector2(44, 44)
		spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		spr.texture = MasterPixel.get_adventurer_texture(str(adv.get("name", "Iron Defender")))
		hbox.add_child(spr)
		
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_child(vbox)
		
		var name_lbl := Label.new()
		name_lbl.text = str(adv.get("name", "Iron Defender")) + " (Lv." + str(adv.get("level", 18)) + ")"
		name_lbl.add_theme_font_size_override("font_size", 13)
		name_lbl.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
		vbox.add_child(name_lbl)
		
		var pos_lbl := Label.new()
		pos_lbl.text = "CHỦ LỰC ĐỘI HÌNH #" + str(i + 1)
		pos_lbl.add_theme_font_size_override("font_size", 10)
		pos_lbl.add_theme_color_override("font_color", Color(0.85, 0.55, 0.25))
		vbox.add_child(pos_lbl)
		
		party_container.add_child(panel)
