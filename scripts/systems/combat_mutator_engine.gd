# ═══════════════════════════════════════════════════════════════
#  COMBAT MUTATOR ENGINE (combat_mutator_engine.gd)
#  Động cơ Áp Đặt Biến Số Quy Tắc Trận Đấu Dynamic Combat Mutators
# ═══════════════════════════════════════════════════════════════
class_name CombatMutatorEngine

static var MUTATORS: Array[Dictionary] = [
	{
		"id": "reflective_spikes",
		"name": "⚙️ GIÁP PHẢN SÁT THƯƠNG 30%",
		"desc": "Kẻ địch phản lại 30% sát thương nhận vào thành sát thương chuẩn."
	},
	{
		"id": "vampiric_aura",
		"name": "🩸 HÀO QUANG HÚT MÁU 15%",
		"desc": "Tất cả đòn đánh hồi lại 15% lượng sát thương gây ra."
	},
	{
		"id": "em_storm",
		"name": "⚡ BÃƠ ĐIỆN TỪ SIÊU TỐC (+200% ATK SPD)",
		"desc": "Tốc độ đánh của cả 2 bên tăng gấp 3 lần."
	},
	{
		"id": "toxic_haze",
		"name": "☣️ SƯƠNG ĐỘC NIKEN (RÚT 3% HP/S)",
		"desc": "Toàn bộ đơn vị chịu sát thương rút độc 3% HP mỗi giây."
	}
]

static func get_active_mutator_for_stage(stage_num: int) -> Dictionary:
	var seed_val: int = abs(stage_num * 541 + 83)
	return MUTATORS[seed_val % MUTATORS.size()]
