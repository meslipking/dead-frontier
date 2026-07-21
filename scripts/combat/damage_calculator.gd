# ═══════════════════════════════════════════════════════════════
#  DAMAGE CALCULATOR (damage_calculator.gd)
#  Tính toán sát thương, nguyên tố khắc chế (1.5x), chí mạng & né tránh
# ═══════════════════════════════════════════════════════════════
class_name DamageCalculator

static func calculate_damage(attacker_stats: Dictionary, defender_stats: Dictionary, attacker_element: int = Constants.Element.NONE, defender_element: int = Constants.Element.NONE) -> Dictionary:
	var atk: float = attacker_stats.get("atk", 10)
	var def: float = defender_stats.get("def", 5)
	var luck: float = attacker_stats.get("luck", 5)
	var spd_diff: float = defender_stats.get("spd", 10) - attacker_stats.get("spd", 10)
	
	# Check Dodge (Né tránh)
	var dodge_chance: float = clamp(spd_diff * 0.01, 0.0, 0.30)
	if randf() < dodge_chance:
		return { "damage": 0, "is_crit": false, "is_dodge": true }
		
	# Check Crit (Chí mạng)
	var crit_chance: float = clamp(0.05 + luck * 0.005, 0.05, 0.50)
	var is_crit: bool = (randf() < crit_chance)
	var crit_mult: float = 1.5 if is_crit else 1.0
	
	# Check Element Advantage (Vòng tròn Nguyên Tố)
	var element_mult: float = 1.0
	if Constants.ELEMENT_ADVANTAGE.get(attacker_element, Constants.Element.NONE) == defender_element:
		element_mult = 1.5
		
	# Base Damage Formula: (ATK * random(0.9-1.1) - DEF * 0.4) * crit * element
	var random_variance: float = randf_range(0.90, 1.10)
	var net_atk: float = max(atk * random_variance - def * 0.4, 1.0)
	var final_damage: int = int(round(net_atk * crit_mult * element_mult))
	
	return {
		"damage": max(final_damage, 1),
		"is_crit": is_crit,
		"is_dodge": false,
		"element_advantage": (element_mult > 1.0)
	}
