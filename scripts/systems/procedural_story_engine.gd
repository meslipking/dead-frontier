# ═══════════════════════════════════════════════════════════════
#  PROCEDURAL STORY ENGINE (procedural_story_engine.gd) — AI Story & Roguelike
#  Động cơ sinh Câu Chuyện Độc Bản & Sự Kiện Lựa Chọn Nhập Vai Ngẫu Nhiên
# ═══════════════════════════════════════════════════════════════
class_name ProceduralStoryEngine

static var player_seed: int = 0
static var story_chronicle: Array[String] = []

static func init_player_story() -> String:
	player_seed = randi()
	story_chronicle.clear()
	
	var origins := [
		"Thợ Săn Tàn Tích xuất thân từ Vùng Đất Chết Nitro",
		"Kỹ Sư Cơ Khí Đột Phá từ Xưởng Niken Cổ",
		"Thủ Lĩnh Kháng Chiến đến từ Pháo Đài Hư Không",
		"Thiện Xạ Bão Tuyết xuất thân từ Mỏ Obsidian"
	]
	var threats := [
		"Rồng Cơ Khí Mech Dragon Omega",
		"Trùm Sinh Học Bio-Hazard Hydra",
		"Đại Tướng Zombie Titan Colossus",
		"Pháo Đài Hư Không Void Dreadnought"
	]
	
	var origin_str: String = origins[player_seed % origins.size()]
	var threat_str: String = threats[(player_seed / 7) % threats.size()]
	
	var intro := "📖 HÀNH TRÌNH ĐỘC BẢN (SEED #" + str(player_seed % 9999) + "):\n" \
		+ "Bạn là " + origin_str + ". Mối đe dọa lớn nhất hành tinh của bạn là " + threat_str + "."
		
	story_chronicle.append(intro)
	return intro

static func generate_random_story_event() -> Dictionary:
	var events := [
		{
			"title": "📻 TÍN HIỆU CẤP CỨU TỪ TÀU KHÔNG GIAN CỔ",
			"desc": "Đội trinh sát phát hiện tín hiệu SOS từ một khoang tàu không gian rơi rải rác vũ khí.",
			"opt1": "🚀 [CỨU HỘ] Mở khoang tàu (70% Nhận Súng Plasma, 30% Zombie dội ra)",
			"opt2": "⛏️ [KHẢO SÁT] Rã xác tàu lấy 500 Phế liệu Niken",
			"opt3": "🏃 [BỎ QUA] Rút lui an toàn (Nhận +200 Vàng)"
		},
		{
			"title": "☣️ NGUỒN NƯỚC ĐỘT BIẾN TẠI MỎ OBSIDIAN",
			"desc": "Dòng sông hóa chất dạ quang chảy qua khu vực đóng quân của bạn.",
			"opt1": "🧪 [UỐNG THỬ] Cho quái vật uống (Nhận 1 Quái Đột Biến Apex)",
			"opt2": "⚡ [LỌC NĂNG LƯỢNG] Nạp vào Lõi Mecha (+1,000 Energy)",
			"opt3": "🛡️ [XỬ LÝ] Chế tạo thuốc kháng độc"
		},
		{
			"title": "🤖 MECHA TỰ HÀNH MẤT KHỦNG KHỦNG",
			"desc": "Một Mecha cổ đại mất kiểm soát đang tiến về căn cứ của bạn.",
			"opt1": "⚔️ [TẤN CÔNG] Tiêu diệt lấy Lõi Fusion Core",
			"opt2": "⚙️ [HACK MÃ] Sửa mã nguồn chiêu mộ làm trợ thủ",
			"opt3": "🧱 [CỐ THỦ] Dựng vách kim loại ngăn chặn"
		}
	]
	return events[randi() % events.size()]

static func log_story_milestone(entry: String) -> void:
	story_chronicle.append("• " + entry)
