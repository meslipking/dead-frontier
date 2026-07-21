# ═══════════════════════════════════════════════════════════════
#  VISUAL COMBAT CONTROLLER (visual_combat.gd)
#  Điều khiển sàn đấu 2D trực quan: Hoạt ảnh, nảy số sát thương,
#  thanh Máu/Action Bar & Tốc độ trận đấu (1x, 2x, 4x, Skip)
# ═══════════════════════════════════════════════════════════════
class_name VisualCombatController
extends Control

signal battle_finished(victory: bool, rewards: Dictionary)

@export var player_slots: Array[NodePath]
@export var enemy_slots: Array[NodePath]
@export var damage_container: Control
@export var speed_btn: Button
@export var skip_btn: Button
@export var battle_log_text: TextEdit

var battle_speed: float = 1.0
var is_battling: bool = false
var is_skipped: bool = false

const SPEED_STEPS := [1.0, 2.0, 4.0]
var current_speed_idx: int = 0

func _ready() -> void:
	if speed_btn:
		speed_btn.pressed.connect(_on_speed_toggle)
	if skip_btn:
		skip_btn.pressed.connect(_on_skip_pressed)

func _on_speed_toggle() -> void:
	current_speed_idx = (current_speed_idx + 1) % SPEED_STEPS.size()
	battle_speed = SPEED_STEPS[current_speed_idx]
	if speed_btn:
		speed_btn.text = "%dX Tốc độ" % int(battle_speed)

func _on_skip_pressed() -> void:
	is_skipped = true

func start_visual_battle(player_team: Array, enemy_team: Array) -> void:
	is_battling = true
	is_skipped = false
	
	# Run simulation in memory first
	var battle_result := CombatManager.simulate_battle(player_team, enemy_team)
	var logs: Array = battle_result.get("logs", [])
	
	if battle_log_text:
		var full_txt := ""
		for line in logs:
			full_txt += line + "\n"
		battle_log_text.text = full_txt
		
	# Spawn floating numbers for visual feedback
	for i in min(logs.size(), 12):
		if is_skipped:
			break
		var line: String = logs[i]
		if "sát thương" in line:
			spawn_floating_damage(line, Color(1, 0.3, 0.3))
		elif "né tránh" in line:
			spawn_floating_damage("NÉ TRÁNH!", Color(0.4, 0.8, 1.0))
		await get_tree().create_timer(0.3 / battle_speed).timeout
		
	is_battling = false
	battle_finished.emit(battle_result.get("victory", false), battle_result)

func spawn_floating_damage(text: String, color: Color) -> void:
	if not damage_container:
		return
		
	var lbl := Label.new()
	lbl.text = text
	lbl.modulate = color
	lbl.position = Vector2(randf_range(50, 250), randf_range(100, 300))
	lbl.add_theme_font_size_override("font_size", 16)
	damage_container.add_child(lbl)
	
	# Animate float up and fade
	var tween := create_tween()
	tween.tween_property(lbl, "position:y", lbl.position.y - 40, 0.6 / battle_speed)
	tween.parallel().tween_property(lbl, "modulate:a", 0.0, 0.6 / battle_speed)
	tween.tween_callback(lbl.queue_free)
