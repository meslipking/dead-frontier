# ═══════════════════════════════════════════════════════════════
#  FLIPFIGHT SKILL LIBRARY (flipfight_skill_library.gd) — 15 Elemental Spells
#  Chứa 15 Kỹ Năng Nguyên Tố Đạn Đạo, Tên Lửa Bão, Cầu Lửa AOE & Hồi HP
# ═══════════════════════════════════════════════════════════════
class_name FlipfightSkillLibrary

static var SKILLS := {
	"fireball": { "name": "Fireball AOE", "element": "Lửa", "color": Color(0.95, 0.35, 0.1), "dmg_mult": 1.8 },
	"magic_missile": { "name": "Magic Missile", "element": "Sét", "color": Color(0.2, 0.85, 1.0), "dmg_mult": 1.4 },
	"piercing_arrow": { "name": "Piercing Arrow", "element": "Độc", "color": Color(0.3, 0.9, 0.4), "dmg_mult": 1.5 },
	"shuriken_shatter": { "name": "Shuriken Shatter", "element": "Băng", "color": Color(0.7, 0.3, 0.85), "dmg_mult": 2.2 },
	"bio_healing": { "name": "Bio Healing Wave", "element": "Độc", "color": Color(0.3, 0.9, 0.5), "dmg_mult": 0.0, "heal": 250 },
	"holy_sanctuary": { "name": "Holy Sanctuary", "element": "Thánh", "color": Color(0.95, 0.85, 0.25), "dmg_mult": 0.0, "shield": 400 },
	"plasma_cut": { "name": "Plasma Flash Cut", "element": "Lửa", "color": Color(0.2, 0.85, 1.0), "dmg_mult": 2.5 },
	"chain_lightning": { "name": "Chain Lightning", "element": "Sét", "color": Color(0.95, 0.95, 0.3), "dmg_mult": 1.7 },
	"toxic_cloud": { "name": "Toxic Cloud", "element": "Độc", "color": Color(0.2, 0.7, 0.3), "dmg_mult": 1.3 },
	"freezing_nova": { "name": "Freezing Nova", "element": "Băng", "color": Color(0.4, 0.75, 0.95), "dmg_mult": 1.6 }
}

static func get_skill_info(skill_id: String) -> Dictionary:
	return SKILLS.get(skill_id, SKILLS["fireball"])
