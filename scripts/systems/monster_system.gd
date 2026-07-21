# ═══════════════════════════════════════════════════════════════
#  MONSTER SYSTEM (monster_system.gd)
#  Quản lý bắt, nuôi dưỡng, nâng cấp & tiến hóa quái vật (Monster Ranch)
# ═══════════════════════════════════════════════════════════════
class_name MonsterSystem

static func add_captured_monster(species_id: String) -> bool:
	var species: Dictionary = MonsterDatabase.get_species(species_id)
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
			ProgressionSystem.check_unit_level_up(m)
			return true
	return false
