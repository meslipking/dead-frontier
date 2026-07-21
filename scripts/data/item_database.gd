# ═══════════════════════════════════════════════════════════════
#  ITEM DATABASE (item_database.gd)
#  Quản lý danh mục Vũ khí, Giáp, Phụ kiện, Nguyên liệu & Mecha Parts
# ═══════════════════════════════════════════════════════════════
class_name ItemDatabase

const ITEMS := {
	# ─── Weapons ────────────────────────────────────────────────
	"wpn_rusty_pipe": {
		"id": "wpn_rusty_pipe", "name": "Ống sắt rỉ", "type": Constants.ItemType.WEAPON,
		"rarity": Constants.Rarity.COMMON, "stats": { "atk": 6 }, "description": "Vũ khí thô sơ nhặt được trong đống đổ nát."
	},
	"wpn_machete": {
		"id": "wpn_machete", "name": "Dao rựa sinh tồn", "type": Constants.ItemType.WEAPON,
		"rarity": Constants.Rarity.UNCOMMON, "stats": { "atk": 14, "spd": 2 }, "description": "Lưỡi sắc bén, chém zombie dễ dàng."
	},
	"wpn_combat_shotgun": {
		"id": "wpn_combat_shotgun", "name": "Súng săn chiến thuật", "type": Constants.ItemType.WEAPON,
		"rarity": Constants.Rarity.RARE, "stats": { "atk": 28, "acc": -2 }, "description": "Sát thương cận chiến cực lớn."
	},
	"wpn_plasma_blade": {
		"id": "wpn_plasma_blade", "name": "Kiếm Plasma", "type": Constants.ItemType.WEAPON,
		"rarity": Constants.Rarity.EPIC, "stats": { "atk": 50, "spd": 5 }, "description": "Lưỡi năng lượng cắt đứt mọi giáp sắt."
	},
	"wpn_death_railgun": {
		"id": "wpn_death_railgun", "name": "Súng Gauss Diệt Vong", "type": Constants.ItemType.WEAPON,
		"rarity": Constants.Rarity.LEGENDARY, "stats": { "atk": 95, "acc": 10 }, "description": "Bắn xuyên qua hàng loạt mục tiêu."
	},

	# ─── Armor ──────────────────────────────────────────────────
	"arm_leather_jacket": {
		"id": "arm_leather_jacket", "name": "Áo da rách", "type": Constants.ItemType.ARMOR,
		"rarity": Constants.Rarity.COMMON, "stats": { "def": 5, "hp": 15 }, "description": "Bảo vệ cơ bản khỏi vết cào zombie."
	},
	"arm_tactical_vest": {
		"id": "arm_tactical_vest", "name": "Áo giáp chống đạn", "type": Constants.ItemType.ARMOR,
		"rarity": Constants.Rarity.RARE, "stats": { "def": 18, "hp": 50 }, "description": "Giảm đáng kể sát thương vật lý."
	},
	"arm_hazmat_suit": {
		"id": "arm_hazmat_suit", "name": "Bộ Hazmat Độc Hóa", "type": Constants.ItemType.ARMOR,
		"rarity": Constants.Rarity.EPIC, "stats": { "def": 25, "hp": 80 }, "description": "Kháng sát thương Độc và Phóng xạ."
	},

	# ─── Accessories ───────────────────────────────────────────
	"acc_scout_radar": {
		"id": "acc_scout_radar", "name": "Radar Trinh Sát", "type": Constants.ItemType.ACCESSORY,
		"rarity": Constants.Rarity.UNCOMMON, "stats": { "acc": 8, "spd": 3 }, "description": "Phát hiện mục tiêu nhanh chóng."
	},
	"acc_mutant_pendant": {
		"id": "acc_mutant_pendant", "name": "Mặt Dây Chuyện Dị Năng", "type": Constants.ItemType.ACCESSORY,
		"rarity": Constants.Rarity.RARE, "stats": { "luck": 10, "hp": 30 }, "description": "Tăng tỷ lệ nhặt được đồ hiếm."
	},

	# ─── Materials ──────────────────────────────────────────────
	"mat_scrap_iron": {
		"id": "mat_scrap_iron", "name": "Phế liệu sắt", "type": Constants.ItemType.MATERIAL,
		"rarity": Constants.Rarity.COMMON, "description": "Nguyên liệu cơ bản để gia cố căn cứ và chế tạo vũ khí."
	},
	"mat_circuit_board": {
		"id": "mat_circuit_board", "name": "Mạch điện hỏng", "type": Constants.ItemType.MATERIAL,
		"rarity": Constants.Rarity.UNCOMMON, "description": "Linh kiện điện tử cho xưởng máy và bộ phận Mecha."
	},
	"mat_toxic_slime": {
		"id": "mat_toxic_slime", "name": "Dung dịch độc", "type": Constants.ItemType.MATERIAL,
		"rarity": Constants.Rarity.UNCOMMON, "description": "Chiết xuất từ quái vật cống ngầm, dùng nuôi quái hoặc ép vũ khí độc."
	},
	"mat_cool_alloy": {
		"id": "mat_cool_alloy", "name": "Hợp kim lạnh", "type": Constants.ItemType.MATERIAL,
		"rarity": Constants.Rarity.RARE, "description": "Hợp kim chịu nhiệt và độ bền cao cho giáp Mecha."
	},
	"mat_energy_core": {
		"id": "mat_energy_core", "name": "Lõi năng lượng", "type": Constants.ItemType.MATERIAL,
		"rarity": Constants.Rarity.EPIC, "description": "Nguồn năng lượng nạp cho Mecha và pháo đài."
	}
}

static func get_item(item_id: String) -> Dictionary:
	return ITEMS.get(item_id, {})
