# ═══════════════════════════════════════════════════════════════
#  TURN SYSTEM (turn_system.gd)
#  Quản lý nạp thanh hành động (Action Bar) dựa trên chỉ số SPD
# ═══════════════════════════════════════════════════════════════
class_name TurnSystem

static func tick_action_bars(units: Array, delta_ticks: float = 1.0) -> Array:
	var ready_units := []
	for u in units:
		if u.get("current_hp", 0) <= 0:
			continue
		var spd: float = u.get("stats", {}).get("spd", 10)
		var current_bar: float = u.get("action_bar", 0.0)
		current_bar += spd * delta_ticks
		u["action_bar"] = current_bar
		if current_bar >= 100.0:
			ready_units.append(u)
			
	# Sort ready units by highest action bar overflow
	ready_units.sort_custom(func(a, b): return a.get("action_bar", 0) > b.get("action_bar", 0))
	return ready_units

static func reset_action_bar(unit: Dictionary) -> void:
	unit["action_bar"] = fmod(unit.get("action_bar", 100.0), 100.0)
