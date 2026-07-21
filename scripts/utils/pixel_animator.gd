# ═══════════════════════════════════════════════════════════════
#  PIXEL ANIMATOR ENGINE (pixel_animator.gd) — Commercial Grade
#  Tự động phát Hoạt Ảnh 16-Frame Spritesheet (idle, walk, attack, hit)
# ═══════════════════════════════════════════════════════════════
class_name PixelAnimator
extends Node

signal anim_finished(anim_name: String)

@export var target_texture_rect: TextureRect
@export var character_name: String = "Iron Defender"
@export var fps: float = 6.0

var current_anim: String = "idle" # "idle", "walk", "attack", "hit"
var current_frame: int = 0
var timer: float = 0.0
var is_playing: bool = true

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")

func _process(delta: float) -> void:
	if not is_playing or not target_texture_rect: return
	
	timer += delta
	var frame_time := 1.0 / fps
	if timer >= frame_time:
		timer -= frame_time
		current_frame = (current_frame + 1) % 4
		_update_frame()

func play(anim_name: String, p_fps: float = 6.0) -> void:
	current_anim = anim_name
	current_frame = 0
	fps = p_fps
	timer = 0.0
	is_playing = true
	_update_frame()

func _update_frame() -> void:
	if not target_texture_rect: return
	target_texture_rect.texture = MasterPixel.get_unit_16frame_texture(character_name, current_anim, current_frame)
