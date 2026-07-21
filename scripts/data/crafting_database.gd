# ═══════════════════════════════════════════════════════════════
#  CRAFTING DATABASE (crafting_database.gd)
#  Công thức chế tạo Trang bị, Vật phẩm & Linh kiện trong Xưởng Máy
# ═══════════════════════════════════════════════════════════════
class_name CraftingDatabase

const RECIPES := [
	{
		"id": "recipe_machete",
		"name": "Dao rựa sinh tồn",
		"output_item_id": "wpn_machete",
		"gold_cost": 50,
		"success_rate": 0.95,
		"ingredients": [
			{ "item_id": "mat_scrap_iron", "count": 3 }
		]
	},
	{
		"id": "recipe_tactical_vest",
		"name": "Áo giáp chống đạn",
		"output_item_id": "arm_tactical_vest",
		"gold_cost": 100,
		"success_rate": 0.90,
		"ingredients": [
			{ "item_id": "mat_scrap_iron", "count": 5 },
			{ "item_id": "mat_circuit_board", "count": 2 }
		]
	},
	{
		"id": "recipe_hazmat_suit",
		"name": "Bộ Hazmat Độc Hóa",
		"output_item_id": "arm_hazmat_suit",
		"gold_cost": 250,
		"success_rate": 0.80,
		"ingredients": [
			{ "item_id": "mat_toxic_slime", "count": 4 },
			{ "item_id": "mat_circuit_board", "count": 3 }
		]
	},
	{
		"id": "recipe_plasma_blade",
		"name": "Kiếm Plasma",
		"output_item_id": "wpn_plasma_blade",
		"gold_cost": 500,
		"success_rate": 0.75,
		"ingredients": [
			{ "item_id": "mat_cool_alloy", "count": 5 },
			{ "item_id": "mat_energy_core", "count": 1 }
		]
	}
]

static func get_all_recipes() -> Array:
	return RECIPES
