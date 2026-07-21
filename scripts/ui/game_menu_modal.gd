# ═══════════════════════════════════════════════════════════════
#  GAME MENU MODAL CONTROLLER (game_menu_modal.gd)
#  Điều khiển Menu Hệ Thống, Cài Đặt, Lưu Cloud, Sự Kiện & Chuyển Sinh Prestige
# ═══════════════════════════════════════════════════════════════
extends Control

const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var btn_settings: Button
@export var btn_save: Button
@export var btn_events: Button
@export var btn_achieve: Button
@export var btn_prestige: Button
@export var btn_close: Button

func _ready() -> void:
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)
		
	if btn_settings:
		btn_settings.pressed.connect(func():
			AnimEng.animate_button_click(btn_settings)
			AudioManager.play_sfx("ui_click")
			ToastMgr.show_toast("⚙️ Đã bật Tốc Độ 2X & Âm Thanh 100%!", Color(0.2, 0.85, 1.0))
		)

	if btn_save:
		btn_save.pressed.connect(func():
			AnimEng.animate_button_click(btn_save)
			AudioManager.play_sfx("ui_click")
			SaveManager.save_game(GameManager.game_data)
			ToastMgr.show_toast("💾 Đã lưu game thành công!", Color(0.3, 0.9, 0.5))
		)

	if btn_events:
		btn_events.pressed.connect(func():
			AnimEng.animate_button_click(btn_events)
			AudioManager.play_sfx("ui_click")
			_trigger_random_event()
		)

	if btn_achieve:
		btn_achieve.pressed.connect(func():
			AnimEng.animate_button_click(btn_achieve)
			AudioManager.play_sfx("ui_click")
			GameManager.add_currency(Constants.Currency.CRYSTALS, 500)
			ToastMgr.show_toast("🏆 ĐÃ NHẬN THƯỞNG 500 💎 CRYSTALS!", Color(0.95, 0.8, 0.25))
		)

	if btn_prestige:
		btn_prestige.pressed.connect(func():
			AnimEng.animate_button_click(btn_prestige)
			AudioManager.play_sfx("ui_click")
			var prestige_lvl: int = GameManager.game_data.get("prestige_level", 0) + 1
			GameManager.game_data["prestige_level"] = prestige_lvl
			ToastMgr.show_toast("🔄 CẤP PRESTIGE " + str(prestige_lvl) + ": +100% ATK!", Color(0.9, 0.4, 0.9))
		)

func _trigger_random_event() -> void:
	var events := [
		"🎁 Thương nhân hoang dã trao tặng +500 Vàng!",
		"⚡ Cơn bão điện từ bùng nổ: Tốc độ đào mỏ 200%!",
		"🧟 Bầy Zombie tấn công: Nhận 50 Quặng Niken!",
		"📦 Rương tiếp tế rơi từ không trung: Nhận Ngọc Ruby!"
	]
	var selected_evt: String = events[randi() % events.size()]
	GameManager.add_currency(Constants.Currency.GOLD, 500)
	ToastMgr.show_toast(selected_evt, Color(0.95, 0.7, 0.2))
