# ═══════════════════════════════════════════════════════════════
#  CHARACTER PIXEL MATRICES (character_pixel_matrices.gd) — 8 Full Heroes Roster
#  Chứa các Ma Trận Chuỗi Pixel Matrix 32x32 cho 8 Anh Hùng & 100 Quái/Mecha
# ═══════════════════════════════════════════════════════════════
class_name CharacterPixelMatrices

# 🛡️ IRON DEFENDER (Brute Archetype)
static func get_iron_defender_matrix() -> Array:
	return [
		"................................",
		".........##..........##.........",
		"........#HH#........#HH#........",
		"........#KK#........#KK#........",
		".......#KKK##########KKK#.......",
		".......#KKKKKKKKKKKKKKKK#.......",
		"......#KKKKKKKKKKKKKKKKKK#......",
		"......#KKKKK########KKKKK#......",
		"......#KKK#RRRRRRRRRR#KKK#......",
		"......#KKK#RRRRRRRRRR#KKK#......",
		"......#KKK############KKK#......",
		"......#KKKKKKKKKKKKKKKKKK#......",
		".......#KKKKKKKKKKKKKKKK#.......",
		"........#KKKKFFKKFFKKKK#........",
		".......##SSSSSSSSSSSSSS##.......",
		"......#HHSSSSGGGGSSSSSSHH#......",
		".....#HHHHSSSGGGGSSSHHHHHH#.....",
		"....#HHHHHHHSSSSSSSSHHHHHHH#....",
		"...#rrrHHHHHHSSSSSSHHHHHHrrr#...",
		"...#rrr#HHHHHSSSSSSHHHHH#rrr#...",
		"..#rrrrr#HHHHSSSSSSHHHH#rrrrr#..",
		"..#rrrrr#HHHGGGGGGHHHHH#rrrrr#..",
		"..#rrrrr#HHHGGGGGGHHHHH#rrrrr#..",
		"..#rrrrr#SSSGGGGGGSSSS#rrrrrr#..",
		"..#rrrrr#SSSSSSSSSSSSSS#rrrrr#..",
		"...#rrr#SSSSSSSSSSSSSSSS#rrr#...",
		"....##.#KKKKK######KKKKK#.##....",
		".......#KKKKK#....#KKKKK#.......",
		".......#KKKKK#....#KKKKK#.......",
		".......#SSSSS#....#SSSSS#.......",
		".......#SS#SS#....#SS#SS#.......",
		".......###..##....##..###......."
	]

# 🥷 NIGHT TERROR (Nocturnal Archetype)
static func get_night_terror_matrix() -> Array:
	return [
		"................................",
		".........##############.........",
		"........#pppppppppppppp#........",
		".......#pppppppppppppppp#.......",
		"......#pppppppppppppppppp#......",
		"......#pppp############pp#......",
		"......#ppp#EEEEEEEEEEEE#p#......",
		"......#ppp#EEEEEEEEEEEE#p#......",
		"......#ppp##############p#......",
		"......#pppppppppppppppppp#......",
		".......#pppppppppppppppp#.......",
		"........#pppppppppppppp#........",
		".......##pppppppppppppp##.......",
		"......#PPppppppppppppppPP#......",
		".....#PPPPppppppppppppPPPP#.....",
		"....#PPPPPPppppppppppPPPPPP#....",
		"...#PPPPPPPPppppppppPPPPPPPP#...",
		"...#P#PPPPPPPppppppPPPPPPP#P#...",
		"..#PP#PPPPPPppppppppPPPPPP#PP#..",
		"..#PP#PPPPPPGGGGGGGGPPPPPP#PP#..",
		"..#PP#PPPPPPGGGGGGGGPPPPPP#PP#..",
		"..#PP#PPPPPPppppppppPPPPPP#PP#..",
		"..#PP#PPPPPPppppppppPPPPPP#PP#..",
		"...#P#PPPPPPppppppppPPPPPP#P#...",
		"....##PPPPPPppppppppPPPPPP##....",
		".......#ppppP######Ppppp#.......",
		".......#ppppP#....#Ppppp#.......",
		".......#ppppP#....#Ppppp#.......",
		".......#PPPPP#....#PPPPP#.......",
		".......#PP#PP#....#PP#PP#.......",
		".......###..##....##..###......."
	]

