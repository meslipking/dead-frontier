# ═══════════════════════════════════════════════════════════════
#  EQUIPMENT SYSTEM (equipment_system.gd)
#  Quản lý trang bị/tháo đồ, tính toán bonus chỉ số & set bonus
# ═══════════════════════════════════════════════════════════════
class_name EquipmentSystem

static func equip_item(unit_id: String, item_data: Dictionary, slot: int) -> bool:
	var equipped: Dictionary = GameManager.game_data.get("equipped_items", {})
	if not equipped.has(unit_id):
		equipped[unit_id] = {}
		
	var unit_equip: Dictionary = equipped[unit_id]
	# Unequip existing if present
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
	for slot in unit_equip:
		var item: Dictionary = unit_equip[slot]
		var item_stats: Dictionary = item.get("stats", {})
		for stat_key in item_stats:
			total_stats[stat_key] = total_stats.get(stat_key, 0) + item_stats[stat_key]
			
	return total_stats
