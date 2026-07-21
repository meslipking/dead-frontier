# ═══════════════════════════════════════════════════════════════
#  DYNAMIC ITEM GENERATOR (dynamic_item_generator.gd)
#  Động cơ Sinh Trang Bị Tiền Tố (Prefix) & Hậu Tố (Suffix) Ngẫu Nhiên 100%
# ═══════════════════════════════════════════════════════════════
class_name DynamicItemGenerator

static var PREFIXES: Array[String] = [
	"Siêu Siêu Nạp", "Cuồng Bão", "Dạ Quang", "Bức Xạ",
	"Hàn Băng", "Niken Cổ", "Bão Điện", "Hư Không"
]

static var BASE_WEAPONS: Array[String] = [
	"Súng Plasma", "Thang Cưa Máy", "Pháo Railgun",
	"Kiếm Năng Lượng", "Súng Ngắm Laser", "Súng Săn Shotgun"
]

static var SUFFIXES: Array[String] = [
	"của Phượng Hoàng", "của Titan", "của Bóng Ma", "của Thần Sấm",
	"của Rồng Đen", "của Quái Vật", "của Kẻ Diệt Zombie"
]

static func generate_procedural_item(level: int = 1) -> Dictionary:
	var seed_val: int = abs(randi() + level * 9973)
	
	var pref: String = PREFIXES[seed_val % PREFIXES.size()]
	var base_wpn: String = BASE_WEAPONS[(seed_val / 3) % BASE_WEAPONS.size()]
	var suff: String = SUFFIXES[(seed_val / 7) % SUFFIXES.size()]
	
	var item_name := pref + " " + base_wpn + " " + suff
	var bonus_atk: int = level * 35 + (seed_val % 50) + 100
	var bonus_crit: float = float(seed_val % 25) + 5.0
	
	return {
		"name": item_name,
		"base_type": base_wpn,
		"level": level,
		"atk": bonus_atk,
		"crit_rate": bonus_crit,
		"quality": "LEGENDARY"
	}
