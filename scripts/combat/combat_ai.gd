# ═══════════════════════════════════════════════════════════════
#  COMBAT AI (combat_ai.gd)
#  Lựa chọn mục tiêu tấn công thông minh cho kẻ địch (AI Target Selection)
# ═══════════════════════════════════════════════════════════════
class_name CombatAI

enum AIType { RANDOM, LOWEST_HP, HIGHEST_THREAT }

static func select_target(targets: Array, ai_type: int = AIType.LOWEST_HP) -> Dictionary:
	var alive_targets := []
	for t in targets:
		if t.get("current_hp", 0) > 0:
			alive_targets.append(t)
			
	if alive_targets.is_empty():
		return {}
		
	match ai_type:
		AIType.LOWEST_HP:
			alive_targets.sort_custom(func(a, b): return a.get("current_hp", 0) < b.get("current_hp", 0))
			return alive_targets[0]
		AIType.HIGHEST_THREAT:
			alive_targets.sort_custom(func(a, b): return a.get("stats", {}).get("atk", 0) > b.get("stats", {}).get("atk", 0))
			return alive_targets[0]
		_:
			return alive_targets[randi() % alive_targets.size()]
