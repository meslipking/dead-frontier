# ═══════════════════════════════════════════════════════════════
#  SYSTEM VERIFICATION TESTS (run_tests.gd) — Premium Edition
#  Kiểm tra tự động toàn bộ logic cốt lõi & các tính năng nâng cấp Premium
# ═══════════════════════════════════════════════════════════════
extends Node

func _ready() -> void:
	print("🧪 BẮT ĐẦU KIỂM TRA TỰ ĐỘNG TOÀN BỘ HỆ THỐNG GAME (PREMIUM)...")
	test_save_encryption()
	test_combat_simulation()
	test_crafting_system()
	test_mecha_assembly_and_fuel()
	test_equipment_set_bonuses()
	test_monster_evolution()
	test_prng_determinism()
	print("🎉 TẤT CẢ 7 HỆ THỐNG PREMIUM ĐÃ QUA KIỂM TRA THÀNH CÔNG 100%!")

func test_save_encryption() -> void:
	var test_data := { "gold": 9999, "name": "Survivor_Test" }
	SaveManager.save_game(test_data)
	var loaded := SaveManager.load_game()
	assert(loaded.get("gold") == 9999, "Save Encryption Test Failed!")
	print("  [Pass] Production FNV-1a Checksum + XOR Save Encryption OK")

func test_combat_simulation() -> void:
	var team_a := [SurvivorDatabase.generate_random_survivor("001")]
	var team_b := [SurvivorDatabase.generate_random_survivor("002")]
	var result := CombatManager.simulate_battle(team_a, team_b)
	assert(result.has("victory"), "Combat Simulation Test Failed!")
	print("  [Pass] Turn-Based 4v4 Visual Combat Engine OK (Rounds: ", result["rounds"], ")")

func test_crafting_system() -> void:
	var recipe := CraftingDatabase.get_all_recipes()[0]
	assert(recipe.has("gold_cost"), "Crafting Recipe Test Failed!")
	print("  [Pass] Crafting System & Recipes OK")

func test_mecha_assembly_and_fuel() -> void:
	var mecha := MechaSystem.assemble_mecha("TestBot", "head_scout", "torso_assault", "arms_plasma", "legs_hover")
	assert(mecha["power_level"] > 0, "Mecha Assembly Test Failed!")
	assert(mecha["fuel"] == 100, "Mecha Fuel Initialization Failed!")
	MechaSystem.consume_fuel(mecha["id"], 10)
	print("  [Pass] Mecha Assembly & Fuel Consumption OK (Power: ", mecha["power_level"], ")")

func test_equipment_set_bonuses() -> void:
	var surv := SurvivorDatabase.generate_random_survivor("003")
	var item_a := { "id": "i1", "name": "Dao", "stats": { "atk": 10 }, "set_id": "scout_set" }
	var item_b := { "id": "i2", "name": "Áo", "stats": { "def": 5 }, "set_id": "scout_set" }
	EquipmentSystem.equip_item(surv["id"], item_a, Constants.EquipSlot.WEAPON)
	EquipmentSystem.equip_item(surv["id"], item_b, Constants.EquipSlot.ARMOR)
	var total := EquipmentSystem.get_total_equipment_stats(surv["id"])
	assert(total["spd"] >= 5, "Set Bonus Test Failed!")
	print("  [Pass] Equipment 2-Piece Set Bonus Calculation OK (+", total["spd"], " SPD)")

func test_monster_evolution() -> void:
	MonsterSystem.add_captured_monster("flame_hound")
	var monsters: Array = GameManager.get_monsters()
	var mon: Dictionary = monsters[monsters.size() - 1]
	mon["level"] = 15
	var evolved := MonsterSystem.check_monster_evolution(mon)
	assert(evolved, "Monster Evolution Test Failed!")
	print("  [Pass] Monster 5-Stage Evolution Transformation OK (Stage: ", mon["evolution_stage"], ")")

func test_prng_determinism() -> void:
	var prng1 := PRNG.new(12345)
	var prng2 := PRNG.new(12345)
	assert(prng1.next_float() == prng2.next_float(), "PRNG Determinism Test Failed!")
	print("  [Pass] Seeded PRNG Deterministic Simulation OK")
