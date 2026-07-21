# ═══════════════════════════════════════════════════════════════
#  EQUIPMENT SYSTEM (equipment_system.gd)
#  Quản lý trang bị/tháo đồ, tính toán bonus chỉ số & Set Bonuses (2p/4p)
# ═══════════════════════════════════════════════════════════════
class_name EquipmentSystem

# ─── Set Bonus Definitions ───────────────────────────────────
const SET_BONUSES := {
	"scout_set": {
		"name": "Bộ Trinh Sát",
		"2p_bonus": { "spd": 5, "acc": 5 },
		"4p_bonus": { "spd": 15, "luck": 10 }
	},
	"hazmat_set": {
		"name": "Bộ Độc Hóa",
		"2p_bonus": { "def": 10, "hp": 30 },
		"4p_bonus": { "def": 25, "hp": 100 }
	},
	"plasma_set": {
		"name": "Bộ Plasma",
		"2p_bonus": { "atk": 15 },
		"4p_bonus": { "atk": 40, "acc": 10 }
	}
}

static func equip_item(unit_id: String, item_data: Dictionary, slot: int) -> bool:
	var equipped: Dictionary = GameManager.game_data.get("equipped_items", {})
	if not equipped.has(unit_id):
		equipped[unit_id] = {}
		
	var unit_equip: Dictionary = equipped[unit_id]
	if unit_equip.has(slot):
		unequip_item(unit_id, slot)
		
	unit_equip[slot] = item_data
	GameManager.game_data["equipped_items"] = equipped
	EventBus.item_equipped.emit(unit_id, item_data.get("id", ""), slot)
	return true

static func unequip_item(unit_id: String, slot: int) -> bool:
	var equipped: Dictionary = GameManager.game_data.get("equipped_items", {})
	if not equipped.has(unit_id) or not equipped[unit_id].has(slot):
		return false
		
	var item: Dictionary = equipped[unit_id][slot]
	InventorySystem.add_item(item)
	equipped[unit_id].erase(slot)
	GameManager.game_data["equipped_items"] = equipped
	EventBus.item_unequipped.emit(unit_id, slot)
	return true

static func get_total_equipment_stats(unit_id: String) -> Dictionary:
	var total_stats := { "hp": 0, "atk": 0, "def": 0, "spd": 0, "acc": 0, "luck": 0 }
	var equipped: Dictionary = GameManager.game_data.get("equipped_items", {})
	if not equipped.has(unit_id):
		return total_stats
		
	var unit_equip: Dictionary = equipped[unit_id]
	var set_counts := {}
	
	for slot in unit_equip:
		var item: Dictionary = unit_equip[slot]
		var item_stats: Dictionary = item.get("stats", {})
		for stat_key in item_stats:
			total_stats[stat_key] = total_stats.get(stat_key, 0) + item_stats[stat_key]
			
		var set_id: String = item.get("set_id", "")
		if not set_id.is_empty():
			set_counts[set_id] = set_counts.get(set_id, 0) + 1
			
	# Apply 2p and 4p set bonuses
	for set_id in set_counts:
		if SET_BONUSES.has(set_id):
			var count: int = set_counts[set_id]
			var s_def: Dictionary = SET_BONUSES[set_id]
			if count >= 2 and s_def.has("2p_bonus"):
				for k in s_def["2p_bonus"]:
					total_stats[k] = total_stats.get(k, 0) + s_def["2p_bonus"][k]
			if count >= 4 and s_def.has("4p_bonus"):
				for k in s_def["4p_bonus"]:
					total_stats[k] = total_stats.get(k, 0) + s_def["4p_bonus"][k]
					
	return total_stats
