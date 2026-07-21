# ═══════════════════════════════════════════════════════════════
#  CAPTURE SYSTEM (capture_system.gd)
#  Thu phục Quái vật đột biến dựa trên HP còn lại & Luck
# ═══════════════════════════════════════════════════════════════
class_name CaptureSystem

static func attempt_capture(monster_data: Dictionary, capturer_luck: int = 5) -> Dictionary:
	var base_rate: float = monster_data.get("capture_rate", 0.40)
	var hp_percent: float = float(monster_data.get("current_hp", 100)) / float(monster_data.get("max_hp", 100))
	
	# Rate increases significantly when monster HP is low
	# Formula: base_rate * (1.0 + (1.0 - hp_percent) * 1.5) * (1.0 + luck * 0.01)
	var final_rate: float = base_rate * (1.0 + (1.0 - hp_percent) * 1.5) * (1.0 + capturer_luck * 0.01)
	final_rate = clamp(final_rate, 0.05, 0.95)
	
	var success: bool = (randf() < final_rate)
	if success:
		EventBus.monster_captured.emit(monster_data)
		
	return {
		"success": success,
		"rate_percent": int(final_rate * 100)
	}
