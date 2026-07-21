# ═══════════════════════════════════════════════════════════════
#  PROCEDURAL STAGE GENERATOR (procedural_stage_generator.gd) — Lore & CP Aligned
#  Động cơ Sinh Ải Thám Hiểm Theo Chương & Quy Định Sức Mạnh Lực Chiến (Recommended CP)
# ═══════════════════════════════════════════════════════════════
class_name ProceduralStageGenerator

const BannerGen = preload("res://scripts/utils/pixel_art/landscape_banner_generator.gd")

static var CHAPTERS := [
	{ "chapter": 1, "name": "Barren Wastelands (Vùng Đất Chết Nitro)", "base_cp": 150 },
	{ "chapter": 2, "name": "The Southern Grove (Rừng Cổ Thụ)", "base_cp": 450 },
	{ "chapter": 3, "name": "Obsidian Mines (Mỏ Thạch Anh Đen)", "base_cp": 900 },
	{ "chapter": 4, "name": "Ancient Crypt (Hầm Mộ Cổ Văn Minh)", "base_cp": 1500 },
	{ "chapter": 5, "name": "Dreadnought Spire (Pháo Đài Hư Không)", "base_cp": 2500 },
	{ "chapter": 6, "name": "Voltrun Electric City (Thành Phố Bão Điện)", "base_cp": 4000 }
]

static var MODIFIERS := [
	{ "name": "Bức Xạ Điện Từ", "effect": "+50% Sát Thương Chí Mạng", "color": Color(0.95, 0.8, 0.25) },
	{ "name": "Không Trọng Lượng", "effect": "+100% Tốc Độ Đánh", "color": Color(0.2, 0.85, 1.0) },
	{ "name": "Bão Tuyết Bão Âm", "effect": "-30% Tốc Độ Di Chuyển Quái", "color": Color(0.4, 0.75, 0.95) },
	{ "name": "Sương Độc Axit", "effect": "Rút 2% HP Môi Trường/Giây", "color": Color(0.3, 0.9, 0.4) }
]

static func generate_stage_data(stage_num: int) -> Dictionary:
	var seed_val: int = abs(stage_num * 997 + 101)
	
	var chap_idx: int = min((stage_num - 1) / 5, CHAPTERS.size() - 1)
	var chap_info: Dictionary = CHAPTERS[chap_idx]
	
	var env_name: String = str(chap_info["name"])
	var recommended_cp: int = int(chap_info["base_cp"]) + ((stage_num - 1) % 5) * 50
	
	var mod: Dictionary = MODIFIERS[(seed_val / 3) % MODIFIERS.size()]
	var monster_count: int = (seed_val % 8) + 5
	var boss_present: bool = (stage_num % 5 == 0)
	
	var banner_tex: ImageTexture = BannerGen.create_landscape_banner(env_name, 320, 110)
	
	return {
		"stage_num": stage_num,
		"chapter_num": chap_info["chapter"],
		"title": "CHƯƠNG " + str(chap_info["chapter"]) + " - ẢI " + str(stage_num) + ": " + env_name.to_upper(),
		"env_name": env_name,
		"recommended_cp": recommended_cp,
		"modifier_name": mod["name"],
		"modifier_effect": mod["effect"],
		"modifier_color": mod["color"],
		"monster_count": monster_count,
		"has_boss": boss_present,
		"banner_tex": banner_tex
	}
