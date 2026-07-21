# ═══════════════════════════════════════════════════════════════
#  SURVIVOR DATABASE (survivor_database.gd)
#  Quản lý định nghĩa class, traits, và khởi tạo Survivor units
# ═══════════════════════════════════════════════════════════════
class_name SurvivorDatabase

const CLASS_DATA := {
	Constants.SurvivorClass.SCOUT: {
		"name": "Trinh sát",
		"icon": "⚡",
		"description": "Nhanh nhẹn, né tránh tốt, thu thập tài nguyên nhanh hơn 20%.",
		"base_stats": { "hp": 100, "atk": 15, "def": 8, "spd": 15, "acc": 12, "luck": 10 },
		"growth": { "hp": 10, "atk": 2.2, "def": 1.1, "spd": 1.5, "acc": 1.2, "luck": 0.8 }
	},
	Constants.SurvivorClass.MEDIC: {
		"name": "Y tá",
		"icon": "❤️",
		"description": "Hồi phục HP cho đồng đội, giảm 15% khả năng tử vong.",
		"base_stats": { "hp": 90, "atk": 10, "def": 7, "spd": 11, "acc": 14, "luck": 8 },
		"growth": { "hp": 9, "atk": 1.5, "def": 1.0, "spd": 1.1, "acc": 1.4, "luck": 0.7 }
	},
	Constants.SurvivorClass.ENGINEER: {
		"name": "Kỹ sư",
		"icon": "⚙️",
		"description": "Tăng 25% sát thương khi lái Mecha, sửa chữa robot trong trận.",
		"base_stats": { "hp": 110, "atk": 12, "def": 10, "spd": 9, "acc": 11, "luck": 5 },
		"growth": { "hp": 12, "atk": 1.8, "def": 1.5, "spd": 0.9, "acc": 1.1, "luck": 0.5 }
	},
	Constants.SurvivorClass.SNIPER: {
		"name": "Xạ thủ",
		"icon": "🎯",
		"description": "Sát thương chí mạng cao, tấn công từ xa nguy hiểm.",
		"base_stats": { "hp": 80, "atk": 22, "def": 5, "spd": 10, "acc": 18, "luck": 7 },
		"growth": { "hp": 7, "atk": 3.0, "def": 0.8, "spd": 1.0, "acc": 1.8, "luck": 0.7 }
	},
	Constants.SurvivorClass.BRAWLER: {
		"name": "Đấu sĩ",
		"icon": "🛡️",
		"description": "Lượng máu và phòng thủ khủng, thu hút đòn đánh địch.",
		"base_stats": { "hp": 150, "atk": 16, "def": 14, "spd": 7, "acc": 9, "luck": 4 },
		"growth": { "hp": 18, "atk": 2.0, "def": 2.0, "spd": 0.7, "acc": 0.9, "luck": 0.4 }
	},
	Constants.SurvivorClass.LEADER: {
		"name": "Thủ lĩnh",
		"icon": "👑",
		"description": "Tăng 10% tất cả chỉ số cho toàn bộ đội hình.",
		"base_stats": { "hp": 120, "atk": 14, "def": 11, "spd": 11, "acc": 13, "luck": 12 },
		"growth": { "hp": 13, "atk": 2.1, "def": 1.4, "spd": 1.1, "acc": 1.3, "luck": 1.0 }
	}
}

const TRAITS := {
	"tough": { "name": "Cứng cỏi", "desc": "+10% Máu tối đa" },
	"careful": { "name": "Cẩn trọng", "desc": "+5% Tỷ lệ né tránh" },
	"strong": { "name": "Khỏe mạnh", "desc": "+8% Tấn công" },
	"eagle_eye": { "name": "Mắt diều hâu", "desc": "+10% Chính xác" },
	"lucky": { "name": "May mắn", "desc": "+10% May mắn, tăng tỷ lệ nhặt đồ" },
	"mechanic": { "name": "Thợ máy", "desc": "+15% Hiệu quả Mecha" },
	"beast_whisperer": { "name": "Thì thầm thú", "desc": "+10% Tỷ lệ bắt quái vật" },
	"lone_wolf": { "name": "Sói đơn độc", "desc": "+15% Tấn công khi đi 1 mình" },
}

const FIRST_NAMES := ["Minh", "Hương", "Đức", "Lan", "Hùng", "Trang", "Phong", "Vy", "Tuấn", "Linh", "Sơn", "Mai"]
const LAST_NAMES := ["Nguyễn", "Trần", "Lê", "Phạm", "Hoàng", "Phan", "Vũ", "Đặng", "Bùi", "Đỗ"]

static func generate_random_survivor(id_suffix: String = "", prng = null) -> Dictionary:
	if id_suffix.is_empty():
		id_suffix = str(randi() % 10000)
		
	var fname: String
	var lname: String
	var surv_class: int
	
	if prng != null:
		fname = prng.pick(FIRST_NAMES)
		lname = prng.pick(LAST_NAMES)
		surv_class = prng.next_int(0, 5)
	else:
		fname = FIRST_NAMES[randi() % FIRST_NAMES.size()]
		lname = LAST_NAMES[randi() % LAST_NAMES.size()]
		surv_class = randi() % 6
		
	var class_info: Dictionary = CLASS_DATA[surv_class]
	var base_s: Dictionary = class_info["base_stats"]
	
	var trait_keys := TRAITS.keys()
	var selected_trait: String = trait_keys[randi() % trait_keys.size()]
	
	return {
		"id": "surv_" + id_suffix,
		"name": lname + " " + fname,
		"class": surv_class,
		"class_name": class_info["name"],
		"level": 1,
		"exp": 0,
		"traits": [selected_trait],
		"stats": base_s.duplicate()
	}
