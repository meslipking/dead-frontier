# ═══════════════════════════════════════════════════════════════
#  INVENTORY SYSTEM (inventory_system.gd)
#  Quản lý kho chứa, thêm/xóa vật phẩm, gộp nguyên liệu
# ═══════════════════════════════════════════════════════════════
class_name InventorySystem

static func add_item(item_data: Dictionary) -> bool:
	var inv: Array = GameManager.get_inventory()
	var cap: int = get_capacity()
	
	# If material, stack with existing
	var itype: int = item_data.get("type", Constants.ItemType.MATERIAL)
	if itype == Constants.ItemType.MATERIAL:
		for slot in inv:
			if slot.get("id") == item_data.get("id"):
				slot["count"] = slot.get("count", 1) + item_data.get("count", 1)
				EventBus.inventory_changed.emit()
				return true
				
	if inv.size() >= cap:
		print("[InventorySystem] Inventory FULL!")
		return false
		
	inv.append(item_data.duplicate())
	EventBus.inventory_changed.emit()
	return true

static func remove_item(item_id: String, count: int = 1) -> bool:
	var inv: Array = GameManager.get_inventory()
	for i in range(inv.size() - 1, -1, -1):
		if inv[i].get("id") == item_id:
			var current_count: int = inv[i].get("count", 1)
			if current_count > count:
				inv[i]["count"] = current_count - count
			else:
				inv.remove_at(i)
			EventBus.inventory_changed.emit()
			return true
	return false

static func get_capacity() -> int:
	var armory_lvl: int = GameManager.game_data.get("outpost_levels", {}).get("armory", 1)
	return Constants.INVENTORY_BASE_CAPACITY + (armory_lvl - 1) * 10
