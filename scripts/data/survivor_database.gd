# ═══════════════════════════════════════════════════════════════
#  SURVIVOR DATABASE (survivor_database.gd) — 100 Unique Adventurers
#  Cung cấp 100 Adventurers độc bản chuẩn 100% hình ảnh tham chiếu
# ═══════════════════════════════════════════════════════════════
class_name SurvivorDatabase

const CharProfiles = preload("res://scripts/data/character_animation_profiles.gd")

const CLASS_DATA := {
	Constants.SurvivorClass.SCOUT: {
		"name": "Trinh Sát",
		"base_stats": { "hp": 100, "atk": 15, "def": 8, "spd": 12, "acc": 10, "luck": 5 }
	},
	Constants.SurvivorClass.MEDIC: {
		"name": "Y Sĩ",
		"base_stats": { "hp": 80, "atk": 8, "def": 6, "spd": 10, "acc": 12, "luck": 8 }
	},
	Constants.SurvivorClass.ENGINEER: {
		"name": "Kỹ Sư",
		"base_stats": { "hp": 90, "atk": 12, "def": 10, "spd": 9, "acc": 14, "luck": 4 }
	},
	Constants.SurvivorClass.SNIPER: {
		"name": "Bắn Tỉa",
		"base_stats": { "hp": 70, "atk": 22, "def": 5, "spd": 11, "acc": 18, "luck": 7 }
	},
	Constants.SurvivorClass.BRAWLER: {
		"name": "Đấu Sĩ",
		"base_stats": { "hp": 130, "atk": 18, "def": 12, "spd": 7, "acc": 8, "luck": 3 }
	},
	Constants.SurvivorClass.LEADER: {
		"name": "Chỉ Huy",
		"base_stats": { "hp": 110, "atk": 14, "def": 10, "spd": 10, "acc": 12, "luck": 10 }
	}
}

static func get_all_adventurers() -> Array:
	return CharProfiles.get_all_adventurer_profiles()

static func generate_random_survivor(p_id: String = "") -> Dictionary:
	var id := p_id if not p_id.is_empty() else "surv_" + str(randi() % 1000)
	var profiles := get_all_adventurers()
	var prof: Dictionary = profiles[randi() % profiles.size()]
	
	return {
		"id": id,
		"name": prof.get("name", "Adventurer"),
		"class": randi() % 6,
		"traits": prof.get("traits", "Brute, Nimble"),
		"level": prof.get("level", 18),
		"exp": 0,
		"stats": {
			"hp": 100 + randi() % 50,
			"atk": 15 + randi() % 15,
			"def": 8 + randi() % 10,
			"spd": 10 + randi() % 8,
			"acc": 12,
			"luck": 5
		}
	}
