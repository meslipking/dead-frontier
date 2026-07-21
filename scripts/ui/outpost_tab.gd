# ═══════════════════════════════════════════════════════════════
#  OUTPOST TAB CONTROLLER (outpost_tab.gd)
#  Quản lý 8/8 phòng Tiền đồn với Banner Art & Modals
# ═══════════════════════════════════════════════════════════════
extends Control

@export var grid_container: GridContainer
@export var banner_texture: TextureRect

const RoomCardScene = preload("res://scenes/shared/RoomCard.tscn")

const ROOM_SCENES := {
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
	_load_banner_image()
	populate_rooms()
	EventBus.room_opened.connect(_on_room_opened)

func _load_banner_image() -> void:
	if not banner_texture: return
	var path := "res://assets/sprites/ui/banner.jpg"
	if FileAccess.file_exists(path):
		var img := Image.load_from_file(ProjectSettings.globalize_path(path))
		if img and not img.is_empty():
			banner_texture.texture = ImageTexture.create_from_image(img)

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
		Constants.RoomType.MECHA_HANGAR,
		Constants.RoomType.COMMAND_CENTER,
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
