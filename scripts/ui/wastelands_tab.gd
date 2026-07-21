# ═══════════════════════════════════════════════════════════════
#  WASTELANDS TAB CONTROLLER (wastelands_tab.gd) — FlipFight Grade
#  Bản đồ Thám hiểm PVE Node Graph (10 Stage Nodes, Boss Skulls & Auto-Farm)
# ═══════════════════════════════════════════════════════════════
extends Control

const ZoneDb = preload("res://scripts/data/zone_database.gd")
const PixelGen = preload("res://scripts/utils/pixel_art_generator.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

@export var zone_title_label: Label
@export var zone_desc_label: Label
@export var nodes_container: Control
@export var btn_prev_zone: Button
@export var btn_next_zone: Button
@export var btn_start_battle: Button

var selected_zone_idx: int = 0
var current_stage_node: int = 1
var zone_list: Array = []

func _ready() -> void:
	zone_list = ZoneDb.get_all_zones()
	_update_zone_display()
	
	if btn_prev_zone:
		btn_prev_zone.pressed.connect(func():
			AnimEng.animate_button_click(btn_prev_zone)
			AudioManager.play_sfx("ui_click")
			selected_zone_idx = max(selected_zone_idx - 1, 0)
			_update_zone_display()
		)
		
	if btn_next_zone:
		btn_next_zone.pressed.connect(func():
			AnimEng.animate_button_click(btn_next_zone)
			AudioManager.play_sfx("ui_click")
			selected_zone_idx = min(selected_zone_idx + 1, zone_list.size() - 1)
			_update_zone_display()
		)
		
	if btn_start_battle:
		btn_start_battle.pressed.connect(func():
			AnimEng.animate_button_click(btn_start_battle)
			AudioManager.play_sfx("ui_click")
			_start_pve_battle()
		)

func _update_zone_display() -> void:
	if zone_list.is_empty(): return
	var zdata: Dictionary = zone_list[selected_zone_idx]
	
	if zone_title_label:
		zone_title_label.text = "🗺️ " + zdata.get("name", "Vùng hoang") + " (Cấp " + str(zdata.get("req_level", 1)) + ")"
	if zone_desc_label:
		zone_desc_label.text = zdata.get("desc", "Khu vực nguy hiểm tận thế.")
		
	_render_stage_nodes()

func _render_stage_nodes() -> void:
	if not nodes_container: return
	for child in nodes_container.get_children():
		child.queue_free()
		
	# Render 10 PVE Stage Nodes (FlipFight Node Graph)
	for i in range(1, 11):
		var btn := Button.new()
		btn.custom_minimum_size = Vector2(56, 44)
		btn.text = "1-" + str(i) if i < 10 else "☠️ BOSS"
		
		if i == 10:
			btn.modulate = Color(1.0, 0.3, 0.3) # Boss Red
		elif i <= current_stage_node:
			btn.modulate = Color(0.2, 0.9, 0.5) # Cleared Green
		else:
			btn.modulate = Color(0.7, 0.7, 0.7) # Normal
			
		var node_idx := i
		btn.pressed.connect(func():
			AnimEng.animate_button_click(btn)
			AudioManager.play_sfx("ui_click")
			current_stage_node = node_idx
			print("[WastelandsTab] Selected stage node: 1-", node_idx)
		)
		nodes_container.add_child(btn)

func _start_pve_battle() -> void:
	var CombatScene = preload("res://scenes/wastelands/CombatScene.tscn")
	var combat = CombatScene.instantiate()
	add_child(combat)
