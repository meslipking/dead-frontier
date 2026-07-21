# ═══════════════════════════════════════════════════════════════
#  ACHIEVEMENT SYSTEM (achievement_system.gd)
#  Theo dõi & mở khóa thành tựu
# ═══════════════════════════════════════════════════════════════
class_name AchievementSystem

static func check_achievement(ach_id: String) -> bool:
	var unlocked: Array = GameManager.game_data.get("achievements", [])
	if unlocked.has(ach_id):
		return false
		
	for ach in AchievementDatabase.get_all():
		if ach.get("id") == ach_id:
			unlocked.append(ach_id)
			GameManager.game_data["achievements"] = unlocked
			
			var gold: int = ach.get("reward_gold", 0)
			if gold > 0: GameManager.add_currency(Constants.Currency.GOLD, gold)
			
			var crystals: int = ach.get("reward_crystals", 0)
			if crystals > 0: GameManager.add_currency(Constants.Currency.CRYSTALS, crystals)
			
			EventBus.achievement_unlocked.emit(ach_id)
			print("[AchievementSystem] Unlocked Achievement: ", ach.get("title"))
			return true
			
	return false
