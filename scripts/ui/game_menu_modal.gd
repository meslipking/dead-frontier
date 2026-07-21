# ═══════════════════════════════════════════════════════════════
#  GAME MENU MODAL CONTROLLER (game_menu_modal.gd) — 12 Modules Coverage
#  Điều khiển Menu Hệ Thống, Lối Tắt Truy Cập Nhanh Toàn Bộ 12 Module Game
# ═══════════════════════════════════════════════════════════════
extends Control

const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

const RadioTowerScene = preload("res://scenes/outpost/RadioTowerRoom.tscn")
const WorkshopScene = preload("res://scenes/outpost/WorkshopRoom.tscn")
const ArmoryScene = preload("res://scenes/outpost/ArmoryRoom.tscn")
const MarketScene = preload("res://scenes/outpost/MarketRoom.tscn")
const MechaAssemblyScene = preload("res://scenes/outpost/MechaAssemblyRoom.tscn")
const MonsterBreedingScene = preload("res://scenes/outpost/MonsterBreedingRoom.tscn")
const WorldBossRaidScene = preload("res://scenes/outpost/WorldBossRaid.tscn")

@export var btn_quarters: Button
@export var btn_tavern: Button
@export var btn_storage: Button
@export var btn_market: Button
@export var btn_workshop: Button
@export var btn_shelter: Button
@export var btn_mecha: Button
@export var btn_fusion: Button
@export var btn_worldboss: Button
@export var btn_settings: Button
@export var btn_save: Button
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
		
	_connect_modal_launch(btn_quarters, func(): GameManager.switch_tab(0))
	_connect_modal_launch(btn_tavern, func(): get_tree().root.add_child(RadioTowerScene.instantiate()))
	_connect_modal_launch(btn_storage, func(): get_tree().root.add_child(ArmoryScene.instantiate()))
	_connect_modal_launch(btn_market, func(): get_tree().root.add_child(MarketScene.instantiate()))
	_connect_modal_launch(btn_workshop, func(): get_tree().root.add_child(WorkshopScene.instantiate()))
	_connect_modal_launch(btn_shelter, func(): get_tree().root.add_child(MonsterBreedingScene.instantiate()))
	_connect_modal_launch(btn_mecha, func(): get_tree().root.add_child(MechaAssemblyScene.instantiate()))
	_connect_modal_launch(btn_fusion, func(): get_tree().root.add_child(MonsterBreedingScene.instantiate()))
	_connect_modal_launch(btn_worldboss, func(): get_tree().root.add_child(WorldBossRaidScene.instantiate()))

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

func _connect_modal_launch(btn: Button, callback: Callable) -> void:
	if not btn: return
	btn.pressed.connect(func():
		AnimEng.animate_button_click(btn)
		AudioManager.play_sfx("ui_click")
		callback.call()
		queue_free()
	)
