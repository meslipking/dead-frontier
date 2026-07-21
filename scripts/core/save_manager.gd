# ═══════════════════════════════════════════════════════════════
#  SAVE MANAGER (save_manager.gd) — Autoload Singleton
#  Save/Load game data với anti-cheat encryption (FNV-1a + XOR)
# ═══════════════════════════════════════════════════════════════
extends Node

const SAVE_FILE_PATH := "user://deadfrontier_save.dat"
const SAVE_VERSION := 1
const XOR_KEY := 0x7B
const DISABLE_ENCRYPTION := false  # Production anti-cheat encryption ENABLED

# ─── Default Save Data ──────────────────────────────────────
func default_save() -> Dictionary:
	return {
		"save_version": SAVE_VERSION,
		"last_online_timestamp": int(Time.get_unix_time_from_system()),
		
		# Currencies
		"gold": 100,
		"alloys": 20,
		"energy": 50,
		"crystals": 0,
		
		# Units
		"survivors": _generate_starter_survivors(),
		"monsters": [],
		"mechas": [],
		
		# Inventory
		"inventory": _generate_starter_items(),
		"equipped_items": {},  # unit_id -> { weapon: item_id, armor: item_id, accessory: item_id }
		
		# Outpost
		"outpost_levels": {
			"bunker": 1, "radio_tower": 1, "armory": 1,
			"trading_post": 1, "workshop": 1, "beast_pen": 1,
			"mecha_hangar": 1, "command_center": 1
		},
		
		# Exploration
		"zone_progress": { "ruined_suburbs": 0.0 },
		"zone_teams": {},  # zone_id -> [unit_ids]
		"unlocked_zones": ["ruined_suburbs"],
		
		# Progression
		"achievements": [],
		"achievements_progress": {},
		"prestige_level": 0,
		"prestige_shards": 0,
		
		# Settings
		"settings": {
			"language": "vi",
			"sfx_volume": 1.0,
			"music_volume": 0.7,
			"auto_speed": 1,
		},
		
		# Lifetime stats
		"lifetime_stats": {
			"kills": 0, "gold_collected": 0, "zones_cleared": 0,
			"monsters_captured": 0, "mechas_built": 0, "crafts_done": 0,
			"sieges_won": 0, "prestiges": 0, "playtime_seconds": 0,
		},
	}

# ─── Starter Units ─────────────────────────────────────────
func _generate_starter_survivors() -> Array:
	return [
		{ "id": "surv_001", "name": "Minh", "class": Constants.SurvivorClass.SCOUT,
		  "level": 1, "exp": 0, "traits": ["tough"],
		  "stats": { "hp": 100, "atk": 15, "def": 8, "spd": 12, "acc": 10, "luck": 5 } },
		{ "id": "surv_002", "name": "Hương", "class": Constants.SurvivorClass.MEDIC,
		  "level": 1, "exp": 0, "traits": ["careful"],
		  "stats": { "hp": 80, "atk": 8, "def": 6, "spd": 10, "acc": 12, "luck": 8 } },
		{ "id": "surv_003", "name": "Đức", "class": Constants.SurvivorClass.BRAWLER,
		  "level": 1, "exp": 0, "traits": ["strong"],
		  "stats": { "hp": 130, "atk": 18, "def": 12, "spd": 7, "acc": 8, "luck": 3 } },
		{ "id": "surv_004", "name": "Lan", "class": Constants.SurvivorClass.SNIPER,
		  "level": 1, "exp": 0, "traits": ["eagle_eye"],
		  "stats": { "hp": 70, "atk": 20, "def": 5, "spd": 9, "acc": 18, "luck": 6 } },
	]

