# ═══════════════════════════════════════════════════════════════
#  ACHIEVEMENT SYSTEM (achievement_system.gd)
#  Hệ thống kiểm tra & trao thưởng Thành tựu In-Game
# ═══════════════════════════════════════════════════════════════
class_name AchievementSystem

const AchievDb = preload("res://scripts/data/achievement_database.gd")

static func check_achievements() -> void:
	var achievements: Array = AchievDb.get_all()
	var claimed: Array = GameManager.game_data.get("achievements", [])
	
	for ach in achievements:
		var aid: String = ach.get("id", "")
		if not claimed.has(aid):
			var req: int = ach.get("req_count", 1)
			var cur: int = GameManager.game_data.get("lifetime_stats", {}).get(ach.get("stat_key", ""), 0)
			if cur >= req:
				claimed.append(aid)
				GameManager.game_data["achievements"] = claimed
				var gold: int = ach.get("reward_gold", 0)
				GameManager.add_currency(Constants.Currency.GOLD, gold)
				EventBus.achievement_unlocked.emit(aid)
				print("[AchievementSystem] Achievement Unlocked! ID: ", aid)
