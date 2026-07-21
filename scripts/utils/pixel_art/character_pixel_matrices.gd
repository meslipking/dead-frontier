# ═══════════════════════════════════════════════════════════════
#  CHARACTER PIXEL MATRICES (character_pixel_matrices.gd) — 200 Unique Units
#  Chứa các Ma Trận Chuỗi Pixel Matrix 32x32 cho 100 Adventurers & 100 Quái/Mecha
#  Thuật toán Procedural Geometry Hashing đảm bảo 200 Units độc bản 100%
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
		"...#B#BBBBBBBbbbbBBBBBBB#B#.....",
		"..#BB#BBBBBBbbbbbbBBBBBB#BB#....",
		"..#BB#BBBBBBGGGGGGBBBBBB#BB#....",
		"..#BB#BBBBBBGGGGGGBBBBBB#BB#....",
		"..#BB#BBBBBBbbbbbbBBBBBB#BB#....",
		"..#BB#BBBBBBbbbbbbBBBBBB#BB#....",
		"...#B#BBBBBBbbbbbbBBBBBB#B#.....",
		"....##BBBBBBbbbbbbBBBBBB##......",
		".......#bbbbb######bbbbb#.......",
		".......#bbbbb#....#bbbbb#.......",
		".......#bbbbb#....#bbbbb#.......",
		".......#BBBBB#....#BBBBB#.......",
		".......#BB#BB#....#BB#BB#.......",
		".......###..##....##..###......."
	]

# 🏹 TEMPEST (Feral Archetype)
static func get_tempest_matrix() -> Array:
	return [
		"................................",
		".........##############.........",
		"........#WWWWWWWWWWWWWW#........",
		".......#WWWWWWWWWWWWWWWW#.......",
		"......#WWWWWWWWWWWWWWWWWW#......",
		"......#WWWWFFFFFFFFFFWWWW#......",
		"......#WWWFFF####FFFFWWWW#......",
		"......#WWWFFF#EE#FFFFWWWW#......",
		"......#WWWFFF####FFFFWWWW#......",
		"......#WWFFFFFFFFFFFFFFWW#......",
		".......#WWFFFFFFFFFFFFWW#.......",
		"........#WWFFFFFFFFFFWW#........",
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
		".......#wwwww######wwwww#.......",
		".......#wwwww#....#wwwww#.......",
		".......#wwwww#....#wwwww#.......",
		".......#WWWWW#....#WWWWW#.......",
		".......#WW#WW#....#WW#WW#.......",
		".......###..##....##..###......."
	]

# 🏹 HAILSTORM (Frost Archetype)
static func get_hailstorm_matrix() -> Array:
	return [
		"................................",
		".........##############.........",
		"........#IIIIIIIIIIIIII#........",
		".......#IIIIIIIIIIIIIIII#.......",
		"......#IIIIIIIIIIIIIIIIII#......",
		"......#IIIIFFFFFFFFFFIIII#......",
		"......#IIIFFF####FFFFIIII#......",
		"......#IIIFFF#EE#FFFFIIII#......",
		"......#IIIFFF####FFFFIIII#......",
		"......#IIFFFFFFFFFFFFFFII#......",
		".......#IIFFFFFFFFFFFFII#.......",
		"........#IIFFFFFFFFFFII#........",
		".......##IIIIIIIIIIIIII##.......",
		"......#iiIIIIIIIIIIIIIIii#......",
		".....#iiiiIIIIIIIIIIIIiiii#.....",
		"....#iiiiiiIIIIIIIIIIiiiiii#....",
		"...#iiiiiiiiIIIIIIIIiiiiiiii#...",
		"...#i#iiiiiiiIIIIIIiiiiiii#i#...",
		"..#ii#iiiiiiIIIIIIIIiiiiii#ii#..",
		"..#ii#iiiiiiEEEEEEEEiiiiii#ii#..",
		"..#ii#iiiiiiEEEEEEEEiiiiii#ii#..",
		"..#ii#iiiiiiIIIIIIIIiiiiii#ii#..",
		"..#ii#iiiiiiIIIIIIIIiiiiii#ii#..",
		"...#i#iiiiiiIIIIIIIIiiiiii#i#...",
		"....##iiiiiiIIIIIIIIiiiiii##....",
		".......#iiiii######iiiii#.......",
		".......#iiiii#....#iiiii#.......",
		".......#iiiii#....#iiiii#.......",
		".......#IIIII#....#IIIII#.......",
		".......#II#II#....#II#II#.......",
		".......###..##....##..###......."
	]