func _generate_starter_items() -> Array:
	return [
		{ "id": "item_001", "name": "Dao rỉ sét", "type": Constants.ItemType.WEAPON,
		  "rarity": Constants.Rarity.COMMON, "stats": { "atk": 5 }, "upgrade_level": 0, "set_id": "scout_set" },
		{ "id": "item_002", "name": "Áo da cũ", "type": Constants.ItemType.ARMOR,
		  "rarity": Constants.Rarity.COMMON, "stats": { "def": 4, "hp": 10 }, "upgrade_level": 0, "set_id": "scout_set" },
		{ "id": "item_003", "name": "Phế liệu sắt", "type": Constants.ItemType.MATERIAL,
		  "rarity": Constants.Rarity.COMMON, "count": 5 },
		{ "id": "item_004", "name": "Mạch điện hỏng", "type": Constants.ItemType.MATERIAL,
		  "rarity": Constants.Rarity.COMMON, "count": 3 },
	]

# ─── Save Game ──────────────────────────────────────────────
func save_game(data: Dictionary) -> void:
	var json_str := JSON.stringify(data)
	var save_str: String
	
	if DISABLE_ENCRYPTION:
		save_str = json_str
	else:
		save_str = _encrypt(json_str)
	
	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(save_str)
		file.close()
		print("[SaveManager] Game saved successfully with anti-cheat checksum.")
	else:
		push_error("[SaveManager] Failed to save game! Error: " + str(FileAccess.get_open_error()))

# ─── Load Game ──────────────────────────────────────────────
func load_game() -> Dictionary:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		print("[SaveManager] No save file found. Creating default save.")
		var data := default_save()
		save_game(data)
		return data
	
	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if not file:
		push_error("[SaveManager] Failed to open save file!")
		return default_save()
	
	var raw := file.get_as_text()
	file.close()
	
	var json_str: String
	if DISABLE_ENCRYPTION:
		json_str = raw
	else:
		json_str = _decrypt(raw)
		if json_str.is_empty():
			push_warning("[SaveManager] Save file tampered or corrupted. Resetting.")
			EventBus.save_corrupted.emit()
			var data := default_save()
			save_game(data)
			return data
	
	var parsed = JSON.parse_string(json_str)
	if parsed == null or not (parsed is Dictionary):
		push_error("[SaveManager] Failed to parse save JSON!")
		return default_save()
	
	# Migration: add missing keys from default
	var defaults := default_save()
	for key in defaults:
		if not parsed.has(key):
			parsed[key] = defaults[key]
	
	print("[SaveManager] Game loaded securely. Save version: ", parsed.get("save_version", 0))
	return parsed

# ─── Encryption (FNV-1a + XOR) ─────────────────────────────
func _fnv1a_hash(text: String) -> int:
	var hash_val: int = 2166136261
	for i in text.length():
		hash_val ^= text.unicode_at(i)
		hash_val = (hash_val * 16777619) & 0xFFFFFFFF
	return hash_val

func _encrypt(json_str: String) -> String:
	var checksum := _fnv1a_hash(json_str)
	var payload := JSON.stringify({ "d": json_str, "c": checksum })
	var result := ""
	for i in payload.length():
		var code: int = payload.unicode_at(i) ^ XOR_KEY
		result += "%02x" % code
	return result

func _decrypt(hex_str: String) -> String:
	if hex_str.begins_with("{"):
		return hex_str  # Old unencrypted save — backward compat
	
	var payload_str := ""
	var i := 0
	while i < hex_str.length():
		var hex_byte := hex_str.substr(i, 2)
		var code: int = ("0x" + hex_byte).hex_to_int() ^ XOR_KEY
		payload_str += char(code)
		i += 2
	
	var parsed = JSON.parse_string(payload_str)
	if parsed == null or not (parsed is Dictionary):
		return ""
	
	var data_str: String = parsed.get("d", "")
	var saved_checksum: int = parsed.get("c", 0)
	var expected := _fnv1a_hash(data_str)
	
	if saved_checksum != expected:
		push_warning("[Anti-Cheat] Save integrity check FAILED! Tampering detected.")
		return ""
	
	return data_str
