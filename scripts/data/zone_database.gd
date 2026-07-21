# ═══════════════════════════════════════════════════════════════
#  ZONE DATABASE (zone_database.gd)
#  Quản lý danh sách 7 Vùng hoang (Wasteland zones), kẻ địch & loot
# ═══════════════════════════════════════════════════════════════
class_name ZoneDatabase

const ZONES := {
	"ruined_suburbs": {
		"id": "ruined_suburbs",
		"name": "Ngoại ô hoang tàn",
		"difficulty": 1,
		"description": "Khu vực ngoại ô bị tàn phá sau đợt bùng phát dịch bệnh. Nơi tập trung zombie thông thường và tài nguyên cơ bản.",
		"bg_color": Color(0.18, 0.15, 0.12),
		"sectors_count": 10,
		"enemy_pool": ["zombie_walker", "zombie_runner", "mutant_dog"],
		"loot_table": [
			{ "item_id": "mat_scrap_iron", "chance": 0.6 },
			{ "item_id": "mat_cloth", "chance": 0.5 },
			{ "item_id": "wpn_rusty_pipe", "chance": 0.1 }
		],
		"unlock_req": ""
	},
	"toxic_sewers": {
		"id": "toxic_sewers",
		"name": "Cống ngầm độc",
		"difficulty": 2,
		"description": "Hệ thống cống ngầm tràn ngập hóa chất độc hại. Nơi sinh sống của các loài biến dị hệ Độc.",
		"bg_color": Color(0.10, 0.20, 0.12),
		"sectors_count": 12,
		"enemy_pool": ["toxic_crawler", "acid_spitter", "giant_rat"],
		"loot_table": [
			{ "item_id": "mat_toxic_slime", "chance": 0.6 },
			{ "item_id": "mat_circuit_board", "chance": 0.4 },
			{ "item_id": "arm_hazmat_suit", "chance": 0.08 }
		],
		"unlock_req": "Clear Zone 1 Sector 5"
	},
	"abandoned_factory": {
		"id": "abandoned_factory",
		"name": "Nhà máy bỏ hoang",
		"difficulty": 3,
		"description": "Nhà máy chế tạo robot cũ bị zombie chiếm giữ. Chứa nhiều phế liệu kim loại và linh kiện Mecha.",
		"bg_color": Color(0.15, 0.17, 0.22),
		"sectors_count": 15,
		"enemy_pool": ["rogue_drone", "mecha_zombie", "iron_golem"],
		"loot_table": [
			{ "item_id": "mat_cool_alloy", "chance": 0.5 },
			{ "item_id": "mat_energy_core", "chance": 0.3 },
			{ "item_id": "mecha_scout_arm", "chance": 0.05 }
		],
		"unlock_req": "Clear Zone 2 Sector 8"
	},
	"frozen_port": {
		"id": "frozen_port",
		"name": "Cảng đóng băng",
		"difficulty": 4,
		"description": "Cảng biển bị mây tuyết bao phủ vĩnh viễn. Quái vật hệ Băng hung hãn trú ngụ ở đây.",
		"bg_color": Color(0.12, 0.22, 0.30),
		"sectors_count": 18,
		"enemy_pool": ["ice_beetle", "frost_wolf", "frozen_mutant"],
		"loot_table": [
			{ "item_id": "mat_frost_crystal", "chance": 0.5 },
			{ "item_id": "wpn_ice_blade", "chance": 0.08 }
		],
		"unlock_req": "Clear Zone 3 Sector 10"
	},
	"nuclear_crater": {
		"id": "nuclear_crater",
		"name": "Hố bom hạt nhân",
		"difficulty": 5,
		"description": "Trung tâm điểm nổ hạt nhân với phóng xạ cực cao. Sinh vật tại đây có sức mạnh biến dị cực đại.",
		"bg_color": Color(0.25, 0.12, 0.20),
		"sectors_count": 20,
		"enemy_pool": ["rad_ghoul", "plague_titan", "nightmare_beast"],
		"loot_table": [
			{ "item_id": "mat_nuclear_shard", "chance": 0.4 },
			{ "item_id": "wpn_plasma_rifle", "chance": 0.04 }
		],
		"unlock_req": "Clear Zone 4 Sector 12"
	},
	"zombie_hive": {
		"id": "zombie_hive",
		"name": "Tổ zombie",
		"difficulty": 6,
		"description": "Hang ổ khổng lồ của chúa tể zombie. Thử thách kinh hoàng nhất cho các đội hình sống sót.",
		"bg_color": Color(0.28, 0.08, 0.10),
		"sectors_count": 25,
		"enemy_pool": ["hive_guard", "hive_mind", "abomination"],
		"loot_table": [
			{ "item_id": "mat_apex_dna", "chance": 0.3 },
			{ "item_id": "arm_titan_plate", "chance": 0.03 }
		],
		"unlock_req": "Clear Zone 5 Sector 15"
	},
	"cloud_fortress": {
		"id": "cloud_fortress",
		"name": "Pháo đài trên mây",
		"difficulty": 6,
		"description": "Pháo đài quân sự tự động ở độ cao 3000m. Chứa các bản thiết kế Mecha huyền thoại.",
		"bg_color": Color(0.18, 0.25, 0.28),
		"sectors_count": 30,
		"enemy_pool": ["fortress_ai", "apex_mecha", "sky_guardian"],
		"loot_table": [
			{ "item_id": "mat_quantum_core", "chance": 0.2 },
			{ "item_id": "mecha_apex_blueprint", "chance": 0.02 }
		],
		"unlock_req": "Clear Zone 6 Sector 20"
	}
}

static func get_zone(zone_id: String) -> Dictionary:
	return ZONES.get(zone_id, {})

static func get_all_zones() -> Array:
	var list := []
	var keys := ["ruined_suburbs", "toxic_sewers", "abandoned_factory", "frozen_port", "nuclear_crater", "zombie_hive", "cloud_fortress"]
	for k in keys:
		if ZONES.has(k):
			list.append(ZONES[k])
	return list
