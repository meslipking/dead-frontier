# ═══════════════════════════════════════════════════════════════
#  SKILL LIBRARY (skill_library.gd) — Commercial RPG Skill Engine
#  Thư viện Kỹ năng Chủ động (Active) & Bị động (Passive) kiểu FlipFight
# ═══════════════════════════════════════════════════════════════
class_name SkillLibrary

const SKILLS := {
	"skill_fire_slash": {
		"name": "Chém Lửa Tận Thế",
		"icon": "🔥",
		"type": "active",
		"target": "single_enemy",
		"cooldown": 3,
		"multiplier": 1.8,
		"element": Constants.Element.FIRE,
		"effect": "burn",
		"desc": "Gây 180% sát thương Lửa và thiêu đốt kẻ địch trong 2 lượt."
	},
	"skill_plasma_beam": {
		"name": "Chùm Tia Plasma",
		"icon": "⚡",
		"type": "active",
		"target": "all_enemies",
		"cooldown": 4,
		"multiplier": 1.4,
		"element": Constants.Element.ELECTRIC,
		"effect": "stun",
		"desc": "Gây 140% sát thương Điện lên toàn bộ kẻ địch và 25% làm choáng."
	},
	"skill_toxic_cloud": {
		"name": "Mây Độc Phóng Xạ",
		"icon": "☣️",
		"type": "active",
		"target": "all_enemies",
		"cooldown": 4,
		"multiplier": 1.2,
		"element": Constants.Element.POISON,
		"effect": "poison",
		"desc": "Gây 120% sát thương Độc và giảm 20% phòng thủ kẻ địch."
	},
	"skill_frost_nova": {
		"name": "Băng Giá Tuyệt Đối",
		"icon": "❄️",
		"type": "active",
		"target": "all_enemies",
		"cooldown": 4,
		"multiplier": 1.3,
		"element": Constants.Element.ICE,
		"effect": "freeze",
		"desc": "Gây 130% sát thương Băng và đóng băng kẻ địch 1 lượt."
	},
	"skill_heal_pulse": {
		"name": "Sóng Hồi Phục",
		"icon": "❤️",
		"type": "active",
		"target": "all_allies",
		"cooldown": 3,
		"multiplier": 1.5,
		"element": Constants.Element.NONE,
		"effect": "heal",
		"desc": "Hồi phục 150% ATK Máu cho toàn bộ đồng đội trong đội hình."
	},
	"skill_titan_shield": {
		"name": "Lá Chắn Titan",
		"icon": "🛡️",
		"type": "passive",
		"target": "self",
		"cooldown": 0,
		"multiplier": 1.0,
		"element": Constants.Element.NONE,
		"effect": "buff_def",
		"desc": "Bị động: Tăng 25% Phòng thủ tối đa và giảm 10% sát thương nhận vào."
	}
}

static func get_skill(skill_id: String) -> Dictionary:
	return SKILLS.get(skill_id, {})

static func get_all_skills() -> Array:
	return SKILLS.values()
