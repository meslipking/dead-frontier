# ═══════════════════════════════════════════════════════════════
#  SAVE MANAGER (save_manager.gd) — Autoload Singleton
#  Save/Load game data với anti-cheat encryption (PackedByteArray FNV-1a + XOR)
# ═══════════════════════════════════════════════════════════════
extends Node

const SAVE_FILE_PATH := "user://deadfrontier_save.dat"
const SAVE_VERSION := 1
const XOR_KEY := 0x7B
const DISABLE_ENCRYPTION := false

# ─── Default Save Data ──────────────────────────────────────
func default_save() -> Dictionary:
	return {
		"save_version": SAVE_VERSION,
		"last_online_timestamp": int(Time.get_unix_time_from_system()),
		
		# Currencies
		"gold": 4,
		"alloys": 16,
		"energy": 44,
		"crystals": 896,
		
		# Units
		"survivors": _generate_starter_survivors(),
		"monsters": [],
		"mechas": [],
		
		# Inventory
		"inventory": _generate_starter_items(),
		"equipped_items": {},
		
		# Outpost
		"outpost_levels": {
			"bunker": 1, "radio_tower": 1, "armory": 1,
			"trading_post": 1, "workshop": 1, "beast_pen": 1,
			"mecha_hangar": 1, "command_center": 1
		},
		
		# Exploration
		"zone_progress": { "ruined_suburbs": 0.0 },
		"zone_teams": {},
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

# ─── Starter Units (Matching Reference Image 5) ─────────────
func _generate_starter_survivors() -> Array:
	return [
		{ "id": "adv_1", "name": "Iron Defender", "class": Constants.SurvivorClass.BRAWLER,
		  "level": 18, "exp": 0, "traits": "Brute, Nimble",
		  "stats": { "hp": 140, "atk": 20, "def": 15, "spd": 8, "acc": 10, "luck": 5 } },
		{ "id": "adv_2", "name": "Night Terror", "class": Constants.SurvivorClass.SCOUT,
		  "level": 19, "exp": 0, "traits": "Nocturnal",
		  "stats": { "hp": 110, "atk": 24, "def": 8, "spd": 14, "acc": 14, "luck": 8 } },
		{ "id": "adv_3", "name": "Shadow Dancer", "class": Constants.SurvivorClass.SNIPER,
		  "level": 19, "exp": 0, "traits": "Brute, Nocturnal",
		  "stats": { "hp": 105, "atk": 26, "def": 7, "spd": 13, "acc": 16, "luck": 9 } },
		{ "id": "adv_4", "name": "Tempest", "class": Constants.SurvivorClass.LEADER,
		  "level": 23, "exp": 0, "traits": "Feral, Dragon Blood",
		  "stats": { "hp": 130, "atk": 28, "def": 12, "spd": 11, "acc": 15, "luck": 10 } },
		{ "id": "adv_5", "name": "Hailstorm", "class": Constants.SurvivorClass.SCOUT,
		  "level": 24, "exp": 0, "traits": "Feral",
		  "stats": { "hp": 120, "atk": 25, "def": 10, "spd": 12, "acc": 13, "luck": 6 } },
		{ "id": "adv_6", "name": "King's Hand", "class": Constants.SurvivorClass.BRAWLER,
		  "level": 26, "exp": 0, "traits": "Brute",
		  "stats": { "hp": 180, "atk": 32, "def": 18, "spd": 9, "acc": 11, "luck": 7 } },
		{ "id": "adv_7", "name": "Bard", "class": Constants.SurvivorClass.MEDIC,
		  "level": 25, "exp": 0, "traits": "Feral",
		  "stats": { "hp": 115, "atk": 16, "def": 9, "spd": 11, "acc": 12, "luck": 12 } },
		{ "id": "adv_8", "name": "Holy Knight", "class": Constants.SurvivorClass.BRAWLER,
		  "level": 19, "exp": 0, "traits": "Brute",
		  "stats": { "hp": 150, "atk": 22, "def": 16, "spd": 8, "acc": 10, "luck": 6 } },
	]

func _generate_starter_items() -> Array:
	return [
		{ "id": "item_001", "name": "Dao rỉ sét", "type": Constants.ItemType.WEAPON,
		  "rarity": Constants.Rarity.COMMON, "stats": { "atk": 5 }, "upgrade_level": 0, "set_id": "scout_set", "count": 5 },
		{ "id": "item_002", "name": "Áo da cũ", "type": Constants.ItemType.ARMOR,
		  "rarity": Constants.Rarity.COMMON, "stats": { "def": 4, "hp": 10 }, "upgrade_level": 0, "set_id": "scout_set", "count": 4 },
		{ "id": "item_003", "name": "Phế liệu sắt", "type": Constants.ItemType.MATERIAL,
		  "rarity": Constants.Rarity.COMMON, "count": 13 },
		{ "id": "item_004", "name": "Mạch điện hỏng", "type": Constants.ItemType.MATERIAL,
		  "rarity": Constants.Rarity.COMMON, "count": 28 },
		{ "id": "item_005", "name": "Quặng thạch anh", "type": Constants.ItemType.MATERIAL,
		  "rarity": Constants.Rarity.RARE, "count": 195 },
		{ "id": "item_006", "name": "Gỗ niken cổ", "type": Constants.ItemType.MATERIAL,
		  "rarity": Constants.Rarity.EPIC, "count": 248 },
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
		print("[SaveManager] Game saved successfully.")
	else:
		push_error("[SaveManager] Failed to save game!")

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
			push_warning("[SaveManager] Save file corrupted or format invalid. Resetting.")
			EventBus.save_corrupted.emit()
			var data := default_save()
			save_game(data)
			return data
	
	var parsed = JSON.parse_string(json_str)
	if parsed == null or not (parsed is Dictionary):
		push_error("[SaveManager] Failed to parse save JSON!")
		return default_save()
	
	var defaults := default_save()
	for key in defaults:
		if not parsed.has(key):
			parsed[key] = defaults[key]
	
	print("[SaveManager] Game loaded securely. Save version: ", parsed.get("save_version", 0))
	return parsed

# ─── Robust UTF-8 Byte Encryption ──────────────────────────
func _fnv1a_hash(text: String) -> int:
	var hash_val: int = 2166136261
	var bytes := text.to_utf8_buffer()
	for i in bytes.size():
		hash_val ^= bytes[i]
		hash_val = (hash_val * 16777619) & 0xFFFFFFFF
	return hash_val

func _encrypt(json_str: String) -> String:
	var checksum := _fnv1a_hash(json_str)
	var payload := JSON.stringify({ "d": json_str, "c": checksum })
	var bytes := payload.to_utf8_buffer()
	for i in bytes.size():
		bytes[i] = bytes[i] ^ XOR_KEY
	return bytes.hex_encode()

func _decrypt(hex_str: String) -> String:
	if hex_str.begins_with("{"):
		return hex_str
	
	var encrypted_bytes := PackedByteArray()
	var i := 0
	while i < hex_str.length():
		var hex_byte := hex_str.substr(i, 2)
		encrypted_bytes.append(("0x" + hex_byte).hex_to_int())
		i += 2
		
	var decrypted_bytes := PackedByteArray()
	for b in encrypted_bytes:
		decrypted_bytes.append(b ^ XOR_KEY)
	
	var payload_str := decrypted_bytes.get_string_from_utf8()
	if payload_str.is_empty():
		return ""
		
	var parsed = JSON.parse_string(payload_str)
	if parsed == null or not (parsed is Dictionary):
		return ""
	
	var data_str: String = parsed.get("d", "")
	var saved_checksum: int = parsed.get("c", 0)
	var expected := _fnv1a_hash(data_str)
	
	if saved_checksum != expected:
		push_warning("[Anti-Cheat] Save integrity check FAILED!")
		return ""
	
	return data_str
