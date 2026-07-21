# ═══════════════════════════════════════════════════════════════
#  PROCEDURAL STORY ENGINE (procedural_story_engine.gd) — AI Story & Roguelike
#  Động cơ sinh Câu Chuyện Độc Bản & Sự Kiện Lựa Chọn Nhập Vai Ngẫu Nhiên
# ═══════════════════════════════════════════════════════════════
class_name ProceduralStoryEngine

const AIGen = preload("res://scripts/systems/ai_narrative_generator.gd")

static var player_seed: int = 0
static var story_chronicle: Array[String] = []

static func init_player_story() -> String:
	var campaign := AIGen.generate_unique_player_campaign("player_unique_id")
	player_seed = campaign["seed"]
	story_chronicle.clear()
	
	var intro: String = str(campaign["title"]) + "\n" + str(campaign["text"])
	story_chronicle.append(intro)
	return intro

static func generate_random_story_event() -> Dictionary:
	var ai_evt := AIGen.generate_random_exploration_event()
	return {
		"title": str(ai_evt.get("title", "")),
		"desc": str(ai_evt.get("description", "")),
		"opt1": "🚀 [CỨU HỘ] Mở rương bảo vật cổ",
		"opt2": "⛏️ [KHẢO SÁT] Thu hoạch Phế liệu Niken",
		"opt3": "🏃 [BỎ QUA] Rút lui an toàn"
	}

static func log_story_milestone(entry: String) -> void:
	story_chronicle.append("• " + entry)
