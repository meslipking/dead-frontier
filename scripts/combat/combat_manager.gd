# ═══════════════════════════════════════════════════════════════
#  COMBAT MANAGER (combat_manager.gd)
#  Điều khiển Giả lập Trận đấu Turn-Based 4v4 kiểu FlipFight
# ═══════════════════════════════════════════════════════════════
class_name CombatManager

const TurnSys = preload("res://scripts/combat/turn_system.gd")
const AI = preload("res://scripts/combat/combat_ai.gd")
const DmgCalc = preload("res://scripts/combat/damage_calculator.gd")

static func simulate_battle(team_a_raw: Array, team_b_raw: Array) -> Dictionary:
	var team_a: Array = []
	var team_b: Array = []
	
	for raw_u in team_a_raw:
		var u: Dictionary = (raw_u as Dictionary).duplicate(true)
		u["current_hp"] = u.get("stats", {}).get("hp", 100)
		u["action_bar"] = 0.0
		u["is_team_a"] = true
		team_a.append(u)
		
	for raw_u in team_b_raw:
		var u: Dictionary = (raw_u as Dictionary).duplicate(true)
		u["current_hp"] = u.get("stats", {}).get("hp", 100)
		u["action_bar"] = 0.0
		u["is_team_a"] = false
		team_b.append(u)

	var rounds := 0
	var max_rounds := 100
	var logs: Array[String] = []
	
	while rounds < max_rounds:
		rounds += 1
		if _is_team_defeated(team_a):
			return { "victory": false, "rounds": rounds, "logs": logs }
		if _is_team_defeated(team_b):
			return { "victory": true, "rounds": rounds, "logs": logs }

		var all_units: Array = []
		all_units.append_array(team_a)
		all_units.append_array(team_b)
		
		var ready_units: Array = TurnSys.tick_action_bars(all_units, 1.0)
		for attacker in ready_units:
			if attacker["current_hp"] <= 0: continue
			
			var defenders: Array = team_b if attacker["is_team_a"] else team_a
			var target: Dictionary = AI.select_target(defenders)
			if target.is_empty(): continue
			
			var dmg_result: Dictionary = DmgCalc.calculate_damage(attacker, target)
			var dmg: int = dmg_result.get("damage", 10)
			target["current_hp"] = max(target["current_hp"] - dmg, 0)
			TurnSys.reset_action_bar(attacker)
			
			logs.append(attacker.get("name", "Unit") + " tấn công " + target.get("name", "Target") + " gây " + str(dmg) + " DMG!")
			
	return { "victory": true, "rounds": rounds, "logs": logs }

static func _is_team_defeated(team: Array) -> bool:
	for u in team:
		if u.get("current_hp", 0) > 0:
			return false
	return true