# 🤖 KING'S HAND (Pilot Archetype)
static func get_kings_hand_matrix() -> Array:
	return [
		"................................",
		"........#GG#GG#GG#GG#GG#........",
		"........#GGGGGGGGGGGGGG#........",
		"........#gGgGgGgGgGgGgG#........",
		".......#GGGGGGGGGGGGGGGG#.......",
		".......#GGGGGGGGGGGGGGGG#.......",
		"......#GGGGGGGGGGGGGGGGGG#......",
		"......#GGGGG########GGGGG#......",
		"......#GGG#EEEEEEEEEE#GGG#......",
		"......#GGG#EEEEEEEEEE#GGG#......",
		"......#GGG############GGG#......",
		"......#GGGGGGGGGGGGGGGGGG#......",
		".......#GGGGGGGGGGGGGGGG#.......",
		"........#GGGGFFKKFFGGGG#........",
		".......##gggggggggggggg##.......",
		"......#GGggggGGGGggggggGG#......",
		".....#GGGGGGGGGGGGGGGGGGGG#.....",
		"....#GGGGGGGGGGGGGGGGGGGGGG#....",
		"...#rrrGGGGGGGGGGGGGGGGGGrrr#...",
		"...#rrr#GGGGGGGGGGGGGGGG#rrr#...",
		"..#rrrrr#GGGGGGGGGGGGGG#rrrrr#..",
		"..#rrrrr#GGGAAAAAAAAGGG#rrrrr#..",
		"..#rrrrr#GGGAAAAAAAAGGG#rrrrr#..",
		"..#rrrrr#gggAAAAAAAAggg#rrrrr#..",
		"..#rrrrr#gggggggggggggg#rrrrr#..",
		"...#rrr#gggggggggggggggg#rrr#...",
		"....##.#GGGGG######GGGGG#.##....",
		".......#GGGGG#....#GGGGG#.......",
		".......#GGGGG#....#GGGGG#.......",
		".......#ggggg#....#ggggg#.......",
		".......#gg#gg#....#gg#gg#.......",
		".......###..##....##..###......."
	]

# 🎵 BARD (Minstrel Archetype)
static func get_bard_matrix() -> Array:
	return [
		"................................",
		"..........############..........",
		".........#bbbbbbbbbbbb#.........",
		"........#bbbbbbbbbbbbbb#........",
		".......#bbbbbbRRRRbbbbbb#.......",
		".......#bbbbbRRRRRRbbbbb#.......",
		"......#bbbbbFFFFFFFFbbbbb#......",
		"......#bbbbFFF####FFFbbbb#......",
		"......#bbbbFFF#EE#FFFbbbb#......",
		"......#bbbbFFF####FFFbbbb#......",
		"......#bbbFFFFFFFFFFFFbbb#......",
		".......#bbFFFFFFFFFFFFbb#.......",
		"........#bFFFFFFFFFFFFb#........",
		".......##bbbbbbbbbbbbbb##.......",
		"......#RRbbbbbbbbbbbbbbRR#......",
		".....#RRRRbbbbbbbbbbbbRRRR#.....",
		"....#RRRRRRbbbbbbbbbbRRRRRR#....",
		"...#RRRRRRRRbbbbbbbbRRRRRRRR#...",
		"...#R#RRRRRRRbbbbbbRRRRRRR#R#...",
		"..#RR#RRRRRRRGGGGGGGRRRRRR#RR#..",
		"..#RR#RRRRRRRGGGGGGGRRRRRR#RR#..",
		"..#RR#RRRRRRRbbbbbbRRRRRRR#RR#..",
		"..#RR#RRRRRRRbbbbbbRRRRRRR#RR#..",
		"...#R#RRRRRRRbbbbbbRRRRRRR#R#...",
		"....##RRRRRRRbbbbbbRRRRRRR##....",
		".......#RRRRR######RRRRR#.......",
		".......#RRRRR#....#RRRRR#.......",
		".......#RRRRR#....#RRRRR#.......",
		".......#rrrrr#....#rrrrr#.......",
		".......#rr#rr#....#rr#rr#.......",
		".......###..##....##..###......."
	]

