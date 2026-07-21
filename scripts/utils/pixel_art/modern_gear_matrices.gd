# ═══════════════════════════════════════════════════════════════
#  MODERN GEAR MATRICES (modern_gear_matrices.gd)
#  Chứa các Ma Trận Chuỗi Pixel Matrix 24x24 cho Trang Bị Modern Sci-Fi Zombie & Mecha
# ═══════════════════════════════════════════════════════════════
class_name ModernGearMatrices

# 🔫 1. PLASMA RIFLE (Súng Plasma Cyan)
static func get_plasma_rifle_matrix() -> Array:
	return [
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		".......KKKKKKKKKK.......",
		"......KKEEEEEEEEKK......",
		".....KKEEEEEEEEEEKKEE...",
		"....KKKKKKKKKKKKKKKKEE..",
		"....KKKKSSSKKSSSKKKK....",
		".......SS...SS..........",
		".......SS...SS..........",
		".......SS...............",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................"
	]

# 🪚 2. CHAINSAW GREATSWORD (Cưa Máy Cầm Tay Diệt Zombie)
static func get_chainsaw_matrix() -> Array:
	return [
		"........................",
		"..................OOOO..",
		".................OOKKOO.",
		"................OOKKOO..",
		"...............OOKKOO...",
		"..............OOKKOO....",
		".............OOKKOO.....",
		"............OOKKOO......",
		"...........OOKKOO.......",
		"..........OOKKOO........",
		".........OOKKOO.........",
		"........OOKKOO..........",
		".......OOKKOO...........",
		"......OOKKOO............",
		".....OOKKOO.............",
		"....KKKKKK..RR..........",
		"...KKKKKK..RRRR.........",
		"..RRRRRRRRRRRR..........",
		"...RRRRRR...............",
		".....SS.................",
		"....SS..................",
		"........................",
		"........................",
		"........................"
	]

# 🦿 3. TITAN EXO-SKELETON (Bộ Giáp Trợ Lực Exo-Suit Mech)
static func get_titan_exosuit_matrix() -> Array:
	return [
		"........................",
		".....KK..........KK.....",
		"....KKKK........KKKK....",
		"...KKEEEEKKKKKKEEEEKK...",
		"..KKEEEEEEKKKKEEEEEEKK..",
		"..KKEEEEEEKKKKEEEEEEKK..",
		"..KKHHKKKKGGGGHKKKKHKK..",
		"...SSKKKKSSGGSSKKKKSS...",
		"....SSKKKKSSSSKKKKSS....",
		"....SSKKKKEEEEKKKKSS....",
		"....SSHKKKEEEEKKKHSS....",
		"....SSHKKKEEEEKKKHSS....",
		"....SSGGGGGGGGGGGGSS....",
		"....SSGGGGGGGGGGGGSS....",
		"....SSHKKKKKKKKKKHSS....",
		"....SSHKKKKKKKKKKHSS....",
		"....SSHKKKKKKKKKKHSS....",
		"....SSHKKKKKKKKKKHSS....",
		".....SSSSSSSSSSSSSS.....",
		"......SSSSSSSSSSSS......",
		".......SSSSSSSSSS.......",
		"........SSSSSSSS........",
		"........................",
		"........................"
	]

# 🥽 4. CYBER HUD VISOR (Kính HUD Công Nghệ Đêm)
static func get_cyber_visor_matrix() -> Array:
	return [
		"........................",
		"........................",
		"........................",
		"....KK....KK....KK......",
		"...KKKK..KKKK..KKKK.....",
		"..KKEEEEEEEEEEEEEEEEKK..",
		"..KKEERREEKKEERREEKK....",
		"..KKEERREEKKEERREEKK....",
		"..KKEEEEEEEEEEEEEEEEKK..",
		"..KKGGGGGGGGGGGGGGGGKK..",
		"..KKGgGgGgGgGgGgGgGGKK..",
		"..KKGGGGGGGGGGGGGGGGKK..",
		"..KKKKKKKKKKKKKKKKKKKK..",
		"...KKKKKKKKKKKKKKKK.....",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................",
		"........................"
	]

static func get_gear_matrix(gear_name: String) -> Array:
	if gear_name.contains("Plasma") or gear_name.contains("Gun") or gear_name.contains("Rifle"):
		return get_plasma_rifle_matrix()
	elif gear_name.contains("Chainsaw") or gear_name.contains("Cưa"):
		return get_chainsaw_matrix()
	elif gear_name.contains("Exo") or gear_name.contains("Titan") or gear_name.contains("Armor"):
		return get_titan_exosuit_matrix()
	else:
		return get_cyber_visor_matrix()
