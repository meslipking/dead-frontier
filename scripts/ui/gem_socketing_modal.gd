# ═══════════════════════════════════════════════════════════════
#  GEM SOCKETING MODAL CONTROLLER (gem_socketing_modal.gd)
#  Khảm Ngọc Thuộc Tính (Ruby, Sapphire, Emerald) & Phù Phép Particle Aura
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var gear_preview: TextureRect
@export var lbl_socket_status: Label
@export var btn_gem_ruby: Button
@export var btn_gem_sapphire: Button
@export var btn_gem_emerald: Button
@export var btn_close: Button

func _ready() -> void:
	if gear_preview: gear_preview.texture = MasterPixel.get_modern_gear_texture("Plasma Rifle")
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)
		
	if btn_gem_ruby:
		btn_gem_ruby.pressed.connect(func():
			AnimEng.animate_button_click(btn_gem_ruby)
			AudioManager.play_sfx("ui_click")
			if lbl_socket_status: lbl_socket_status.text = "ĐÃ KHẢM: NGỌC RUBY ĐỎ (ATK +25%)"
			ToastMgr.show_toast("🔴 Đã khảm Ngọc Ruby (ATK +25%)!", Color(1.0, 0.3, 0.3))
		)

	if btn_gem_sapphire:
		btn_gem_sapphire.pressed.connect(func():
			AnimEng.animate_button_click(btn_gem_sapphire)
			AudioManager.play_sfx("ui_click")
			if lbl_socket_status: lbl_socket_status.text = "ĐÃ KHẢM: NGỌC SAPPHIRE XANH (DEF +25%)"
			ToastMgr.show_toast("🔵 Đã khảm Ngọc Sapphire (DEF +25%)!", Color(0.3, 0.7, 1.0))
		)

	if btn_gem_emerald:
		btn_gem_emerald.pressed.connect(func():
			AnimEng.animate_button_click(btn_gem_emerald)
			AudioManager.play_sfx("ui_click")
			if lbl_socket_status: lbl_socket_status.text = "ĐÃ KHẢM: NGỌC EMERALD XANH LÁ (HP +35%)"
			ToastMgr.show_toast("🟢 Đã khảm Ngọc Emerald (HP +35%)!", Color(0.3, 0.9, 0.4))
		)
