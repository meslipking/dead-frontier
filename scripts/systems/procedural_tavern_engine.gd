# ═══════════════════════════════════════════════════════════════
#  PROCEDURAL TAVERN ENGINE (procedural_tavern_engine.gd)
#  Động cơ Chiêu Mộ Anh Hùng Tân Binh Sinh Ngẫu Nhiên 100%
# ═══════════════════════════════════════════════════════════════
class_name ProceduralTavernEngine

static var FIRST_NAMES: Array[String] = [
	"Kaelen", "Valerie", "Brakkon", "Zeyra", "Darian", "Nyx",
	"Korr", "Talia", "Vornek", "Lyra", "Gideon", "Astra"
]

static var TITLE_SUFFIXES: Array[String] = [
	"Kẻ Phá Băng", "Thợ Săn Tàn Tích", "Vệ Binh Niken", "Bóng Ma Hư Không",
	"Thiện Xạ Bão Điện", "Chủ Xưởng Phim Plasma", "Sát Thủ Cuồng Phong"
]

static var RARITIES := [
	{ "tier": "ĐỒNG (COMMON)", "color": Color(0.7, 0.7, 0.7), "stat_mult": 1.0, "cost": 100 },
	{ "tier": "BẠC (RARE)", "color": Color(0.3, 0.7, 1.0), "stat_mult": 1.4, "cost": 200 },
	{ "tier": "VÀNG (EPIC)", "color": Color(0.95, 0.8, 0.25), "stat_mult": 1.8, "cost": 350 },
	{ "tier": "KIM CƯƠNG (LEGENDARY)", "color": Color(0.8, 0.4, 0.9), "stat_mult": 2.5, "cost": 600 },
	{ "tier": "THẦN THOẠI (MYTHIC)", "color": Color(1.0, 0.3, 0.3), "stat_mult": 3.5, "cost": 1000 }
]

static func generate_guest_recruits(count: int = 3) -> Array:
	var guests: Array = []
	for i in range(count):
		var seed_val: int = abs(randi() + i * 7919)
		
		var fname: String = FIRST_NAMES[seed_val % FIRST_NAMES.size()]
		var title: String = TITLE_SUFFIXES[(seed_val / 3) % TITLE_SUFFIXES.size()]
		var full_name := fname + " - " + title
		
		var rarity: Dictionary = RARITIES[(seed_val / 7) % RARITIES.size()]
		var lvl: int = (seed_val % 20) + 15
		
		var hp: int = int(350 * float(rarity["stat_mult"]) + (lvl * 25))
		var atk: int = int(85 * float(rarity["stat_mult"]) + (lvl * 8))
		var def: int = int(45 * float(rarity["stat_mult"]) + (lvl * 4))
		
		guests.append({
			"name": full_name,
			"level": lvl,
			"rarity_tier": rarity["tier"],
			"rarity_color": rarity["color"],
			"cost": rarity["cost"],
			"hp": hp,
			"atk": atk,
			"def": def,
			"traits": "Brute, " + str(rarity["tier"])
		})
		
	return guests
