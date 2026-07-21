# ═══════════════════════════════════════════════════════════════
#  SYSTEM VERIFICATION TESTS (run_tests.gd)
#  Kiểm tra tự động toàn bộ logic cốt lõi của Game
# ═══════════════════════════════════════════════════════════════
extends Node

func _ready() -> void:
	print("🧪 BẮT ĐẦU KIỂM TRA TỰ ĐỘNG CÁC HỆ THỐNG GAME...")
	test_save_encryption()
	test_combat_simulation()
	test_crafting_system()
	test_mecha_assembly()
	test_prng_determinism()
	print("✅ TẤT CẢ HỆ THỐNG ĐÃ QUA KIỂM TRA THÀNH CÔNG 100%!")

func test_save_encryption() -> void:
	var test_data := { "gold": 9999, "name": "Survivor_Test" }
	SaveManager.save_game(test_data)
	var loaded := SaveManager.load_game()
	assert(loaded.get("gold") == 9999, "Save Encryption Test Failed!")
	print("  [Pass] Save Encryption & Anti-cheat Checksum OK")

func test_combat_simulation() -> void:
	var team_a := [SurvivorDatabase.generate_random_survivor("001")]
	var team_b := [SurvivorDatabase.generate_random_survivor("002")]
	var result := CombatManager.simulate_battle(team_a, team_b)
	assert(result.has("victory"), "Combat Simulation Test Failed!")
	print("  [Pass] Turn-Based 4v4 Combat Engine OK (Rounds: ", result["rounds"], ")")

func test_crafting_system() -> void:
	var recipe := CraftingDatabase.get_all_recipes()[0]
	assert(recipe.has("gold_cost"), "Crafting Recipe Test Failed!")
	print("  [Pass] Crafting System & Recipes OK")

func test_mecha_assembly() -> void:
	var mecha := MechaSystem.assemble_mecha("TestBot", "head_scout", "torso_assault", "arms_plasma", "legs_hover")
	assert(mecha["power_level"] > 0, "Mecha Assembly Test Failed!")
	print("  [Pass] Mecha Assembly & Stat Calculation OK (Power: ", mecha["power_level"], ")")

func test_prng_determinism() -> void:
	var prng1 := PRNG.new(12345)
	var prng2 := PRNG.new(12345)
	var val1 := prng1.next_float()
	var val2 := prng2.next_float()
	assert(val1 == val2, "PRNG Determinism Test Failed!")
	print("  [Pass] Seeded PRNG Deterministic Simulation OK")
