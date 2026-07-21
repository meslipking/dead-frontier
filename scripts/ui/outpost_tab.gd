# ═══════════════════════════════════════════════════════════════
#  OUTPOST TAB CONTROLLER (outpost_tab.gd) — 4 AAA Activities Link
#  Liên kết 4 Hoạt động AAA: Mecha Assembly, Monster Fusion, World Boss Raid, Gem Socketing
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

const RadioTowerScene = preload("res://scenes/outpost/RadioTowerRoom.tscn")
const WorkshopScene = preload("res://scenes/outpost/WorkshopRoom.tscn")
const ArmoryScene = preload("res://scenes/outpost/ArmoryRoom.tscn")

const MechaAssemblyScene = preload("res://scenes/outpost/MechaAssemblyRoom.tscn")
const MonsterBreedingScene = preload("res://scenes/outpost/MonsterBreedingRoom.tscn")
const WorldBossRaidScene = preload("res://scenes/outpost/WorldBossRaid.tscn")
const GemSocketingScene = preload("res://scenes/outpost/GemSocketingModal.tscn")

@export var room_list_container: VBoxContainer

func _ready() -> void:
	populate_rooms()

func populate_rooms() -> void:
	if not room_list_container: return
	for child in room_list_container.get_children():
		child.queue_free()
		
	var rooms := [
		{ "type": Constants.RoomType.BUNKER, "name": "QUARTERS", "status": "8/10 adventurers" },
		{ "type": Constants.RoomType.RADIO_TOWER, "name": "TAVERN", "status": "3/3 guests" },
		{ "type": Constants.RoomType.ARMORY, "name": "STORAGE", "status": "4/68 items" },
		{ "type": Constants.RoomType.TRADING_POST, "name": "MARKET", "status": "0/6 sold" },
		{ "type": Constants.RoomType.WORKSHOP, "name": "WORKSHOP", "status": "0/6 completed" },
		{ "type": Constants.RoomType.BEAST_PEN, "name": "SHELTER", "status": "0/6 pets" }
	]
	
	for room in rooms:
		var panel := PanelContainer.new()
		panel.custom_minimum_size = Vector2(0, 64)
		panel.mouse_filter = Control.MOUSE_FILTER_STOP
		
		var rtype: int = room["type"]
		panel.gui_input.connect(func(ev):
			if ev is InputEventMouseButton and ev.pressed and ev.button_index == MOUSE_BUTTON_LEFT:
				AnimEng.animate_button_click(panel)
				AudioManager.play_sfx("ui_click")
				_on_room_clicked(rtype)
		)
		
		var margin := MarginContainer.new()
		margin.add_theme_constant_override("margin_left", 8)
		margin.add_theme_constant_override("margin_top", 6)
		margin.add_theme_constant_override("margin_right", 8)
		margin.add_theme_constant_override("margin_bottom", 6)
		panel.add_child(margin)
		
		var hbox := HBoxContainer.new()
		hbox.add_theme_constant_override("separation", 12)
		margin.add_child(hbox)
		
		var icon_rect := TextureRect.new()
		icon_rect.custom_minimum_size = Vector2(40, 40)
		icon_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon_rect.texture = MasterPixel.matrix_to_texture([
			"................", "....########....", "...#BBBBBBBB#...", "..#BBBBBBBBBB#..",
			".#BBBBGGGGBBBB#.", ".#BBBGGGGGGBBB#.", ".#BBGGGGGGGGBB#.", ".#BBGGGGGGGGBB#.",
			".#BBBGGGGGGBBB#.", ".#BBBBGGGGBBBB#.", "..#BBBBBBBBBB#..", "...#BBBBBBBB#...",
			"....########....", "................"
		], 2)
		hbox.add_child(icon_rect)
		
		var vbox := VBoxContainer.new()
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		hbox.add_child(vbox)
		
		var name_lbl := Label.new()
		name_lbl.text = room["name"]
		name_lbl.add_theme_font_size_override("font_size", 14)
		name_lbl.add_theme_color_override("font_color", Color(0.95, 0.95, 0.95))
		vbox.add_child(name_lbl)
		
		var status_lbl := Label.new()
		status_lbl.text = room["status"]
		status_lbl.add_theme_font_size_override("font_size", 11)
		status_lbl.add_theme_color_override("font_color", Color(0.7, 0.75, 0.8))
		vbox.add_child(status_lbl)
		
		room_list_container.add_child(panel)

func _on_room_clicked(room_type: int) -> void:
	match room_type:
		Constants.RoomType.RADIO_TOWER:
			add_child(RadioTowerScene.instantiate())
		Constants.RoomType.WORKSHOP:
			add_child(WorkshopScene.instantiate())
		Constants.RoomType.ARMORY:
			add_child(ArmoryScene.instantiate())
		Constants.RoomType.TRADING_POST:
			add_child(MechaAssemblyScene.instantiate())
		Constants.RoomType.BEAST_PEN:
			add_child(MonsterBreedingScene.instantiate())
		_:
			add_child(WorldBossRaidScene.instantiate())
