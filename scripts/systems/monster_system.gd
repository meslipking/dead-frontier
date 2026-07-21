# ═══════════════════════════════════════════════════════════════
#  MONSTER SYSTEM (monster_system.gd)
#  Quản lý bắt, nuôi dưỡng, nâng cấp, tiến hóa 5 cấp & lai tạo quái vật
# ═══════════════════════════════════════════════════════════════
class_name MonsterSystem

const MonDb = preload("res://scripts/data/monster_database.gd")
const ProgSys = preload("res://scripts/systems/progression_system.gd")

static func add_captured_monster(species_id: String) -> bool:
	var species: Dictionary = MonDb.get_species(species_id)
	if species.is_empty():
		return false
		
	var monsters: Array = GameManager.get_monsters()
	var new_monster := {
		"id": "mon_" + str(randi() % 10000),
		"species_id": species_id,
		"name": species.get("name", "Quái vật"),
		"element": species.get("element", Constants.Element.NONE),
		"level": 1,
		"exp": 0,
		"evolution_stage": Constants.EvolutionStage.BABY,
		"stats": species.get("base_stats", {}).duplicate()
	}
	
	monsters.append(new_monster)
	print("[MonsterSystem] Captured new monster: ", new_monster["name"])
	return true

static func feed_monster(monster_id: String, food_exp: int = 50) -> bool:
	var monsters: Array = GameManager.get_monsters()
	for m in monsters:
		if m.get("id") == monster_id:
			m["exp"] = m.get("exp", 0) + food_exp
			ProgSys.check_unit_level_up(m)
			check_monster_evolution(m)
			return true
	return false

static func check_monster_evolution(monster: Dictionary) -> bool:
	var lvl: int = monster.get("level", 1)
	var stage: int = monster.get("evolution_stage", Constants.EvolutionStage.BABY)
	
	var can_evolve := false
	if lvl >= 10 and stage < Constants.EvolutionStage.JUVENILE:
		monster["evolution_stage"] = Constants.EvolutionStage.JUVENILE
		can_evolve = true
	elif lvl >= 20 and stage < Constants.EvolutionStage.ADULT:
		monster["evolution_stage"] = Constants.EvolutionStage.ADULT
		can_evolve = true
	elif lvl >= 30 and stage < Constants.EvolutionStage.ELDER:
		monster["evolution_stage"] = Constants.EvolutionStage.ELDER
		can_evolve = true
	elif lvl >= 40 and stage < Constants.EvolutionStage.APEX:
		monster["evolution_stage"] = Constants.EvolutionStage.APEX
		can_evolve = true
		
	if can_evolve:
		var stats: Dictionary = monster.get("stats", {})
		stats["hp"] = int(round(stats.get("hp", 100) * 1.25))
		stats["atk"] = int(round(stats.get("atk", 10) * 1.25))
		stats["def"] = int(round(stats.get("def", 5) * 1.20))
		EventBus.monster_evolved.emit(monster.get("id", ""), monster["evolution_stage"])
		print("[MonsterSystem] Monster EVOLVED to Stage: ", monster["evolution_stage"])
		return true
		
	return false

static func breed_monsters(parent_a_id: String, parent_b_id: String) -> Dictionary:
	var species_keys := MonDb.SPECIES.keys()
	var child_species: String = species_keys[randi() % species_keys.size()]
	add_captured_monster(child_species)
	var monsters: Array = GameManager.get_monsters()
	var child: Dictionary = monsters[monsters.size() - 1]
	child["name"] = "Quái Đột Biến " + child["name"]
	return child