# 🥷 SHADOW DANCER (Nimble Archetype)
static func get_shadow_dancer_matrix() -> Array:
	return [
		"................................",
		"........##############..........",
		".......#RRRRRRRRRRRRRR#.........",
		"......#RRRRRRRRRRRRRRRR#........",
		"......##################........",
		"......#FFFFFFFFFFFFFFFF#........",
		"......#FFF####FFFF####F#........",
		"......#FFF#EE#FFFF#EE#F#........",
		"......#FFF####FFFF####F#........",
		"......#FFFFFFFFFFFFFFFF#........",
		"......#FFFFFFFFFFFFFFFF#........",
		".......###############.........",
		".......##bbbbbbbbbbbb##.........",
		"......#BBbbbbbbbbbbbbBB#........",
		".....#BBBBbbbbbbbbbbBBBB#.......",
		"....#BBBBBBbbbbbbbbBBBBBB#......",
		"...#BBBBBBBBbbbbbbBBBBBBBB#.....",
		"...#B#BBBBBBBbbbbbbBBBBBBB#B#...",
		"..#BB#BBBBBBbbbbbbbbBBBBBB#BB#..",
		"..#BB#BBBBBBGGGGGGGGBBBBBB#BB#..",
		"..#BB#BBBBBBGGGGGGGGBBBBBB#BB#..",
		"..#BB#BBBBBBbbbbbbbbBBBBBB#BB#..",
		"..#BB#BBBBBBbbbbbbbbBBBBBB#BB#..",
		"...#B#BBBBBBbbbbbbbbBBBBBB#B#...",
		"....##BBBBBBbbbbbbbbBBBBBB##....",
		".......#bbbbB######Bbbbb#.......",
		".......#bbbbB#....#Bbbbb#.......",
		".......#bbbbB#....#Bbbbb#.......",
		".......#BBBBB#....#BBBBB#.......",
		".......#BB#BB#....#BB#BB#.......",
		".......###..##....##..###......."
	]

# 🏹 FERAL RANGER (Feral Archetype)
static func get_feral_ranger_matrix() -> Array:
	return [
		"................................",
		".........##############.........",
		"........#WWWWWWWWWWWWWW#........",
		".......#WWWWWWWWWWWWWWWW#.......",
		"......#WWWWWWWWWWWWWWWWWW#......",
		"......#WWWW############WW#......",
		"......#WWW#EEEEEEEEEEEE#W#......",
		"......#WWW#EEEEEEEEEEEE#W#......",
		"......#WWW##############W#......",
		"......#WWWWWWWWWWWWWWWWWW#......",
		".......#WWWWWWWWWWWWWWWW#.......",
		"........#WWWWWWWWWWWWWW#........",
		".......##WWWWWWWWWWWWWW##.......",
		"......#wwWWWWWWWWWWWWWWww#......",
		".....#wwwwWWWWWWWWWWWWwwww#.....",
		"....#wwwwwwWWWWWWWWWWwwwwww#....",
		"...#wwwwwwwwWWWWWWWWwwwwwwww#...",
		"...#w#wwwwwwwWWWWWWwwwwwww#w#...",
		"..#ww#wwwwwwWWWWWWWWwwwwww#ww#..",
		"..#ww#wwwwwwGGGGGGGGwwwwww#ww#..",
		"..#ww#wwwwwwGGGGGGGGwwwwww#ww#..",
		"..#ww#wwwwwwWWWWWWWWwwwwww#ww#..",
		"..#ww#wwwwwwWWWWWWWWwwwwww#ww#..",
		"...#w#wwwwwwWWWWWWWWwwwwww#w#...",
		"....##wwwwwwWWWWWWWWwwwwww##....",
		".......#WWWWw######wWWWW#.......",
		".......#WWWWw#....#wWWWW#.......",
		".......#WWWWw#....#wWWWW#.......",
		".......#wwwww#....#wwwww#.......",
		".......#ww#ww#....#ww#ww#.......",
		".......###..##....##..###......."
	]

# 🧪 BIO ALCHEMIST (Medic / Support Archetype)
static func get_bio_alchemist_matrix() -> Array:
	return [
		"................................",
		".........##############.........",
		"........#WWWWWWWWWWWWWW#........",
		".......#WWWWWWWWWWWWWWWW#.......",
		"......#WWWWWWWWWWWWWWWWWW#......",
		"......#WWWW############WW#......",
		"......#WWW#EEEEEEEEEEEE#W#......",
		"......#WWW#EEEEEEEEEEEE#W#......",
		"......#WWW##############W#......",
		"......#WWWWWWWWWWWWWWWWWW#......",
		".......#WWWWWWWWWWWWWWWW#.......",
		"........#WWWWWWWWWWWWWW#........",
		".......##WWWWWWWWWWWWWW##.......",
		"......#EEWWWWWWWWWWWWWWEE#......",
		".....#EEEEWWWWWWWWWWWWEEEE#.....",
		"....#EEEEEEWWWWWWWWWWEEEEEE#....",
		"...#EEEEEEEEWWWWWWWWEEEEEEEE#...",
		"...#E#EEEEEEEWWWWWWEEEEEEE#E#...",
		"..#EE#EEEEEEWWWWWWWWEEEEEE#EE#..",
		"..#EE#EEEEEEGGGGGGGGEEEEEE#EE#..",
		"..#EE#EEEEEEGGGGGGGGEEEEEE#EE#..",
		"..#EE#EEEEEEWWWWWWWWEEEEEE#EE#..",
		"..#EE#EEEEEEWWWWWWWWEEEEEE#EE#..",
		"...#E#EEEEEEWWWWWWWWEEEEEE#E#...",
		"....##EEEEEEWWWWWWWWEEEEEE##....",
		".......#WWWWw######wWWWW#.......",
		".......#WWWWw#....#wWWWW#.......",
		".......#WWWWw#....#wWWWW#.......",
		".......#wwwww#....#wwwww#.......",
		".......#ww#ww#....#ww#ww#.......",
		".......###..##....##..###......."
	]

