# ═══════════════════════════════════════════════════════════════
#  COMBAT MANAGER (combat_manager.gd)
#  Điều phối trận đấu 4v4 auto-battle, tính toán lượt và phần thưởng
# ═══════════════════════════════════════════════════════════════
class_name CombatManager

static func simulate_battle(player_team: Array, enemy_team: Array) -> Dictionary:
	var logs := []
	var round_count := 0
	const MAX_ROUNDS := 50
	
	# Prepare combat units
	var p_units := []
	for p in player_team:
		var u := p.duplicate(true)
		u["max_hp"] = u.get("stats", {}).get("hp", 100)
		u["current_hp"] = u["max_hp"]
		u["action_bar"] = randf_range(0.0, 20.0)
		u["is_enemy"] = false
		p_units.append(u)
		
	var e_units := []
	for e in enemy_team:
		var u := e.duplicate(true)
		u["max_hp"] = u.get("stats", {}).get("hp", 80)
		u["current_hp"] = u["max_hp"]
		u["action_bar"] = randf_range(0.0, 20.0)
		u["is_enemy"] = true
		e_units.append(u)
		
	logs.append("⚔️ TRẬN ĐẤU BẮT ĐẦU!")
	
	while round_count < MAX_ROUNDS:
		round_count += 1
		var all_units := p_units + e_units
		var ready_units := TurnSystem.tick_action_bars(all_units, 1.0)
		
		for actor in ready_units:
			if actor["current_hp"] <= 0:
				continue
				
			var targets: Array = e_units if not actor["is_enemy"] else p_units
			var target: Dictionary = CombatAI.select_target(targets, CombatAI.AIType.LOWEST_HP)
			
			if target.is_empty():
				break  # Battle over
				
			var dmg_result := DamageCalculator.calculate_damage(
				actor.get("stats", {}),
				target.get("stats", {}),
				actor.get("element", Constants.Element.NONE),
				target.get("element", Constants.Element.NONE)
			)
			
			if dmg_result["is_dodge"]:
				logs.append("%s né tránh đòn đánh từ %s!" % [target["name"], actor["name"]])
			else:
				var dmg: int = dmg_result["damage"]
				target["current_hp"] = max(target["current_hp"] - dmg, 0)
				var crit_txt := " (CHÍ MẠNG!)" if dmg_result["is_crit"] else ""
				logs.append("%s gây %d sát thương lên %s%s" % [actor["name"], dmg, target["name"], crit_txt])
				
				if target["current_hp"] <= 0:
					logs.append("☠️ %s đã gục ngã!" % target["name"])
					
			TurnSystem.reset_action_bar(actor)
			
		# Check victory condition
		var p_alive := false
		for p in p_units:
			if p["current_hp"] > 0: p_alive = true; break
			
		var e_alive := false
		for e in e_units:
			if e["current_hp"] > 0: e_alive = true; break
			
		if not p_alive or not e_alive:
			var victory: bool = p_alive
			logs.append("🏆 CHẾT VÀ BẢO VỆ THÀNH CÔNG!" if victory else "💀 ĐỘI HÌNH ĐÃ THẤT BẠI!")
			return {
				"victory": victory,
				"rounds": round_count,
				"logs": logs,
				"gold_reward": 50 if victory else 10,
				"exp_reward": 80 if victory else 20
			}
			
	return { "victory": false, "rounds": round_count, "logs": logs, "gold_reward": 10, "exp_reward": 10 }
