# ═══════════════════════════════════════════════════════════════
#  EQUIPMENT FORGE (equipment_forge.gd) — Blacksmith System
#  Rèn trang bị, cường hóa +1 đến +10 & tháo rỡ phế liệu kiểu FlipFight
# ═══════════════════════════════════════════════════════════════
class_name EquipmentForge

const InvSys = preload("res://scripts/systems/inventory_system.gd")
const ItemDb = preload("res://scripts/data/item_database.gd")

static func get_upgrade_cost(item: Dictionary) -> int:
	var lvl: int = item.get("upgrade_level", 0)
	return (lvl + 1) * 50

static func upgrade_equipment(item: Dictionary) -> Dictionary:
	var current_lvl: int = item.get("upgrade_level", 0)
	if current_lvl >= Constants.MAX_EQUIPMENT_UPGRADE:
		return { "success": false, "reason": "Đã đạt cấp cường hóa tối đa (+10)!" }
		
	var cost := get_upgrade_cost(item)
	if not GameManager.spend_currency(Constants.Currency.GOLD, cost):
		return { "success": false, "reason": "Không đủ Vàng để cường hóa!" }
		
	var success_chance: float = max(1.0 - float(current_lvl) * 0.08, 0.3)
	if randf() <= success_chance:
		item["upgrade_level"] = current_lvl + 1
		var stats: Dictionary = item.get("stats", {})
		for k in stats:
			stats[k] = int(round(stats[k] * 1.10))
		item["stats"] = stats
		print("[EquipmentForge] UPGRADE SUCCESS! New level: +", item["upgrade_level"])
		return { "success": true, "new_level": item["upgrade_level"], "item": item }
	else:
		print("[EquipmentForge] UPGRADE FAILED!")
		return { "success": false, "reason": "Cường hóa thất bại!" }

static func dismantle_equipment(item: Dictionary) -> Dictionary:
	var inv: Array = GameManager.get_inventory()
	inv.erase(item)
	
	var gold_refund: int = 25 + int(item.get("upgrade_level", 0)) * 20
	GameManager.add_currency(Constants.Currency.GOLD, gold_refund)
	
	var scrap_item: Dictionary = ItemDb.get_item("mat_scrap_iron")
	if not scrap_item.is_empty():
		InvSys.add_item(scrap_item)
		
	return { "success": true, "gold_gained": gold_refund }
