# ═══════════════════════════════════════════════════════════════
#  MECHA ASSEMBLY ROOM CONTROLLER (mecha_assembly_room.gd)
#  Xưởng Lắp Ráp Mecha Modular với Preview 64x64 HD Live & Hàn Kim Loại VFX
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")
const ToastMgr = preload("res://scripts/ui/toast_manager.gd")

@export var mecha_preview: TextureRect
@export var btn_arm: Button
@export var btn_leg: Button
@export var btn_core: Button
@export var btn_armor: Button
@export var btn_assemble: Button
@export var btn_close: Button

var arm_parts: Array[String] = ["Plasma Blaster MK-IV", "Heavy Railgun Cannon", "Laser Gatling Gun"]
var leg_parts: Array[String] = ["Titan Hydraulics", "Jetpack Boosters", "Tracked Crawler Base"]
var core_parts: Array[String] = ["Fusion Core High-Temp", "Dark Quantum Reactor", "Overclocked Battery"]
var armor_parts: Array[String] = ["Niken Pauldrons 3D", "Laser Matrix Shield", "Exo-Plating Heavy"]

var idx_arm := 0
var idx_leg := 0
var idx_core := 0
var idx_armor := 0

func _ready() -> void:
	_update_preview()
	
	if btn_close:
		btn_close.pressed.connect(func():
			AnimEng.animate_button_click(btn_close)
			AudioManager.play_sfx("ui_click")
			queue_free()
		)
		
	if btn_arm:
		btn_arm.pressed.connect(func():
			idx_arm = (idx_arm + 1) % arm_parts.size()
			var name_arm: String = arm_parts[idx_arm]
			btn_arm.text = "🔫 TAY PHÁO: " + name_arm.to_upper()
			_update_preview()
			ToastMgr.show_toast("⚙️ Thay Tay Pháo: " + name_arm, Color(0.2, 0.85, 1.0))
		)

	if btn_leg:
		btn_leg.pressed.connect(func():
			idx_leg = (idx_leg + 1) % leg_parts.size()
			var name_leg: String = leg_parts[idx_leg]
			btn_leg.text = "🦿 CHÂN TRỢ LỰC: " + name_leg.to_upper()
			_update_preview()
			ToastMgr.show_toast("⚙️ Thay Chân Trợ Lực: " + name_leg, Color(0.9, 0.75, 0.3))
		)

	if btn_core:
		btn_core.pressed.connect(func():
			idx_core = (idx_core + 1) % core_parts.size()
			var name_core: String = core_parts[idx_core]
			btn_core.text = "☢️ LÕI PHẢN ỨNG: " + name_core.to_upper()
			_update_preview()
			ToastMgr.show_toast("⚙️ Thay Lõi Phản Ứng: " + name_core, Color(0.8, 0.4, 0.9))
		)

	if btn_armor:
		btn_armor.pressed.connect(func():
			idx_armor = (idx_armor + 1) % armor_parts.size()
			var name_armor: String = armor_parts[idx_armor]
			btn_armor.text = "🛡️ GIÁP VAI: " + name_armor.to_upper()
			_update_preview()
			ToastMgr.show_toast("⚙️ Thay Giáp Vai: " + name_armor, Color(0.3, 0.9, 0.5))
		)

	if btn_assemble:
		btn_assemble.pressed.connect(func():
			AnimEng.animate_button_click(btn_assemble)
			AudioManager.play_sfx("ui_click")
			if GameManager.spend_currency(Constants.Currency.GOLD, 4):
				ToastMgr.show_toast("⚡ LẮP RÁP MECHA TITAN THÀNH CÔNG! (+500 ATK)", Color(0.95, 0.8, 0.25))
			else:
				ToastMgr.show_toast("❌ Không đủ Vàng!", Color(0.9, 0.3, 0.3))
		)

func _update_preview() -> void:
	if not mecha_preview: return
	mecha_preview.texture = MasterPixel.get_unit_16frame_texture("King's Hand", "idle", (idx_arm + idx_leg + idx_core + idx_armor) % 4)
