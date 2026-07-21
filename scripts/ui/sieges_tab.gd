# ═══════════════════════════════════════════════════════════════
#  SIEGES TAB CONTROLLER (sieges_tab.gd)
#  Hiển thị Phụ Bản Raids Boss với Bìa Phong Cảnh Pixel Art 16-Bit & SỰ KIỆN CLICK SẮC NÉT
# ═══════════════════════════════════════════════════════════════
extends Control

const BannerGen = preload("res://scripts/utils/pixel_art/landscape_banner_generator.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const WorldBossRaidScene = preload("res://scenes/outpost/WorldBossRaid.tscn")

@export var list_container: VBoxContainer

func _ready() -> void:
	_resolve_container()
	populate_raids()
	EventBus.tab_changed.connect(func(idx):
		if idx == 3:
			_resolve_container()
			populate_raids()
	)

func _resolve_container() -> void:
	if not list_container:
		list_container = find_child("ListContainer", true, false) as VBoxContainer
	if not list_container:
		list_container = find_child("VBoxContainer", true, false) as VBoxContainer

func populate_raids() -> void:
	_resolve_container()
	if not list_container: return
	for child in list_container.get_children():
		child.queue_free()
		
	var raids := [
		{ "name": "Ancient Grave Digging", "desc": "Defeat Undead Boss" },
		{ "name": "The Cultist Rebels", "desc": "Infiltrate Rebel Base" },
		{ "name": "The Lost Expedition", "desc": "Survive Blizzard Siege" }
	]
	
	for raid in raids:
		var panel := PanelContainer.new()
		panel.custom_minimum_size = Vector2(0, 110)
		panel.mouse_filter = Control.MOUSE_FILTER_STOP
		
		# Connect mouse click event listener to open WorldBossRaidScene!
		var cur_raid: Dictionary = raid
		panel.gui_input.connect(func(ev):
			if ev is InputEventMouseButton and ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
				AnimEng.animate_button_click(panel)
				AudioManager.play_sfx("ui_click")
				var modal = WorldBossRaidScene.instantiate()
				get_tree().root.add_child(modal)
		)
		
		var banner_tex := BannerGen.create_landscape_banner(raid["name"], 320, 110)
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
		title_lbl.text = raid["name"]
		title_lbl.add_theme_font_size_override("font_size", 16)
		title_lbl.add_theme_color_override("font_color", Color(0.98, 0.98, 0.98))
		vbox.add_child(title_lbl)
		
		var desc_lbl := Label.new()
		desc_lbl.text = raid["desc"]
		desc_lbl.add_theme_font_size_override("font_size", 11)
		desc_lbl.add_theme_color_override("font_color", Color(0.85, 0.55, 0.25))
		vbox.add_child(desc_lbl)
		
		var btn_enter := Button.new()
		btn_enter.custom_minimum_size = Vector2(100, 30)
		btn_enter.text = "⚔️ THÁCH ĐẤU"
		btn_enter.add_theme_font_size_override("font_size", 10)
		btn_enter.pressed.connect(func():
			AnimEng.animate_button_click(btn_enter)
			AudioManager.play_sfx("ui_click")
			var modal = WorldBossRaidScene.instantiate()
			get_tree().root.add_child(modal)
		)
		vbox.add_child(btn_enter)
		
		list_container.add_child(panel)
