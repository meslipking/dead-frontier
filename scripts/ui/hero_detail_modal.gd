# ═══════════════════════════════════════════════════════════════
#  HERO DETAIL MODAL CONTROLLER (hero_detail_modal.gd) — Permadeath Handling
#  Hiển thị Chi Tiết Kỹ Năng Độc Bản, Hoạt Ảnh 16-Frame, Đổi Trang Bị, & Tử Trận (Permadeath)
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")
const CharProfiles = preload("res://scripts/data/character_animation_profiles.gd")

@export var anim_sprite: TextureRect
@export var lbl_name: Label
@export var lbl_class: Label
@export var lbl_level: Label
@export var lbl_traits: Label
@export var lbl_stats: Label

@export var slot_weapon: TextureRect
@export var slot_armor: TextureRect
@export var slot_acc: TextureRect

@export var btn_anim_toggle: Button
@export var btn_dismiss: Button
@export var btn_close: Button

var hero_data: Dictionary = {}
var anim_states: Array[String] = ["idle", "walk", "attack", "hit"]
var current_anim_idx: int = 0
var frame_idx: int = 0
var anim_timer: float = 0.0

var modern_weapons: Array[String] = ["Plasma Rifle", "Chainsaw Greatsword", "Heavy Railgun", "Laser Sniper"]
var modern_armors: Array[String] = ["Titan Exo-Skeleton", "Kevlar Tactical Vest", "Cybernetic Armor", "Hazmat Bio-Shield"]
var modern_accs: Array[String] = ["Cyber HUD Visor", "Plasma Core Reactor", "Anti-Virus Injector", "Energy Shield Node"]

var cur_wpn_idx: int = 0
var cur_arm_idx: int = 0
var cur_acc_idx: int = 0

func _ready() -> void:
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)
		
	if btn_dismiss:
		btn_dismiss.pressed.connect(func():
			AnimEng.animate_button_click(btn_dismiss)
			AudioManager.play_sfx("ui_click")
			var cname: String = str(hero_data.get("name", ""))
			if GameManager.remove_survivor(cname):
				ToastMgr.show_toast("💀 Anh hùng " + cname + " đã tử trận/bị sa thải vĩnh viễn!", Color(1.0, 0.3, 0.3))
			queue_free()
		)
		
	if btn_anim_toggle:
		btn_anim_toggle.pressed.connect(func():
			AnimEng.animate_button_click(btn_anim_toggle)
			AudioManager.play_sfx("ui_click")
			current_anim_idx = (current_anim_idx + 1) % anim_states.size()
			btn_anim_toggle.text = "⚔️ ANIM: " + anim_states[current_anim_idx].to_upper()
		)

	if slot_weapon:
		slot_weapon.gui_input.connect(func(ev):
			if ev is InputEventMouseButton and ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
				cur_wpn_idx = (cur_wpn_idx + 1) % modern_weapons.size()
				var wname: String = str(modern_weapons[cur_wpn_idx])
				slot_weapon.texture = MasterPixel.get_modern_gear_texture(wname)
				ToastMgr.show_toast("🔫 Đã trang bị: " + wname, Color(0.2, 0.85, 1.0))
				AudioManager.play_sfx("ui_click")
		)
		
	if slot_armor:
		slot_armor.gui_input.connect(func(ev):
			if ev is InputEventMouseButton and ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
				cur_arm_idx = (cur_arm_idx + 1) % modern_armors.size()
				var aname: String = str(modern_armors[cur_arm_idx])
				slot_armor.texture = MasterPixel.get_modern_gear_texture(aname)
				ToastMgr.show_toast("🛡️ Đã trang bị: " + aname, Color(0.9, 0.75, 0.3))
				AudioManager.play_sfx("ui_click")
		)

	if slot_acc:
		slot_acc.gui_input.connect(func(ev):
			if ev is InputEventMouseButton and ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
				cur_acc_idx = (cur_acc_idx + 1) % modern_accs.size()
				var acname: String = str(modern_accs[cur_acc_idx])
				slot_acc.texture = MasterPixel.get_modern_gear_texture(acname)
				ToastMgr.show_toast("🥽 Đã trang bị: " + acname, Color(0.8, 0.4, 0.9))
				AudioManager.play_sfx("ui_click")
		)

func _process(delta: float) -> void:
	if not anim_sprite or hero_data.is_empty(): return
	
	anim_timer += delta
	if anim_timer >= 0.15: # 6.6 FPS playback
		anim_timer -= 0.15
		frame_idx = (frame_idx + 1) % 4
		_update_sprite_frame()

func setup(adv: Dictionary) -> void:
	hero_data = adv
	var cname: String = str(adv.get("name", "Iron Defender"))
	
	# Lookup Unique Skill & Gear Data from Profiles
	var profile: Dictionary = {}
	for pid in CharProfiles.PROFILES:
		if CharProfiles.PROFILES[pid].get("name") == cname:
			profile = CharProfiles.PROFILES[pid]
			break
			
	var skill_title: String = str(profile.get("skill_name", "Sóng Xung Kích Thép"))
	var skill_desc: String = str(profile.get("skill_desc", "Vung khiên giậm nứt đất bão nổ niken"))
	
	if lbl_name: lbl_name.text = cname
	if lbl_class: lbl_class.text = "⚡ Skill Độc Bản: " + skill_title
	if lbl_level: lbl_level.text = "Level " + str(adv.get("level", 18))
	if lbl_traits: lbl_traits.text = "📜 " + skill_desc
	
	var stats: Dictionary = adv.get("stats", {})
	if lbl_stats:
		lbl_stats.text = "HP: " + str(stats.get("hp", 140)) + "  |  ATK: " + str(stats.get("atk", 20)) + "  |  DEF: " + str(stats.get("def", 15)) + "\n" \
			+ "SPD: " + str(stats.get("spd", 8)) + "  |  ACC: " + str(stats.get("acc", 10)) + "  |  LUCK: " + str(stats.get("luck", 5))
			
	var eq_wpn: String = str(profile.get("equipped_weapon", modern_weapons[0]))
	var eq_arm: String = str(profile.get("equipped_armor", modern_armors[0]))
	var eq_acc: String = str(profile.get("equipped_acc", modern_accs[0]))
	
	if slot_weapon: slot_weapon.texture = MasterPixel.get_modern_gear_texture(eq_wpn)
	if slot_armor: slot_armor.texture = MasterPixel.get_modern_gear_texture(eq_arm)
	if slot_acc: slot_acc.texture = MasterPixel.get_modern_gear_texture(eq_acc)
	
	_update_sprite_frame()

func _update_sprite_frame() -> void:
	if not anim_sprite: return
	var cname: String = str(hero_data.get("name", "Iron Defender"))
	var state_name: String = anim_states[current_anim_idx]
	anim_sprite.texture = MasterPixel.get_unit_16frame_texture(cname, state_name, frame_idx)
