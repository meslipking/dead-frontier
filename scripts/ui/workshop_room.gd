# ═══════════════════════════════════════════════════════════════
#  WORKSHOP MODAL CONTROLLER (workshop_room.gd) — Image 5 & 11 Match
#  Quản lý 6 Công thức chế tạo & Rèn trang bị tại WORKSHOP
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var lbl_capacity: Label
@export var craft_list: VBoxContainer
@export var btn_close: Button

func _ready() -> void:
	populate_recipes()
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)

func populate_recipes() -> void:
	if not craft_list: return
	for child in craft_list.get_children():
		child.queue_free()
		
	var recipes := [
		{ "name": "Weapon Refining +1 (Súng Plasma)", "cost": "⚔️ 10 Phế liệu Niken", "icon": "Plasma Rifle" },
		{ "name": "Armor Forging +1 (Giáp Titan Exo)", "cost": "🛡️ 12 Phế liệu Niken", "icon": "Titan Exo" },
		{ "name": "Accessory Polish +1 (Kính Cyber HUD)", "cost": "💍 8 Phế liệu Niken", "icon": "Cyber Visor" },
		{ "name": "Gem Socketing (Khảm Ngọc Thuộc Tính)", "cost": "💎 2 Crystals", "icon": "Cyber Visor" },
		{ "name": "Rune Inscription (Phù Phép Cổ)", "cost": "📜 15 Phế liệu Niken", "icon": "Plasma Rifle" },
		{ "name": "Elixir Potion Brewing (Chế Thuốc Tăng Chỉ Số)", "cost": "🧪 20 Quặng Niken", "icon": "Titan Exo" },
	]
	
	for rec in recipes:
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
		
		var spr := TextureRect.new()
		spr.custom_minimum_size = Vector2(38, 38)
		spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		spr.texture = MasterPixel.get_modern_gear_texture(str(rec["icon"]))
		hbox.add_child(spr)
		
		var vbox := VBoxContainer.new()
		vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_child(vbox)
		
		var name_lbl := Label.new()
		name_lbl.text = rec["name"]
		name_lbl.add_theme_font_size_override("font_size", 12)
		name_lbl.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
		vbox.add_child(name_lbl)
		
		var cost_lbl := Label.new()
		cost_lbl.text = rec["cost"]
		cost_lbl.add_theme_color_override("font_color", Color(0.85, 0.55, 0.25))
		cost_lbl.add_theme_font_size_override("font_size", 10)
		vbox.add_child(cost_lbl)
		
		var btn_craft := Button.new()
		btn_craft.custom_minimum_size = Vector2(65, 28)
		btn_craft.text = "CHẾ TẠO"
		btn_craft.add_theme_font_size_override("font_size", 10)
		
		var cur_rec: Dictionary = rec
		btn_craft.pressed.connect(func():
			AnimEng.animate_button_click(btn_craft)
			AudioManager.play_sfx("ui_click")
			ToastMgr.show_toast("🔨 Chế tạo thành công: " + cur_rec["name"], Color(0.9, 0.8, 0.2))
		)
		hbox.add_child(btn_craft)
		
		craft_list.add_child(panel)
