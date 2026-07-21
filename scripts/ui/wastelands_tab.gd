# ═══════════════════════════════════════════════════════════════
#  WASTELANDS TAB CONTROLLER (wastelands_tab.gd)
#  Khung Trận Chiến Task Bar Hero Side-Scrolling & Bộ Chọn Đội Hình Đi Ải
# ═══════════════════════════════════════════════════════════════
extends Control

const StageGen = preload("res://scripts/systems/procedural_stage_generator.gd")
const AutoBattleViewportScene = preload("res://scenes/wastelands/AutoBattleViewport.tscn")
const PartySelectorScene = preload("res://scenes/wastelands/DungeonPartySelector.tscn")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

@export var list_container: VBoxContainer

func _ready() -> void:
	populate_dungeons()

func populate_dungeons() -> void:
	if not list_container: return
	for child in list_container.get_children():
		child.queue_free()
		
	# 1. Top Task Bar Hero Style Side-Scrolling Auto-Battle Viewport
	var auto_viewport := AutoBattleViewportScene.instantiate()
	list_container.add_child(auto_viewport)
	
	# 2. Party Selection Action Button
	var party_btn := Button.new()
	party_btn.custom_minimum_size = Vector2(0, 36)
	party_btn.text = "🛡️ CHỌN & SẮP XẾP ĐỘI HÌNH THÁM HIỂM (4 HEROES)"
	party_btn.add_theme_font_size_override("font_size", 11)
	party_btn.pressed.connect(func():
		AnimEng.animate_button_click(party_btn)
		AudioManager.play_sfx("ui_click")
		var modal = PartySelectorScene.instantiate()
		get_tree().root.add_child(modal)
	)
	list_container.add_child(party_btn)
	
	# 3. Add 6 Lore Chapters & Procedural Stages
	for stage_num in range(1, 7):
		var stg_data: Dictionary = StageGen.generate_stage_data(stage_num)
		
		var panel := PanelContainer.new()
		panel.custom_minimum_size = Vector2(0, 110)
		panel.mouse_filter = Control.MOUSE_FILTER_STOP
		
		var bg_img := TextureRect.new()
		bg_img.texture = stg_data["banner_tex"]
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
		title_lbl.text = stg_data["title"]
		title_lbl.add_theme_font_size_override("font_size", 14)
		title_lbl.add_theme_color_override("font_color", Color(0.98, 0.98, 0.98))
		vbox.add_child(title_lbl)
		
		var cp_lbl := Label.new()
		var req_cp: int = int(stg_data["recommended_cp"])
		cp_lbl.text = "⚔️ YÊU CẦU LỰC CHIẾN (CP): " + str(req_cp)
		cp_lbl.add_theme_font_size_override("font_size", 11)
		cp_lbl.add_theme_color_override("font_color", Color(0.95, 0.8, 0.25))
		vbox.add_child(cp_lbl)
		
		var mod_lbl := Label.new()
		mod_lbl.text = "⚙️ QUY TẮC: " + str(stg_data["modifier_name"]) + " (" + str(stg_data["modifier_effect"]) + ")"
		mod_lbl.add_theme_font_size_override("font_size", 10)
		mod_lbl.add_theme_color_override("font_color", stg_data["modifier_color"])
		vbox.add_child(mod_lbl)
		
		list_container.add_child(panel)
