# ═══════════════════════════════════════════════════════════════
#  OUTPOST TAB CONTROLLER (outpost_tab.gd) — Reference Image 3 Match
#  Quản lý 6 Cơ sở Căn cứ Tiền đồn dạng danh sách đứng mượt mà
# ═══════════════════════════════════════════════════════════════
extends Control

@export var grid_container: Container

const RoomCardScene = preload("res://scenes/shared/RoomCard.tscn")

const ROOM_SCENES := {
	Constants.RoomType.BUNKER: preload("res://scenes/outpost/BunkerRoom.tscn"),
	Constants.RoomType.RADIO_TOWER: preload("res://scenes/outpost/RadioTowerRoom.tscn"),
	Constants.RoomType.ARMORY: preload("res://scenes/outpost/ArmoryRoom.tscn"),
	Constants.RoomType.TRADING_POST: preload("res://scenes/outpost/TradingPostRoom.tscn"),
	Constants.RoomType.WORKSHOP: preload("res://scenes/outpost/WorkshopRoom.tscn"),
	Constants.RoomType.BEAST_PEN: preload("res://scenes/outpost/BeastPenRoom.tscn"),
}

func _ready() -> void:
	populate_rooms()
	EventBus.room_opened.connect(_on_room_opened)
	EventBus.tab_changed.connect(func(idx): if idx == 0: populate_rooms())

func populate_rooms() -> void:
	if not grid_container: return
	for child in grid_container.get_children():
		child.queue_free()
		
	var rooms := [
		Constants.RoomType.BUNKER,
		Constants.RoomType.RADIO_TOWER,
		Constants.RoomType.ARMORY,
		Constants.RoomType.TRADING_POST,
		Constants.RoomType.WORKSHOP,
		Constants.RoomType.BEAST_PEN,
	]
	
	for rtype in rooms:
		var card = RoomCardScene.instantiate()
		grid_container.add_child(card)
		card.setup(rtype)

func _on_room_opened(room_type: int) -> void:
	if not ROOM_SCENES.has(room_type): return
	var modal_scene: PackedScene = ROOM_SCENES[room_type]
	var modal = modal_scene.instantiate()
	add_child(modal)