# ✝️ HOLY PALADIN (Guardian / Buffer Archetype)
static func get_holy_paladin_matrix() -> Array:
	return [
		"................................",
		".........##############.........",
		"........#GGGGGGGGGGGGGG#........",
		".......#GGGGGGGGGGGGGGGG#.......",
		"......#GGGGGGGGGGGGGGGGGG#......",
		"......#GGGG############GG#......",
		"......#GGG#EEEEEEEEEEEE#G#......",
		"......#GGG#EEEEEEEEEEEE#G#......",
		"......#GGG##############G#......",
		"......#GGGGGGGGGGGGGGGGGG#......",
		".......#GGGGGGGGGGGGGGGG#.......",
		"........#GGGGGGGGGGGGGG#........",
		".......##GGGGGGGGGGGGGG##.......",
		"......#AAGGGGGGGGGGGGGGAA#......",
		".....#AAAAGGGGGGGGGGGGAAAA#.....",
		"....#AAAAAAGGGGGGGGGGAAAAAA#....",
		"...#AAAAAAAAGGGGGGGGAAAAAAAA#...",
		"...#A#AAAAAAAGGGGGGAAAAAAA#A#...",
		"..#AA#AAAAAEGGGGGGGGEAAAAA#AA#..",
		"..#AA#AAAAAEGGGGGGGGEAAAAA#AA#..",
		"..#AA#AAAAAEGGGGGGGGEAAAAA#AA#..",
		"..#AA#AAAAAAGGGGGGGGAAAAAA#AA#..",
		"..#AA#AAAAAAGGGGGGGGAAAAAA#AA#..",
		"...#A#AAAAAAGGGGGGGGAAAAAA#A#...",
		"....##AAAAAAGGGGGGGGAAAAAA##....",
		".......#GGGGg######gGGGG#.......",
		".......#GGGGg#....#gGGGG#.......",
		".......#GGGGg#....#gGGGG#.......",
		".......#ggggg#....#ggggg#.......",
		".......#gg#gg#....#gg#gg#.......",
		".......###..##....##..###......."
	]

# 🗡️ CYBER TEMPLAR (Melee Assassin Archetype)
static func get_cyber_templar_matrix() -> Array:
	return [
		"................................",
		".........##############.........",
		"........#EEEEEEEEEEEEEE#........",
		".......#EEEEEEEEEEEEEEEE#.......",
		"......#EEEEEEEEEEEEEEEEEE#......",
		"......#EEEE############EE#......",
		"......#EEE#RRRRRRRRRRRR#E#......",
		"......#EEE#RRRRRRRRRRRR#E#......",
		"......#EEE##############E#......",
		"......#EEEEEEEEEEEEEEEEEE#......",
		".......#EEEEEEEEEEEEEEEE#.......",
		"........#EEEEEEEEEEEEEE#........",
		".......##EEEEEEEEEEEEEE##.......",
		"......#KKEESEEEEEEEEEEESEEKK#...",
		".....#KKKKEESEEEEEEEEESEEKKKK#..",
		"....#KKKKKKEESEEEEEEESEEKKKKKK#.",
		"...#KKKKKKKKEESEEEEEESEEKKKKKKKK",
		"...#K#KKKKKKKEESEEEEESEEKKKKKK#K",
		"..#KK#KKKKKKKEESEEEEESEEKKKKKK#K",
		"..#KK#KKKKKKKGGGGGGGGKKKKKKKKK#K",
		"..#KK#KKKKKKKGGGGGGGGKKKKKKKKK#K",
		"..#KK#KKKKKKKEESEEEEESEEKKKKKK#K",
		"..#KK#KKKKKKKEESEEEEESEEKKKKKK#K",
		"...#K#KKKKKKKEESEEEEESEEKKKKKK#K",
		"....##KKKKKKKEESEEEEESEEKKKKKK##",
		".......#EEEEe######eEEEE#.......",
		".......#EEEEe#....#eEEEE#.......",
		".......#EEEEe#....#eEEEE#.......",
		".......#eeeee#....#eeeee#.......",
		".......#ee#ee#....#ee#ee#.......",
		".......###..##....##..###......."
	]

static func get_matrix_by_name(cname: String) -> Array:
	if cname.contains("Bio") or cname.contains("Alchemist") or cname.contains("Medic"):
		return get_bio_alchemist_matrix()
	elif cname.contains("Holy") or cname.contains("Paladin") or cname.contains("Guardian"):
		return get_holy_paladin_matrix()
	elif cname.contains("Cyber") or cname.contains("Templar"):
		return get_cyber_templar_matrix()
	elif cname.contains("Night") or cname.contains("Nocturnal"):
		return get_night_terror_matrix()
	elif cname.contains("Shadow") or cname.contains("Ninja") or cname.contains("Nimble"):
		return get_shadow_dancer_matrix()
	elif cname.contains("Feral") or cname.contains("Ranger"):
		return get_feral_ranger_matrix()
	else:
		return get_iron_defender_matrix()
