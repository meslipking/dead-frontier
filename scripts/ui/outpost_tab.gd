# ═══════════════════════════════════════════════════════════════
#  OUTPOST TAB CONTROLLER (outpost_tab.gd)
#  Quản lý danh sách 8 phòng tiền đồn & kết nối Modal view (8/8 Rooms)
# ═══════════════════════════════════════════════════════════════
extends Control

@export var grid_container: GridContainer
var room_card_scene = preload("res://scenes/shared/RoomCard.tscn")

var room_scenes := {
	Constants.RoomType.BUNKER: preload("res://scenes/outpost/BunkerRoom.tscn"),
	Constants.RoomType.RADIO_TOWER: preload("res://scenes/outpost/RadioTowerRoom.tscn"),
	Constants.RoomType.ARMORY: preload("res://scenes/outpost/ArmoryRoom.tscn"),
	Constants.RoomType.TRADING_POST: preload("res://scenes/outpost/TradingPostRoom.tscn"),
	Constants.RoomType.WORKSHOP: preload("res://scenes/outpost/WorkshopRoom.tscn"),
	Constants.RoomType.BEAST_PEN: preload("res://scenes/outpost/BeastPenRoom.tscn"),
	Constants.RoomType.MECHA_HANGAR: preload("res://scenes/outpost/MechaHangarRoom.tscn"),
	Constants.RoomType.COMMAND_CENTER: preload("res://scenes/outpost/CommandCenterRoom.tscn"),
}

func _ready() -> void:
	EventBus.room_opened.connect(_on_room_opened)
	populate_rooms()

func populate_rooms() -> void:
	if not grid_container:
		return
		
	for child in grid_container.get_children():
		child.queue_free()
		
	for r_type in [
		Constants.RoomType.BUNKER,
		Constants.RoomType.RADIO_TOWER,
		Constants.RoomType.ARMORY,
		Constants.RoomType.TRADING_POST,
		Constants.RoomType.WORKSHOP,
		Constants.RoomType.BEAST_PEN,
		Constants.RoomType.MECHA_HANGAR,
		Constants.RoomType.COMMAND_CENTER
	]:
		var card = room_card_scene.instantiate()
		grid_container.add_child(card)
		card.setup(r_type)

func _on_room_opened(room_type: int) -> void:
	if room_scenes.has(room_type):
		var modal = room_scenes[room_type].instantiate()
		add_child(modal)
		modal.show()
