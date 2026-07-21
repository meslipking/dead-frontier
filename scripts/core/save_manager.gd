# ═══════════════════════════════════════════════════════════════
#  SAVE MANAGER (save_manager.gd) — 8 Full AAA Heroes Roster Default
# ═══════════════════════════════════════════════════════════════
extends Node

const SAVE_PATH := "user://save_game.json"
const SAVE_VERSION := "11.0"

static func load_game() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return get_default_save()
		
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return get_default_save()
		
	var json_str := file.get_as_text()
	file.close()
	
	var json := JSON.new()
	var err := json.parse(json_str)
	if err != OK:
		return get_default_save()
		
	var data: Dictionary = json.get_data()
	
	# Migration check: ensure all 8 heroes exist in survivors roster
	var survivors: Array = data.get("survivors", [])
	if survivors.size() < 8:
		data["survivors"] = get_default_save()["survivors"]
		
	return data

static func save_game(data: Dictionary) -> void:
	data["version"] = SAVE_VERSION
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))
		file.close()

static func get_default_save() -> Dictionary:
	return {
		"version": SAVE_VERSION,
		"gold": 25000,
		"alloys": 100,
		"energy": 50,
		"crystals": 500,
		"prestige_level": 0,
		"survivors": [
			{ "name": "Iron Defender", "level": 25, "stats": { "hp": 450, "atk": 65, "def": 40 } },
			{ "name": "Shadow Ninja", "level": 22, "stats": { "hp": 320, "atk": 85, "def": 25 } },
			{ "name": "Nocturnal Mage", "level": 20, "stats": { "hp": 280, "atk": 95, "def": 20 } },
			{ "name": "Feral Ranger", "level": 21, "stats": { "hp": 310, "atk": 88, "def": 22 } },
			{ "name": "Mecha Pilot", "level": 24, "stats": { "hp": 410, "atk": 75, "def": 35 } },
			{ "name": "Bio Alchemist", "level": 19, "stats": { "hp": 350, "atk": 55, "def": 30 } },
			{ "name": "Holy Paladin", "level": 23, "stats": { "hp": 500, "atk": 60, "def": 50 } },
			{ "name": "Cyber Templar", "level": 22, "stats": { "hp": 340, "atk": 90, "def": 28 } }
		],
		"inventory": [],
		"monsters": [],
		"mechas": []
	}
