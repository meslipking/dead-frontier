# ═══════════════════════════════════════════════════════════════
#  SIEGE DATABASE (siege_database.gd)
#  Định nghĩa 4 trận Vây hãm Boss hàng ngày (Daily Sieges)
# ═══════════════════════════════════════════════════════════════
class_name SiegeDatabase

const SIEGES := [
	{
		"id": "siege_zombie_horde",
		"name": "Bầy Zombie Đột Biến",
		"icon": "🧟",
		"description": "Làn sóng 100 zombie tràn qua hàng rào phòng thủ. Thử thách khả năng chịu đựng của đội hình.",
		"boss_name": "Zombie Khổng Lồ",
		"boss_stats": { "hp": 5000, "atk": 45, "def": 20, "spd": 8 }
	},
	{
		"id": "siege_titan_mecha",
		"name": "Titan Mecha Cổ Đại",
		"icon": "🤖",
		"description": "Robot chiến đấu mất kiểm soát với lớp giáp cực dày. Cần đạt lượng sát thương tối đa trong 3 phút.",
		"boss_name": "Titan Overlord",
		"boss_stats": { "hp": 15000, "atk": 70, "def": 60, "spd": 5 }
	},
	{
		"id": "siege_egg_mother",
		"name": "Mẹ Trứng Khổng Lồ",
		"icon": "🥚",
		"description": "Quái vật mẹ liên tục đẻ trứng zombie. Phải tiêu diệt trứng trước khi trứng nở.",
		"boss_name": "Tổ Mẹ Biến Dị",
		"boss_stats": { "hp": 8000, "atk": 50, "def": 30, "spd": 10 }
	},
	{
		"id": "siege_nuclear_beast",
		"name": "Quái Vật Hạt Nhân",
		"icon": "☢️",
		"description": "Quái vật mang năng lượng hạt nhân phát nổ khi xuống 30% máu. Cần tiêu diệt nhanh ở giai đoạn cuối.",
		"boss_name": "Behemoth Phóng Xạ",
		"boss_stats": { "hp": 12000, "atk": 85, "def": 40, "spd": 12 }
	}
]

static func get_all_sieges() -> Array:
	return SIEGES
