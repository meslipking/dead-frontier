# ═══════════════════════════════════════════════════════════════
#  AUTO BATTLE VIEWPORT CONTROLLER (auto_battle_viewport.gd)
#  Động cơ Trận Chiến Tự Động Side-Scrolling 16-Bit Task Bar Hero Realtime
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const BannerGen = preload("res://scripts/utils/pixel_art/landscape_banner_generator.gd")

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
var monster_node: TextureRect = null

var monster_names := ["Titan Colossus", "Night Terror", "Hailstorm"]
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
	
	var party: Array = GameManager.get_survivors()
	var spawn_x_offsets := [30.0, 70.0, 110.0, 150.0]
	
	for i in range(min(4, party.size())):
		var h_spr := TextureRect.new()
		h_spr.custom_minimum_size = Vector2(48, 48)
		h_spr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		h_spr.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		
		var hero_name: String = str(party[i].get("name", "Iron Defender"))
		h_spr.texture = MasterPixel.get_unit_16frame_texture(hero_name, "walk", 0)
		h_spr.position = Vector2(spawn_x_offsets[i], 75.0)
		
		hero_container.add_child(h_spr)
		hero_nodes.append(h_spr)

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
	m_spr.position = Vector2(300.0, 70.0)
	
	monster_container.add_child(m_spr)
	monster_node = m_spr

func _process(delta: float) -> void:
	# 1. Parallax Side-Scrolling Background Motion
	bg_offset += delta * 40.0
	if bg_offset >= 320.0: bg_offset = 0.0
	if bg_texture: bg_texture.position.x = -bg_offset
	
	# 2. 16-Frame Walking Animation Loop for Party Heroes
	anim_timer += delta
	if anim_timer >= 0.15:
		anim_timer -= 0.15
		frame_idx = (frame_idx + 1) % 4
		_update_hero_animations()
		
	# 3. Monster Walking & Combat Attack Loop
	if monster_node:
		if monster_node.position.x > 180.0:
			monster_node.position.x -= delta * 50.0
		else:
			# Combat Clash Trigger!
			combat_timer += delta
			if combat_timer >= 0.8:
				combat_timer = 0.0
				_trigger_combat_clash()

func _update_hero_animations() -> void:
	var party: Array = GameManager.get_survivors()
	for i in range(min(hero_nodes.size(), party.size())):
		var hero_name: String = str(party[i].get("name", "Iron Defender"))
		hero_nodes[i].texture = MasterPixel.get_unit_16frame_texture(hero_name, "walk", frame_idx)

func _trigger_combat_clash() -> void:
	var party: Array = GameManager.get_survivors()
	if party.size() == 0: return
	
	# Switch frontline hero to attack animation
	var lead_name: String = str(party[0].get("name", "Iron Defender"))
	if hero_nodes.size() > 0:
		hero_nodes[0].texture = MasterPixel.get_unit_16frame_texture(lead_name, "attack", 2)
		
	# Spawn Floating Damage Text & Laser VFX
	var dmg := randi_range(350, 750)
	var is_crit := randf() < 0.4
	
	_spawn_floating_damage(dmg, is_crit)
	
	# Rewards Toast & Respawn Next Monster
	var reward_gold := randi_range(150, 300)
	GameManager.add_currency(Constants.Currency.GOLD, reward_gold)
	
	if lbl_loot_toast:
		var txt := "💥 CRIT! Gây -" + str(dmg) + " sát thương! (Nhận +" + str(reward_gold) + "🟡 Vàng)" if is_crit else "⚔️ Gây -" + str(dmg) + " sát thương! (Nhận +" + str(reward_gold) + "🟡 Vàng)"
		lbl_loot_toast.text = txt
		lbl_loot_toast.add_theme_color_override("font_color", Color(0.95, 0.8, 0.25) if is_crit else Color(0.2, 0.85, 1.0))
		
	current_monster_idx += 1
	_spawn_monster()

func _spawn_floating_damage(amount: int, is_crit: bool) -> void:
	if not vfx_container: return
	var dmg_lbl := Label.new()
	dmg_lbl.text = "-" + str(amount) + (" CRIT!" if is_crit else "")
	dmg_lbl.add_theme_font_size_override("font_size", 14 if is_crit else 11)
	dmg_lbl.add_theme_color_override("font_color", Color(1.0, 0.85, 0.2) if is_crit else Color(1.0, 0.3, 0.3))
	dmg_lbl.position = Vector2(180.0 + randf_range(-10.0, 10.0), 50.0)
	
	vfx_container.add_child(dmg_lbl)
	
	var tween := create_tween()
	tween.tween_property(dmg_lbl, "position:y", dmg_lbl.position.y - 30.0, 0.5)
	tween.parallel().tween_property(dmg_lbl, "modulate:a", 0.0, 0.5)
	tween.tween_callback(dmg_lbl.queue_free)