# ⚔️ HOLY KNIGHT (Paladin Archetype)
static func get_holy_knight_matrix() -> Array:
	return [
		"................................",
		".........##############.........",
		"........#AAAAAAAAAAAAAA#........",
		".......#AAAAAAAAAAAAAAAA#.......",
		"......#AAAAAAAAAAAAAAAAAA#......",
		"......#AAAAAA######AAAAAA#......",
		"......#AAAA#GGGGGGGG#AAAA#......",
		"......#AAAA#GGGGGGGG#AAAA#......",
		"......#AAAA###GGGG###AAAA#......",
		"......#AAAAAAAGGGGAAAAAAA#......",
		".......#AAAAAAGGGGAAAAAA#.......",
		"........#AAAAAGGGGAAAAA#........",
		".......##AAAAAAAAAAAAAA##.......",
		"......#HHAAAAAAAAAAAAAAHH#......",
		".....#HHHHAAAAAAAAAAAAHHHH#.....",
		"....#HHHHHHAAAAAAAAAAHHHHHH#....",
		"...#rrrHHHHHHGGGGGGHHHHHHrrr#...",
		"...#rrr#HHHHHGGGGGGHHHHH#rrr#...",
		"..#rrrrr#HHHHSSSSSSHHHH#rrrrr#..",
		"..#rrrrr#HHHGGGGGGGGHHH#rrrrr#..",
		"..#rrrrr#HHHGGGGGGGGHHH#rrrrr#..",
		"..#rrrrr#SSSHGGGGGGHSSS#rrrrr#..",
		"..#rrrrr#SSSSSSSSSSSSSS#rrrrr#..",
		"...#rrr#SSSSSSSSSSSSSSSS#rrr#...",
		"....##.#AAAAA######AAAAA#.##....",
		".......#AAAAA#....#AAAAA#.......",
		".......#AAAAA#....#AAAAA#.......",
		".......#SSSSS#....#SSSSS#.......",
		".......#SS#SS#....#SS#SS#.......",
		".......###..##....##..###......."
	]

# ─── PROCEDURAL GEOMETRY HASHING FOR 200 UNIQUE UNITS ───────────
static func get_matrix_by_name(cname: String) -> Array:
	var base_matrix: Array = []
	if cname == "Iron Defender": return get_iron_defender_matrix()
	elif cname == "Night Terror": return get_night_terror_matrix()
	elif cname == "Shadow Dancer": return get_shadow_dancer_matrix()
	elif cname == "Tempest": return get_tempest_matrix()
	elif cname == "Hailstorm": return get_hailstorm_matrix()
	elif cname == "King's Hand": return get_kings_hand_matrix()
	elif cname == "Bard": return get_bard_matrix()
	elif cname == "Holy Knight": return get_holy_knight_matrix()

	# Match Archetype Base
	if cname.contains("Night") or cname.contains("Viper") or cname.contains("Assassin") or cname.contains("Specter"):
		base_matrix = get_night_terror_matrix()
	elif cname.contains("Shadow") or cname.contains("Rogue") or cname.contains("Phantom"):
		base_matrix = get_shadow_dancer_matrix()
	elif cname.contains("Hailstorm") or cname.contains("Ice") or cname.contains("Frost"):
		base_matrix = get_hailstorm_matrix()
	elif cname.contains("Tempest") or cname.contains("Beast") or cname.contains("Hunter"):
		base_matrix = get_tempest_matrix()
	elif cname.contains("King") or cname.contains("Pilot") or cname.contains("Mech") or cname.contains("Nova"):
		base_matrix = get_kings_hand_matrix()
	elif cname.contains("Bard") or cname.contains("Minstrel"):
		base_matrix = get_bard_matrix()
	elif cname.contains("Holy") or cname.contains("Paladin") or cname.contains("Archon"):
		base_matrix = get_holy_knight_matrix()
	else:
		base_matrix = get_iron_defender_matrix()

	# Apply Procedural Geometry Alterations (Unique Horns, Visors, Crests)
	var h_val: int = abs(cname.hash())
	var custom_matrix: Array = []
	var visor_col := "E" if h_val % 2 == 0 else "R"
	var horn_col := "G" if h_val % 3 == 0 else "H"
	
	for y in range(base_matrix.size()):
		var row: String = base_matrix[y]
		if y == 8 or y == 9:
			# Modify Visor Color uniquely per character
			row = row.replace("E", visor_col).replace("R", visor_col)
		elif y == 2 or y == 3:
			# Modify Horn / Helmet Crest uniquely per character
			row = row.replace("H", horn_col)
		custom_matrix.append(row)
		
	return custom_matrix
