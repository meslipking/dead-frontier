# ═══════════════════════════════════════════════════════════════
#  ACHIEVEMENT SYSTEM (achievement_system.gd)
#  Kiểm tra & mở khóa thành tựu in-game, trao thưởng Vàng & Pha lê
# ═══════════════════════════════════════════════════════════════
class_name AchievementSystem

const AchDb = preload("res://scripts/data/achievement_database.gd")

static func check_achievement(ach_id: String) -> bool:
	var unlocked: Array = GameManager.game_data.get("achievements", [])
	if unlocked.has(ach_id):
		return false
		
	var ach: Dictionary = AchDb.get_achievement(ach_id)
	if ach.is_empty():
		return false
		
	unlocked.append(ach_id)
	GameManager.game_data["achievements"] = unlocked
	
	var rew: Dictionary = ach.get("rewards", {})
	if rew.has("gold"):
		GameManager.add_currency(Constants.Currency.GOLD, rew["gold"])
	if rew.has("crystals"):
		GameManager.add_currency(Constants.Currency.CRYSTALS, rew["crystals"])
		
	EventBus.achievement_unlocked.emit(ach_id)
	print("[AchievementSystem] Achievement unlocked: ", ach_id)
	return true
