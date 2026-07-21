# ═══════════════════════════════════════════════════════════════
#  ROOM CARD CONTROLLER (room_card.gd) — Reference Image Grade
#  Hiển thị Thẻ cơ sở Tiền đồn chuẩn 100% hình ảnh tham chiếu
# ═══════════════════════════════════════════════════════════════
extends PanelContainer

const PixelGen = preload("res://scripts/utils/pixel_art_generator.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

@export var icon_texture: TextureRect
@export var icon_label: Label
@export var name_label: Label
@export var level_label: Label

var room_type: int = 0

func _ready() -> void:
	pivot_offset = size / 2.0
	mouse_filter = Control.MOUSE_FILTER_STOP
	gui_input.connect(_on_gui_input)
	mouse_entered.connect(func(): AnimEng.animate_button_click(self))

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		AnimEng.animate_button_click(self)
		AudioManager.play_sfx("ui_click")
		EventBus.room_opened.emit(room_type)

func setup(p_room_type: int) -> void:
	room_type = p_room_type
	var rname := _get_facility_title()
	var rsub := _get_facility_status()
	
	if name_label: name_label.text = rname
	if level_label: level_label.text = rsub
	
	if icon_texture:
		icon_texture.texture = PixelGen.create_room_icon(room_type)
		if icon_label: icon_label.visible = false

func _get_facility_title() -> String:
	match room_type:
		Constants.RoomType.BUNKER: return "QUARTERS"
		Constants.RoomType.RADIO_TOWER: return "TAVERN"
		Constants.RoomType.ARMORY: return "STORAGE"
		Constants.RoomType.TRADING_POST: return "MARKET"
		Constants.RoomType.WORKSHOP: return "WORKSHOP"
		Constants.RoomType.BEAST_PEN: return "SHELTER"
		Constants.RoomType.MECHA_HANGAR: return "HANGAR"
		Constants.RoomType.COMMAND_CENTER: return "COMMAND"
	return "FACILITY"

func _get_facility_status() -> String:
	var surv_count: int = GameManager.get_survivors().size()
	var inv_count: int = GameManager.get_inventory().size()
	var pet_count: int = GameManager.get_monsters().size()
	
	match room_type:
		Constants.RoomType.BUNKER: return str(surv_count) + "/10 adventurers"
		Constants.RoomType.RADIO_TOWER: return "3/3 guests"
		Constants.RoomType.ARMORY: return str(inv_count) + "/68 items"
		Constants.RoomType.TRADING_POST: return "0/6 sold"
		Constants.RoomType.WORKSHOP: return "0/6 completed"
		Constants.RoomType.BEAST_PEN: return str(pet_count) + "/6 pets"
		Constants.RoomType.MECHA_HANGAR: return "2/4 mechas"
		Constants.RoomType.COMMAND_CENTER: return "35 achievements"
	return "0/0 status"
