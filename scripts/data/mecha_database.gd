# ═══════════════════════════════════════════════════════════════
#  MECHA DATABASE (mecha_database.gd)
#  Định nghĩa linh kiện Robot Mecha: Đầu, Thân, Tay, Chân
# ═══════════════════════════════════════════════════════════════
class_name MechaDatabase

const PARTS := {
	"head_scout": { "id": "head_scout", "name": "Đầu Trinh Sát Mark-I", "slot": Constants.MechaSlot.HEAD, "stats": { "acc": 15, "spd": 8 } },
	"head_heavy": { "id": "head_heavy", "name": "Mũ Bọc Thép Titan", "slot": Constants.MechaSlot.HEAD, "stats": { "def": 25, "hp": 80 } },
	
	"torso_assault": { "id": "torso_assault", "name": "Thân Đột Kích V-2", "slot": Constants.MechaSlot.TORSO, "stats": { "hp": 200, "atk": 20 } },
	"torso_fortress": { "id": "torso_fortress", "name": "Thân Pháo Đài Hạt Nhân", "slot": Constants.MechaSlot.TORSO, "stats": { "hp": 400, "def": 40 } },
	
	"arms_plasma": { "id": "arms_plasma", "name": "Tay Pháo Plasma", "slot": Constants.MechaSlot.ARMS, "stats": { "atk": 45, "acc": 10 } },
	"arms_blade": { "id": "arms_blade", "name": "Tay Lưỡi Cưa Kim Cương", "slot": Constants.MechaSlot.ARMS, "stats": { "atk": 38, "spd": 5 } },
	
	"legs_hover": { "id": "legs_hover", "name": "Chân Bay Động Lực", "slot": Constants.MechaSlot.LEGS, "stats": { "spd": 20, "hp": 50 } },
	"legs_crawler": { "id": "legs_crawler", "name": "Chân Xích Tăng Thép", "slot": Constants.MechaSlot.LEGS, "stats": { "def": 30, "hp": 150 } }
}

static func get_part(part_id: String) -> Dictionary:
	return PARTS.get(part_id, {})
