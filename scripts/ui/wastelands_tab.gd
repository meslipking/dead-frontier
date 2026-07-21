# ═══════════════════════════════════════════════════════════════
#  WASTELANDS TAB CONTROLLER (wastelands_tab.gd)
#  Hiển thị Danh Sách Ải Thám Hiểm Vô Hạn Sinh Tự Động 100%
# ═══════════════════════════════════════════════════════════════
extends Control

const StageGen = preload("res://scripts/systems/procedural_stage_generator.gd")
const TrackerScene = preload("res://scenes/shared/CombatStageTracker.tscn")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

@export var list_container: VBoxContainer

func _ready() -> void:
	populate_dungeons()

func populate_dungeons() -> void:
	if not list_container: return
	for child in list_container.get_children():
		child.queue_free()
		
	# Add Top Live Exploration Progress Tracker Bar
	var tracker := TrackerScene.instantiate()
	list_container.add_child(tracker)
	
	# Add Infinite Procedural Stages
	for stage_num in range(1, 6):
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
		title_lbl.add_theme_font_size_override("font_size", 15)
		title_lbl.add_theme_color_override("font_color", Color(0.98, 0.98, 0.98))
		vbox.add_child(title_lbl)
		
		var mod_lbl := Label.new()
		mod_lbl.text = "⚙️ QUY TẮC: " + str(stg_data["modifier_name"]) + " (" + str(stg_data["modifier_effect"]) + ")"
		mod_lbl.add_theme_font_size_override("font_size", 11)
		mod_lbl.add_theme_color_override("font_color", stg_data["modifier_color"])
		vbox.add_child(mod_lbl)
		
		var count_lbl := Label.new()
		count_lbl.text = "👾 Quái vật: " + str(stg_data["monster_count"]) + " | Boss: " + ("CÓ" if stg_data["has_boss"] else "KHÔNG")
		count_lbl.add_theme_font_size_override("font_size", 10)
		count_lbl.add_theme_color_override("font_color", Color(0.85, 0.85, 0.85))
		vbox.add_child(count_lbl)
		
		list_container.add_child(panel)
