# ═══════════════════════════════════════════════════════════════
#  MONSTER DATABASE (monster_database.gd)
#  Định nghĩa 10 loài quái vật cơ bản, chuỗi tiến hóa 5 cấp & kỹ năng
# ═══════════════════════════════════════════════════════════════
class_name MonsterDatabase

const SPECIES := {
	"flame_hound": {
		"id": "flame_hound", "name": "Chó Lửa", "element": Constants.Element.FIRE,
		"base_stats": { "hp": 110, "atk": 18, "def": 8, "spd": 14, "acc": 12, "luck": 8 },
		"growth": { "hp": 12, "atk": 2.5, "def": 1.0, "spd": 1.4, "acc": 1.0, "luck": 0.8 },
		"capture_rate": 0.50,
		"evolution": ["flame_hound_baby", "flame_hound_pup", "flame_hound_adult", "flame_hound_elder", "flame_hound_apex"],
		"description": "Quái vật mang ngọn lửa địa ngục. Tấn công nhanh và gây bỏng."
	},
	"ice_beetle": {
		"id": "ice_beetle", "name": "Bọ Băng", "element": Constants.Element.ICE,
		"base_stats": { "hp": 140, "atk": 12, "def": 16, "spd": 8, "acc": 10, "luck": 5 },
		"growth": { "hp": 15, "atk": 1.6, "def": 2.2, "spd": 0.8, "acc": 0.9, "luck": 0.5 },
		"capture_rate": 0.45,
		"evolution": ["ice_beetle_larva", "ice_beetle_nymph", "ice_beetle_adult", "ice_beetle_elder", "ice_beetle_apex"],
		"description": "Lớp vỏ băng cứng như thép. Có khả năng đóng băng kẻ địch."
	},
	"toxic_scorpion": {
		"id": "toxic_scorpion", "name": "Bọ Cạp Độc", "element": Constants.Element.POISON,
		"base_stats": { "hp": 95, "atk": 20, "def": 10, "spd": 13, "acc": 15, "luck": 10 },
		"growth": { "hp": 10, "atk": 2.8, "def": 1.2, "spd": 1.3, "acc": 1.4, "luck": 1.0 },
		"capture_rate": 0.40,
		"evolution": ["scorpio_hatchling", "scorpio_scout", "scorpio_stalker", "scorpio_tyrant", "scorpio_apex"],
		"description": "Nọc độc làm suy yếu phòng thủ kẻ địch liên tục."
	},
	"volt_rat": {
		"id": "volt_rat", "name": "Chuột Sét", "element": Constants.Element.ELECTRIC,
		"base_stats": { "hp": 85, "atk": 16, "def": 6, "spd": 18, "acc": 14, "luck": 12 },
		"growth": { "hp": 8, "atk": 2.2, "def": 0.8, "spd": 1.8, "acc": 1.3, "luck": 1.2 },
		"capture_rate": 0.55,
		"evolution": ["volt_pup", "volt_spark", "volt_storm", "volt_lord", "volt_apex"],
		"description": "Di chuyển chớp nhoáng, có thể gây tê liệt làm gián đoạn lượt đánh."
	},
	"shadow_bat": {
		"id": "shadow_bat", "name": "Dơi Bóng Tối", "element": Constants.Element.SHADOW,
		"base_stats": { "hp": 90, "atk": 17, "def": 7, "spd": 16, "acc": 13, "luck": 15 },
		"growth": { "hp": 9, "atk": 2.4, "def": 0.9, "spd": 1.6, "acc": 1.2, "luck": 1.5 },
		"capture_rate": 0.35,
		"evolution": ["shadow_chick", "shadow_vampire", "shadow_reaper", "shadow_overlord", "shadow_apex"],
		"description": "Hút máu kẻ địch để hồi phục HP cho bản thân."
	}
}

static func get_species(species_id: String) -> Dictionary:
	return SPECIES.get(species_id, {})
