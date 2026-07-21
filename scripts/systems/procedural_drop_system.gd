# ═══════════════════════════════════════════════════════════════
#  PROCEDURAL DROP SYSTEM (procedural_drop_system.gd)
#  Tính Toán Vật Phẩm Rơi Ngẫu Nhiên theo Hệ Sinh Thái Ải
# ═══════════════════════════════════════════════════════════════
class_name ProceduralDropSystem

static var THEMED_DROPS := {
	"Obsidian": ["Lõi Magma Nóng Chảy", "Quặng Obsidian Tối", "Thạch Anh Đen"],
	"Grove": ["Nấm Đột Biến Dạ Quang", "Gỗ Cổ Thụ Niken", "Hạt Giống Sinh Học"],
	"Nitro": ["Phế Liệu Xe Tải", "Bình Axit Đậm Đặc", "Lõi Xăng Nitro"],
	"Dreadnought": ["Mảnh Plasma Hư Không", "Mạch Điện Cổ", "Đá Hư Không"]
}

static func calculate_stage_rewards(env_name: String, stage_level: int) -> Dictionary:
	var seed_val: int = abs(stage_level * 313 + env_name.hash())
	
	var gold_reward: int = stage_level * 50 + (seed_val % 100)
	var alloy_reward: int = stage_level * 20 + (seed_val % 40)
	var energy_reward: int = stage_level * 30 + (seed_val % 60)
	
	var drop_category := "Obsidian"
	if env_name.contains("Grove"): drop_category = "Grove"
	elif env_name.contains("Nitro"): drop_category = "Nitro"
	elif env_name.contains("Hư Không"): drop_category = "Dreadnought"
	
	var possible_items: Array = THEMED_DROPS.get(drop_category, THEMED_DROPS["Obsidian"])
	var dropped_item: String = str(possible_items[seed_val % possible_items.size()])
	
	return {
		"gold": gold_reward,
		"alloys": alloy_reward,
		"energy": energy_reward,
		"special_material": dropped_item,
		"material_count": (seed_val % 5) + 1
	}
