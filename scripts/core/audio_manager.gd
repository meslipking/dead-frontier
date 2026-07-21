# ═══════════════════════════════════════════════════════════════
#  AUDIO MANAGER (audio_manager.gd) — Autoload Singleton (Premium Edition)
#  Quản lý âm thanh BGM & SFX tổng hợp GDScript kiểu FlipFight
# ═══════════════════════════════════════════════════════════════
extends Node

const Synth = preload("res://scripts/core/audio_synth.gd")

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

var cached_sfx := {}

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Master"
	add_child(music_player)
	
	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = "Master"
	add_child(sfx_player)
	
	cached_sfx["ui_click"] = Synth.generate_laser_sfx(1200.0, 0.06)
	cached_sfx["slash"] = Synth.generate_slash_sfx(0.12)
	cached_sfx["laser"] = Synth.generate_laser_sfx(880.0, 0.15)
	
	EventBus.toast_requested.connect(func(_msg, _color, _dur): play_sfx("ui_click"))

func play_sfx(sfx_name: String, pitch_range: float = 0.1) -> void:
	if sfx_player:
		if cached_sfx.has(sfx_name):
			sfx_player.stream = cached_sfx[sfx_name]
			sfx_player.pitch_scale = randf_range(1.0 - pitch_range, 1.0 + pitch_range)
			sfx_player.play()
		print("[AudioManager] Playing procedural SFX: ", sfx_name)

func play_music(music_name: String) -> void:
	print("[AudioManager] Playing BGM: ", music_name)
