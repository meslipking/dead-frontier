# ═══════════════════════════════════════════════════════════════
#  CRAFTING SYSTEM (crafting_system.gd)
#  Kiểm tra nguyên liệu, tiêu thụ & thực thi chế tạo item
# ═══════════════════════════════════════════════════════════════
class_name CraftingSystem

static func can_craft(recipe: Dictionary) -> bool:
	# Check gold
	var cost: int = recipe.get("gold_cost", 0)
	if GameManager.get_currency(Constants.Currency.GOLD) < cost:
		return false
		
	# Check ingredients
	var ingredients: Array = recipe.get("ingredients", [])
	var inv: Array = GameManager.get_inventory()
	
	for ing in ingredients:
		var req_id: String = ing.get("item_id", "")
		var req_count: int = ing.get("count", 1)
		var found_count := 0
		
		for slot in inv:
			if slot.get("id") == req_id:
				found_count += slot.get("count", 1)
				
		if found_count < req_count:
			return false
			
	return true

static func craft_item(recipe: Dictionary) -> Dictionary:
	if not can_craft(recipe):
		return { "success": false, "reason": "Không đủ nguyên liệu hoặc vàng" }
		
	# Spend gold
	GameManager.spend_currency(Constants.Currency.GOLD, recipe.get("gold_cost", 0))
	
	# Consume ingredients
	var ingredients: Array = recipe.get("ingredients", [])
	for ing in ingredients:
		InventorySystem.remove_item(ing.get("item_id", ""), ing.get("count", 1))
		
	# Roll success rate
	var s_rate: float = recipe.get("success_rate", 1.0)
	var workshop_lvl: int = GameManager.game_data.get("outpost_levels", {}).get("workshop", 1)
	s_rate += (workshop_lvl - 1) * 0.02  # Workshop bonus
	
	var is_success: bool = (randf() < s_rate)
	if is_success:
		var out_id: String = recipe.get("output_item_id", "")
		var item_def: Dictionary = ItemDatabase.get_item(out_id)
		if not item_def.is_empty():
			InventorySystem.add_item(item_def)
			EventBus.craft_completed.emit(recipe.get("id", ""), true, item_def)
			return { "success": true, "item": item_def }
			
	EventBus.craft_completed.emit(recipe.get("id", ""), false, {})
	return { "success": false, "reason": "Chế tạo thất bại!" }
