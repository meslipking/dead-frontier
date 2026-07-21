# ═══════════════════════════════════════════════════════════════
#  MECHA SYSTEM (mecha_system.gd)
#  Quản lý lắp ráp Robot Mecha từ 4 bộ phận, tiêu thụ & nạp Nhiên liệu
# ═══════════════════════════════════════════════════════════════
class_name MechaSystem

const MechDb = preload("res://scripts/data/mecha_database.gd")

static func assemble_mecha(name: String, head_id: String, torso_id: String, arms_id: String, legs_id: String) -> Dictionary:
	var head: Dictionary = MechDb.get_part(head_id)
	var torso: Dictionary = MechDb.get_part(torso_id)
	var arms: Dictionary = MechDb.get_part(arms_id)
	var legs: Dictionary = MechDb.get_part(legs_id)
	
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

static func consume_fuel(mecha_id: String, amount: int = 5) -> bool:
	var mechas: Array = GameManager.get_mechas()
	for m in mechas:
		if m.get("id") == mecha_id:
			var current: int = m.get("fuel", 100)
			if current < amount:
				return false
			m["fuel"] = current - amount
			return true
	return false

static func refuel_mecha(mecha_id: String, amount: int = 50) -> bool:
	var mechas: Array = GameManager.get_mechas()
	for m in mechas:
		if m.get("id") == mecha_id:
			var max_f: int = m.get("max_fuel", 100)
			m["fuel"] = min(m.get("fuel", 0) + amount, max_f)
			print("[MechaSystem] Refueled mecha %s. Current fuel: %d" % [m["name"], m["fuel"]])
			return true
	return false
