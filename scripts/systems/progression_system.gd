# ═══════════════════════════════════════════════════════════════
#  PROGRESSION SYSTEM (progression_system.gd)
#  Quản lý tăng cấp Unit, đường cong EXP & nâng cấp phòng Tiền đồn
# ═══════════════════════════════════════════════════════════════
class_name ProgressionSystem

static func get_required_exp(level: int) -> int:
	return int(round(50.0 * pow(level, 1.5)))

static func check_unit_level_up(unit: Dictionary) -> bool:
	var lvl: int = unit.get("level", 1)
	var exp: int = unit.get("exp", 0)
	var req := get_required_exp(lvl)
	
	if exp >= req and lvl < Constants.MAX_UNIT_LEVEL:
		unit["level"] = lvl + 1
		unit["exp"] = exp - req
		
		# Grow stats
		var stats: Dictionary = unit.get("stats", {})
		stats["hp"] = int(round(stats.get("hp", 100) * 1.1))
		stats["atk"] = int(round(stats.get("atk", 10) * 1.08))
		stats["def"] = int(round(stats.get("def", 5) * 1.08))
		
		EventBus.unit_leveled_up.emit(unit.get("unit_type", Constants.UnitType.SURVIVOR), unit.get("id", ""), unit["level"])
		return true
		
	return false

static func upgrade_room(room_type_key: String) -> bool:
	var levels: Dictionary = GameManager.game_data.get("outpost_levels", {})
	var current_lvl: int = levels.get(room_type_key, 1)
	
	if current_lvl >= Constants.MAX_ROOM_LEVEL:
		return false
		
	var cost := current_lvl * 100
	if GameManager.spend_currency(Constants.Currency.GOLD, cost):
		levels[room_type_key] = current_lvl + 1
		GameManager.game_data["outpost_levels"] = levels
		print("[ProgressionSystem] Upgraded room %s to level %d" % [room_type_key, current_lvl + 1])
		return true
		
	return false
