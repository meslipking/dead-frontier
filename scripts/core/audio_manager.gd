# ═══════════════════════════════════════════════════════════════
#  AUDIO MANAGER (audio_manager.gd) — Autoload Singleton
#  Quản lý âm thanh BGM & hiệu ứng âm thanh SFX
# ═══════════════════════════════════════════════════════════════
extends Node

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Master"
	add_child(music_player)
	
	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = "Master"
	add_child(sfx_player)
	
	EventBus.toast_requested.connect(func(_msg, _color, _dur): play_sfx("ui_click"))

func play_sfx(sfx_name: String, pitch_range: float = 0.1) -> void:
	# Pitch variance for realistic sound feel
	if sfx_player:
		sfx_player.pitch_scale = randf_range(1.0 - pitch_range, 1.0 + pitch_range)
		print("[AudioManager] Playing SFX: ", sfx_name)

func play_music(music_name: String) -> void:
	print("[AudioManager] Playing BGM: ", music_name)
