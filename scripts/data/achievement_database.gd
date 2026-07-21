# ═══════════════════════════════════════════════════════════════
#  ACHIEVEMENT DATABASE (achievement_database.gd)
#  Định nghĩa danh mục thành tựu in-game & Steam Achievements
# ═══════════════════════════════════════════════════════════════
class_name AchievementDatabase

const ACHIEVEMENTS := [
	{ "id": "ach_first_blood", "title": "Giọt Máu Đầu Tiên", "desc": "Tiêu diệt 1 zombie đầu tiên", "reward_gold": 100 },
	{ "id": "ach_survivor_squad", "title": "Đội Hình Sống Sót", "desc": "Sở hữu 4 người sống sót trong đội", "reward_gold": 250 },
	{ "id": "ach_monster_tamer", "title": "Kẻ Thu Phục", "desc": "Thu phục quái vật đầu tiên", "reward_gold": 300 },
	{ "id": "ach_mecha_builder", "title": "Thợ Máy Thiên Tài", "desc": "Lắp ráp robot Mecha đầu tiên", "reward_gold": 500 },
	{ "id": "ach_wasteland_explorer", "title": "Kẻ Khai Phá", "desc": "Mở khóa Vùng hoang thứ 3", "reward_gold": 400 },
	{ "id": "ach_blacksmith", "title": "Bậc Thầy Chế Tạo", "desc": "Chế tạo thành công 10 vật phẩm", "reward_gold": 350 },
	{ "id": "ach_apocalypse", "title": "Tận Thế Tái Sinh", "desc": "Kích hoạt Tận Thế Reset lần đầu tiên", "reward_crystals": 50 }
]

static func get_all() -> Array:
	return ACHIEVEMENTS

static func get_achievement(ach_id: String) -> Dictionary:
	for a in ACHIEVEMENTS:
		if a.get("id") == ach_id:
			return a
	return {}
