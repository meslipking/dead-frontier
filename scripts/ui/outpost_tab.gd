# ═══════════════════════════════════════════════════════════════
#  OUTPOST TAB CONTROLLER (outpost_tab.gd)
#  Quản lý danh sách 8 phòng tiền đồn trong Tab 1
# ═══════════════════════════════════════════════════════════════
extends Control

@export var grid_container: GridContainer
var room_card_scene = preload("res://scenes/shared/RoomCard.tscn")

func _ready() -> void:
	EventBus.room_opened.connect(_on_room_opened)
	populate_rooms()

func populate_rooms() -> void:
	if not grid_container:
		return
		
	# Clear existing children
	for child in grid_container.get_children():
		child.queue_free()
		
	# Spawn 8 room cards
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
	var room_name: String = Constants.ROOM_NAMES.get(room_type, "Phòng")
	print("[OutpostTab] Room opened: ", room_name)
