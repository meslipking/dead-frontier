# ═══════════════════════════════════════════════════════════════
#  STORY EVENT MODAL CONTROLLER (story_event_modal.gd)
#  Điều khiển Cửa Sổ Lựa Chọn Sự Kiện Nhập Vai Ngẫu Nhiên
# ═══════════════════════════════════════════════════════════════
extends Control

const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")
const StoryEngine = preload("res://scripts/systems/procedural_story_engine.gd")

@export var lbl_title: Label
@export var lbl_desc: Label
@export var btn_opt1: Button
@export var btn_opt2: Button
@export var btn_opt3: Button
@export var btn_close: Button

var event_data: Dictionary = {}

func _ready() -> void:
	event_data = StoryEngine.generate_random_story_event()
	
	if lbl_title: lbl_title.text = str(event_data.get("title", ""))
	if lbl_desc: lbl_desc.text = str(event_data.get("desc", ""))
	if btn_opt1: btn_opt1.text = str(event_data.get("opt1", ""))
	if btn_opt2: btn_opt2.text = str(event_data.get("opt2", ""))
	if btn_opt3: btn_opt3.text = str(event_data.get("opt3", ""))
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)
		
	if btn_opt1:
		btn_opt1.pressed.connect(func():
			AnimEng.animate_button_click(btn_opt1)
			AudioManager.play_sfx("ui_click")
			if randf() < 0.7:
				GameManager.add_currency(Constants.Currency.GOLD, 800)
				ToastMgr.show_toast("🚀 CỨU HỘ THÀNH CÔNG! Nhận Súng Plasma & 800 Vàng!", Color(0.2, 0.85, 1.0))
			else:
				ToastMgr.show_toast("⚠️ Bẫy Zombie dội ra! Tổn thất nhẹ.", Color(1.0, 0.3, 0.3))
			queue_free()
		)

	if btn_opt2:
		btn_opt2.pressed.connect(func():
			AnimEng.animate_button_click(btn_opt2)
			AudioManager.play_sfx("ui_click")
			GameManager.add_currency(Constants.Currency.ALLOYS, 500)
			ToastMgr.show_toast("⛏️ Thu thập +500 Phế liệu Niken!", Color(0.95, 0.8, 0.25))
			queue_free()
		)

	if btn_opt3:
		btn_opt3.pressed.connect(func():
			AnimEng.animate_button_click(btn_opt3)
			AudioManager.play_sfx("ui_click")
			GameManager.add_currency(Constants.Currency.GOLD, 200)
			ToastMgr.show_toast("🏃 Rút lui an toàn! Nhận +200 Vàng.", Color(0.3, 0.9, 0.5))
			queue_free()
		)
