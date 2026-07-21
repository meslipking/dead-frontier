# ═══════════════════════════════════════════════════════════════
#  MECHA SYSTEM (mecha_system.gd)
#  Quản lý lắp ráp Robot Mecha từ 4 bộ phận, tính chỉ số & nhiên liệu
# ═══════════════════════════════════════════════════════════════
class_name MechaSystem

static func assemble_mecha(name: String, head_id: String, torso_id: String, arms_id: String, legs_id: String) -> Dictionary:
	var head: Dictionary = MechaDatabase.get_part(head_id)
	var torso: Dictionary = MechaDatabase.get_part(torso_id)
	var arms: Dictionary = MechaDatabase.get_part(arms_id)
	var legs: Dictionary = MechaDatabase.get_part(legs_id)
	
	var total_stats := { "hp": 100, "atk": 20, "def": 10, "spd": 10, "acc": 10, "luck": 0 }
	var parts := [head, torso, arms, legs]
	
	for p in parts:
		var p_stats: Dictionary = p.get("stats", {})
		for k in p_stats:
			total_stats[k] = total_stats.get(k, 0) + p_stats[k]
			
	var power: int = total_stats["hp"] / 5 + total_stats["atk"] * 2 + total_stats["def"] * 2
	
	var new_mecha := {
		"id": "mecha_" + str(randi() % 10000),
		"name": name,
		"power_level": power,
		"fuel": 100,
		"max_fuel": 100,
		"parts": {
			"head": head_id, "torso": torso_id,
			"arms": arms_id, "legs": legs_id
		},
		"stats": total_stats
	}
	
	var mechas: Array = GameManager.get_mechas()
	mechas.append(new_mecha)
	EventBus.mecha_assembled.emit(new_mecha)
	print("[MechaSystem] Assembled new Mecha: ", name)
	return new_mecha
