# ═══════════════════════════════════════════════════════════════
#  WORLD BOSS RAID CONTROLLER (world_boss_raid.gd)
#  Trận Chiến Boss Thế Giới Khổng Lồ 128x128 với 10-Phase HP Bar
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var boss_avatar: TextureRect
@export var lbl_boss_name: Label
@export var hp_bar: ProgressBar
@export var lbl_hp: Label
@export var btn_attack: Button
@export var btn_close: Button

var max_hp: int = 10_000_000
var cur_hp: int = 10_000_000
var frame_idx: int = 0
var anim_timer: float = 0.0

func _ready() -> void:
	_update_boss_display()
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)
		
	if btn_attack:
		btn_attack.pressed.connect(func():
			AnimEng.animate_button_click(btn_attack)
			AudioManager.play_sfx("ui_click")
			if GameManager.spend_currency(Constants.Currency.GOLD, 1):
				var dmg := randi_range(250_000, 500_000)
				cur_hp = max(0, cur_hp - dmg)
				_update_boss_display()
				ToastMgr.show_toast("💥 Đã gây " + str(dmg) + " sát thương lên Boss!", Color(1, 0.3, 0.2))
			else:
				ToastMgr.show_toast("❌ Không đủ Vàng!", Color(0.9, 0.3, 0.3))
		)

func _process(delta: float) -> void:
	if not boss_avatar: return
	anim_timer += delta
	if anim_timer >= 0.2:
		anim_timer -= 0.2
		frame_idx = (frame_idx + 1) % 4
		boss_avatar.texture = MasterPixel.get_unit_16frame_texture("Night Terror", "attack", frame_idx)

func _update_boss_display() -> void:
	if hp_bar: hp_bar.value = (float(cur_hp) / float(max_hp)) * 100.0
	if lbl_hp: lbl_hp.text = "HP BOSS: " + str(cur_hp) + " / " + str(max_hp)
