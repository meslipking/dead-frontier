# ═══════════════════════════════════════════════════════════════
#  AUTO BATTLE VIEWPORT CONTROLLER (auto_battle_viewport.gd)
#  Động cơ Trận Chiến Tự Động Side-Scrolling 16-Bit Task Bar Hero Realtime 11.0
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const BannerGen = preload("res://scripts/utils/pixel_art/landscape_banner_generator.gd")
const CharProfiles = preload("res://scripts/data/character_animation_profiles.gd")

@export var bg_texture: TextureRect
@export var hero_container: Control
@export var monster_container: Control
@export var vfx_container: Control
@export var lbl_loot_toast: Label

var bg_offset := 0.0
var frame_idx := 0
var anim_timer := 0.0
var combat_timer := 0.0

var hero_nodes: Array[TextureRect] = []
var hero_anim_states: Array[String] = []
var hero_anim_durations: Array[float] = []

var monster_node: TextureRect = null
var monster_anim_state: String = "walk"
var monster_anim_duration: float = 0.0

var monster_names := ["Titan Colossus", "Night Terror", "Hailstorm", "Leviathan Core"]
var current_monster_idx := 0

func _ready() -> void:
	if bg_texture:
		bg_texture.texture = BannerGen.create_landscape_banner("Obsidian Mines", 640, 160)
	_setup_party_heroes()
	_spawn_monster()

func _setup_party_heroes() -> void:
	if not hero_container: return
	for child in hero_container.get_children():
		child.queue_free()
	hero_nodes.clear()
	hero_anim_states.clear()
	hero_anim_durations.clear()
	
	var party: Array = GameManager.get_survivors()
	var spawn_x_offsets := [30.0, 70.0, 110.0, 150.0]
	
	for i in range(min(4, party.size())):
		var h_spr := TextureRect.new()
		h_spr.custom_minimum_size = Vector2(48, 48)
		h_spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		h_spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		
		var hero_name: String = str(party[i].get("name", "Iron Defender"))
		h_spr.texture = MasterPixel.get_unit_16frame_texture(hero_name, "walk", 0)
		h_spr.position = Vector2(spawn_x_offsets[i], 70.0)
		
		hero_container.add_child(h_spr)
		hero_nodes.append(h_spr)
		hero_anim_states.append("walk")
		hero_anim_durations.append(0.0)

func _spawn_monster() -> void:
	if not monster_container: return
	for child in monster_container.get_children():
		child.queue_free()
		
	var m_spr := TextureRect.new()
	m_spr.custom_minimum_size = Vector2(52, 52)
	m_spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	m_spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	var m_name: String = monster_names[current_monster_idx % monster_names.size()]
	m_spr.texture = MasterPixel.get_unit_16frame_texture(m_name, "walk", 0)
	m_spr.position = Vector2(300.0, 65.0)
	
	monster_container.add_child(m_spr)
	monster_node = m_spr
	monster_anim_state = "walk"
	monster_anim_duration = 0.0

func _process(delta: float) -> void:
	# 1. Parallax Side-Scrolling Background Motion
	bg_offset += delta * 40.0
	if bg_offset >= 320.0: bg_offset = 0.0
	if bg_texture: bg_texture.position.x = -bg_offset
	
	# 2. Update Hero & Monster Animation Timer Durations
	for i in range(hero_anim_durations.size()):
		if hero_anim_durations[i] > 0.0:
			hero_anim_durations[i] -= delta
			if hero_anim_durations[i] <= 0.0:
				hero_anim_states[i] = "walk"
				
	if monster_anim_duration > 0.0:
		monster_anim_duration -= delta
		if monster_anim_duration <= 0.0:
			monster_anim_state = "walk"
	
	# 3. 16-Frame Animation Loop Playback
	anim_timer += delta
	if anim_timer >= 0.15:
		anim_timer -= 0.15
		frame_idx = (frame_idx + 1) % 4
		_update_hero_animations()
		_update_monster_animations()
		
	# 4. Monster Walking & Combat Attack Execution Loop
	if monster_node:
		if monster_node.position.x > 180.0:
			monster_node.position.x -= delta * 50.0
		else:
			combat_timer += delta
			if combat_timer >= 0.8:
				combat_timer = 0.0
				_trigger_combat_clash()

func _update_hero_animations() -> void:
	var party: Array = GameManager.get_survivors()
	for i in range(min(hero_nodes.size(), party.size())):
		var hero_name: String = str(party[i].get("name", "Iron Defender"))
		var state: String = hero_anim_states[i] if i < hero_anim_states.size() else "walk"
		hero_nodes[i].texture = MasterPixel.get_unit_16frame_texture(hero_name, state, frame_idx)

func _update_monster_animations() -> void:
	if not monster_node: return
	var m_name: String = monster_names[current_monster_idx % monster_names.size()]
	monster_node.texture = MasterPixel.get_unit_16frame_texture(m_name, monster_anim_state, frame_idx)

