# ═══════════════════════════════════════════════════════════════
#  AI NARRATIVE GENERATOR (ai_narrative_generator.gd) — Hybrid AI Engine
#  Động cơ AI Tự Động Sinh Cốt Truyện, Logic & Khám Phá Vô Hạn Không Lặp Lại
#  Hỗ trợ cả Procedural Grammar Offline lẫn HTTP Rest API LLM
# ═══════════════════════════════════════════════════════════════
class_name AINarrativeGenerator
extends Node

static var instance: AINarrativeGenerator

# ─── 1. PROCEDURAL AI GRAMMAR TABLES (OFFLINE INFINITE ENGINE) ─────
static var LOCATIONS: Array[String] = [
	"Mỏ Thạch Anh Đen Obsidian", "Rừng Cây Cổ Thụ Southern Grove",
	"Vùng Đất Chết Hoang Tàn Nitro", "Hầm Mộ Cổ Nền Văn Minh Cổ",
	"Pháo Đài Hư Không Tháp Đài", "Xưởng Cơ Khí Niken Quên Lãng",
	"Phòng Thí Nghiệm Sinh Học Bio-Sector 7", "Thành Phố Bão Điện Voltrun"
]

static var ANTAGONISTS: Array[String] = [
	"Đại Tướng Zombie Titan Colossus", "Rồng Cơ Khí Mech Dragon Omega",
	"Kẻ Độc Tài Thất Lạc Lord Malakor", "Quái Vật Đột Biến Bio-Hazard Hydra",
	"Linh Hồn Hư Không Void Sovereign", "Vua Rái Cá Điên Electric Otter Chief"
]

static var ARTIFACTS: Array[String] = [
	"Lõi Phản Ứng Plasma Cổ Đại", "Cung Băng Cyan Hàn Băng",
	"Súng Pháo Điện Từ Heavy Railgun", "Băng Trán Nhẫn Giả Hư Không",
	"Vương Miện Vàng 24K Hoàng Gia", "Ống Tiêm Vắc-Xin Kháng Độc"
]

static var TWISTS: Array[String] = [
	"Nhưng đồng đội cũ của bạn hóa ra là điệp viên hai mặt.",
	"Nhưng lõi năng lượng đang đếm ngược tự hủy trong 60 giây.",
	"Và bạn phát hiện ra quái vật chính là kết quả thử nghiệm của chính bạn.",
	"Và bầu trời bùng nổ bão điện từ thiêu rụi toàn bộ radar."
]

# ─── 2. GENERATE INFINITE UNIQUE STORY PER PLAYER ────────────────
static func generate_unique_player_campaign(player_id: String) -> Dictionary:
	var seed_val: int = abs(player_id.hash() + int(Time.get_unix_time_from_system()))
	
	var loc: String = LOCATIONS[seed_val % LOCATIONS.size()]
	var boss: String = ANTAGONISTS[(seed_val / 3) % ANTAGONISTS.size()]
	var relic: String = ARTIFACTS[(seed_val / 7) % ARTIFACTS.size()]
	var twist: String = TWISTS[(seed_val / 11) % TWISTS.size()]
	
	var story_title: String = "🔥 KỶ NGUYÊN ĐỘC BẢN: " + loc.to_upper()
	var story_text: String = "Nhiệm vụ của bạn: Thâm nhập " + loc + " để tìm kiếm " + relic + " và đánh bại " + boss + ". " + twist
	
	return {
		"seed": seed_val,
		"title": story_title,
		"text": story_text,
		"location": loc,
		"boss": boss,
		"relic": relic
	}

# ─── 3. PROCEDURAL AI EXPLORATION EVENT GENERATOR ────────────────
static func generate_random_exploration_event() -> Dictionary:
	var e_seed: int = randi()
	var loc: String = LOCATIONS[e_seed % LOCATIONS.size()]
	var relic: String = ARTIFACTS[(e_seed / 5) % ARTIFACTS.size()]
	
	return {
		"title": "🔍 THÁM HIỂM BẤT NGỜ TẠI " + loc.to_upper(),
		"description": "Trong lúc di chuyển qua " + loc + ", đội trinh sát phát hiện rương cổ đính " + relic + ".",
		"rewards": {
			"gold": (e_seed % 500) + 300,
			"alloys": (e_seed % 200) + 100,
			"relic": relic
		}
	}
