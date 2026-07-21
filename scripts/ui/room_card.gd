# ═══════════════════════════════════════════════════════════════
#  ROOM CARD CONTROLLER (room_card.gd)
#  Hiển thị 1 phòng Tiền đồn trong Outpost Tab
# ═══════════════════════════════════════════════════════════════
extends PanelContainer

@export var icon_label: Label
@export var name_label: Label
@export var level_label: Label
@export var desc_label: Label
@export var btn_select: Button

var room_type: int = 0

func setup(p_room_type: int) -> void:
	room_type = p_room_type
	var rname: String = Constants.ROOM_NAMES.get(room_type, "Phòng")
	var rdesc: String = Constants.ROOM_DESCRIPTIONS.get(room_type, "")
	var level: int = GameManager.game_data.get("outpost_levels", {}).get(_room_type_key(), 1)
	
	if name_label: name_label.text = rname
	if level_label: level_label.text = "Cấp " + str(level)
	if desc_label: desc_label.text = rdesc
	if icon_label: icon_label.text = _get_room_icon()
	
	if btn_select:
		btn_select.pressed.connect(func(): EventBus.room_opened.emit(room_type))

func _get_room_icon() -> String:
	match room_type:
		Constants.RoomType.BUNKER: return "🏕️"
		Constants.RoomType.RADIO_TOWER: return "📻"
		Constants.RoomType.ARMORY: return "🛡️"
		Constants.RoomType.TRADING_POST: return "⚖️"
		Constants.RoomType.WORKSHOP: return "🔨"
		Constants.RoomType.BEAST_PEN: return "🐉"
		Constants.RoomType.MECHA_HANGAR: return "🤖"
		Constants.RoomType.COMMAND_CENTER: return "🏛️"
	return "🏠"

func _room_type_key() -> String:
	match room_type:
		Constants.RoomType.BUNKER: return "bunker"
		Constants.RoomType.RADIO_TOWER: return "radio_tower"
		Constants.RoomType.ARMORY: return "armory"
		Constants.RoomType.TRADING_POST: return "trading_post"
		Constants.RoomType.WORKSHOP: return "workshop"
		Constants.RoomType.BEAST_PEN: return "beast_pen"
		Constants.RoomType.MECHA_HANGAR: return "mecha_hangar"
		Constants.RoomType.COMMAND_CENTER: return "command_center"
	return "bunker"