func _trigger_combat_clash() -> void:
	var party: Array = GameManager.get_survivors()
	if party.size() == 0: return
	
	# Trigger ATTACK / SKILL_CAST Animation on Frontline Heroes for 0.6 seconds!
	for i in range(min(2, hero_nodes.size())):
		hero_anim_states[i] = "skill_cast" if i == 0 else "attack"
		hero_anim_durations[i] = 0.6
		
		var spr := hero_nodes[i]
		var orig_x := spr.position.x
		var tween := create_tween()
		tween.tween_property(spr, "position:x", orig_x + 15.0, 0.15)
		tween.tween_property(spr, "position:x", orig_x, 0.25)
		
	# Trigger HIT Animation on Monster for 0.5 seconds!
	monster_anim_state = "hit"
	monster_anim_duration = 0.5
	if monster_node:
		var m_orig_x := monster_node.position.x
		var m_tween := create_tween()
		m_tween.tween_property(monster_node, "position:x", m_orig_x + 10.0, 0.15)
		m_tween.tween_property(monster_node, "position:x", m_orig_x, 0.2)
		
	var lead_hero: Dictionary = party[0]
	var cname: String = str(lead_hero.get("name", "Iron Defender"))
	var skill_name := "Sóng Xung Kích Thép"
	for pid in CharProfiles.PROFILES:
		if CharProfiles.PROFILES[pid].get("name") == cname:
			skill_name = str(CharProfiles.PROFILES[pid].get("skill_name", skill_name))
			break
			
	var dmg := randi_range(550, 1250)
	var is_crit := randf() < 0.4
	
	_spawn_skill_announcement(cname, skill_name)
	_spawn_floating_damage(dmg, is_crit)
	_spawn_slash_vfx()
	
	var reward_gold := randi_range(200, 450)
	GameManager.add_currency(Constants.Currency.GOLD, reward_gold)
	
	if lbl_loot_toast:
		var txt := "⚡ KỸ NĂNG [" + skill_name + "]: GÂY -" + str(dmg) + " CRIT! (+ " + str(reward_gold) + "🟡 VÀNG)"
		lbl_loot_toast.text = txt
		lbl_loot_toast.add_theme_color_override("font_color", Color(0.95, 0.8, 0.25) if is_crit else Color(0.2, 0.85, 1.0))
		
	current_monster_idx += 1
	_spawn_monster()

func _spawn_skill_announcement(hero_name: String, skill_name: String) -> void:
	if not vfx_container: return
	var lbl := Label.new()
	lbl.text = "⚡ PORTRAIT CUT-IN [" + hero_name.to_upper() + "]: " + skill_name.to_upper() + "!"
	lbl.add_theme_font_size_override("font_size", 12)
	lbl.add_theme_color_override("font_color", Color(0.2, 0.85, 1.0))
	lbl.position = Vector2(20.0, 25.0)
	
	vfx_container.add_child(lbl)
	
	var tween := create_tween()
	tween.tween_property(lbl, "position:y", lbl.position.y - 20.0, 0.6)
	tween.parallel().tween_property(lbl, "modulate:a", 0.0, 0.6)
	tween.tween_callback(lbl.queue_free)

func _spawn_slash_vfx() -> void:
	if not vfx_container: return
	var slash := TextureRect.new()
	slash.custom_minimum_size = Vector2(48, 48)
	slash.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	slash.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	slash.texture = MasterPixel.matrix_to_texture([
		"................", "..R..........R..", "...RR......RR...", "....RR....RR....",
		".....RR..RR.....", "......RRRR......", ".......RR.......", "......RRRR......",
		".....RR..RR.....", "....RR....RR....", "...RR......RR...", "..R..........R..",
		"................", "................"
	], 3)
	slash.position = Vector2(175.0, 65.0)
	vfx_container.add_child(slash)
	
	var tween := create_tween()
	tween.tween_property(slash, "scale", Vector2(1.4, 1.4), 0.25)
	tween.parallel().tween_property(slash, "modulate:a", 0.0, 0.25)
	tween.tween_callback(slash.queue_free)

func _spawn_floating_damage(amount: int, is_crit: bool) -> void:
	if not vfx_container: return
	var dmg_lbl := Label.new()
	dmg_lbl.text = "-" + str(amount) + (" CRIT!" if is_crit else "")
	dmg_lbl.add_theme_font_size_override("font_size", 15 if is_crit else 12)
	dmg_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if is_crit else Color(1.0, 0.3, 0.3))
	dmg_lbl.position = Vector2(185.0 + randf_range(-10.0, 10.0), 40.0)
	
	vfx_container.add_child(dmg_lbl)
	
	var tween := create_tween()
	tween.tween_property(dmg_lbl, "position:y", dmg_lbl.position.y - 35.0, 0.6)
	tween.parallel().tween_property(dmg_lbl, "modulate:a", 0.0, 0.6)
	tween.tween_callback(dmg_lbl.queue_free)
