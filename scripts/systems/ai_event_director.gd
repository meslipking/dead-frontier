# ═══════════════════════════════════════════════════════════════
#  AI EVENT DIRECTOR (ai_event_director.gd)
#  Quản Trò AI Tự Động Phân Tích & Điều Phối Sự Kiện + Cốt Truyện Biến Đổi 100%
# ═══════════════════════════════════════════════════════════════
class_name AIEventDirector
extends Node

static var story_logs: Array[String] = []

static func evaluate_and_trigger_event() -> Dictionary:
	var gold: int = GameManager.get_currency(Constants.Currency.GOLD)
	var seed_val: int = abs(randi() + gold * 37)
	
	var event_types := [
		{
			"title": "🩸 ĐÊM MÁU HOANG TÀN: AMBUSH SURPRISE",
			"desc": "Quản trò AI phát hiện căn cứ đang có vàng dồi dào! Bầy Zombie đột biến mở đợt phục kích.",
			"reward_type": "GOLD",
			"amount": 1500
		},
		{
			"title": "🛸 KHỞI ĐỘNG CỔNG KHÔNG GIAN WARP GATE",
			"desc": "Cổng dịch chuyển thời gian mở ra mang theo các rương trang bị siêu siêu nạp.",
			"reward_type": "CRYSTALS",
			"amount": 300
		},
		{
			"title": "📦 PHI THUYỀN TIẾP TẾ RƠI VŨ KHÍ MYTHIC",
			"desc": "Một hòm tiếp tế quân sự rơi xuống mang theo phế liệu Niken và nguyên liệu hiếm.",
			"reward_type": "ALLOYS",
			"amount": 800
		}
	]
	
	var selected_evt: Dictionary = event_types[seed_val % event_types.size()]
	log_director_story("AI Director triggered: " + selected_evt["title"])
	return selected_evt

static func log_director_story(entry: String) -> void:
	var timestamp := Time.get_time_string_from_system()
	story_logs.append("[" + timestamp + "] " + entry)
