# ═══════════════════════════════════════════════════════════════
#  PROCEDURAL STAGE GENERATOR (procedural_stage_generator.gd)
#  Động cơ Sinh Ải Thám Hiểm Vô Hạn từ Stage 1-1 đến 999-99
#  Tự Động Sinh Bìa Phong Cảnh Pixel Art 16-Bit & Modifiers Môi Trường
# ═══════════════════════════════════════════════════════════════
class_name ProceduralStageGenerator

const BannerGen = preload("res://scripts/utils/pixel_art/landscape_banner_generator.gd")

static var ENVIRONMENT_TYPES := [
	"Mỏ Thạch Anh Đen Obsidian",
	"Rừng Cổ Thụ Southern Grove",
	"Vùng Đất Chết Hoang Tàn Nitro",
	"Hầm Mộ Cổ Nền Văn Minh Cổ",
	"Pháo Đài Hư Không Tháp Đài",
	"Xưởng Cơ Khí Niken Quên Lãng",
	"Phòng Thí Nghiệm Sinh Học Bio-Sector 7",
	"Thành Phố Bão Điện Voltrun"
]

static var MODIFIERS := [
	{ "name": "Bức Xạ Điện Từ", "effect": "+50% Sát Thương Chí Mạng", "color": Color(0.95, 0.8, 0.25) },
	{ "name": "Không Trọng Lượng", "effect": "+100% Tốc Độ Đánh", "color": Color(0.2, 0.85, 1.0) },
	{ "name": "Bão Tuyết Bão Âm", "effect": "-30% Tốc Độ Di Chuyển Quái", "color": Color(0.4, 0.75, 0.95) },
	{ "name": "Sương Độc Axit", "effect": "Rút 2% HP Môi Trường/Giây", "color": Color(0.3, 0.9, 0.4) }
]

static func generate_stage_data(stage_num: int) -> Dictionary:
	var seed_val: int = abs(stage_num * 997 + 101)
	
	var env_name: String = ENVIRONMENT_TYPES[seed_val % ENVIRONMENT_TYPES.size()]
	var mod: Dictionary = MODIFIERS[(seed_val / 3) % MODIFIERS.size()]
	
	var monster_count: int = (seed_val % 8) + 5
	var boss_present: bool = (stage_num % 5 == 0)
	
	var banner_tex: ImageTexture = BannerGen.create_landscape_banner(env_name, 320, 110)
	
	return {
		"stage_num": stage_num,
		"title": "ẢI " + str(stage_num) + ": " + env_name.to_upper(),
		"env_name": env_name,
		"modifier_name": mod["name"],
		"modifier_effect": mod["effect"],
		"modifier_color": mod["color"],
		"monster_count": monster_count,
		"has_boss": boss_present,
		"banner_tex": banner_tex
	}
