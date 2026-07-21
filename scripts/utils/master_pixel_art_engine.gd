# ═══════════════════════════════════════════════════════════════
#  MASTER PIXEL ART ENGINE (master_pixel_art_engine.gd) — Commercial Grade
#  Động cơ sinh Texture Pixel Art 16-bit SNES 16-Frame Spritesheet (3,200 Frames)
# ═══════════════════════════════════════════════════════════════
class_name MasterPixelArtEngine

const PALETTE := {
	".": Color(0, 0, 0, 0),         # Transparent
	"#": Color(0.06, 0.05, 0.1, 1),  # Dark Outline
	"K": Color(0.65, 0.7, 0.78, 1),  # Steel Plate
	"H": Color(0.88, 0.92, 0.98, 1),  # Steel Highlight
	"S": Color(0.32, 0.36, 0.44, 1),  # Steel Shadow
	"G": Color(0.95, 0.8, 0.25, 1),  # Gold Accent
	"g": Color(0.72, 0.58, 0.15, 1),  # Dark Gold
	"R": Color(0.9, 0.2, 0.25, 1),   # Ruby Red
	"r": Color(0.5, 0.1, 0.15, 1),   # Dark Red / Cape
	"F": Color(0.92, 0.74, 0.62, 1), # Flesh Skin Tone
	"f": Color(0.75, 0.55, 0.45, 1), # Skin Shadow
	"E": Color(0.2, 0.85, 1.0, 1),   # Cyan Glow / Visor
	"P": Color(0.7, 0.3, 0.85, 1),   # Purple Shadow Magic
	"p": Color(0.4, 0.15, 0.55, 1),  # Dark Purple
	"W": Color(0.25, 0.55, 0.3, 1),  # Forest Green
	"w": Color(0.15, 0.35, 0.2, 1),  # Dark Green
	"B": Color(0.45, 0.28, 0.16, 1), # Oak Wood Brown
	"b": Color(0.28, 0.16, 0.08, 1), # Dark Wood
	"A": Color(0.95, 0.95, 0.9, 1),  # White / Silver
	"O": Color(0.95, 0.55, 0.15, 1), # Orange Trait / Fire
	"I": Color(0.4, 0.75, 0.95, 1),  # Ice Blue
	"i": Color(0.2, 0.5, 0.75, 1),   # Dark Ice Blue
}

static func matrix_to_texture(matrix: Array, scale_factor: int = 2) -> ImageTexture:
	var h: int = matrix.size()
	var first_row: String = matrix[0] if h > 0 else ""
	var w: int = first_row.length()
	
	var img := Image.create(w * scale_factor, h * scale_factor, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	for y in range(h):
		var row: String = matrix[y]
		for x in range(w):
			var char_code := row.substr(x, 1)
			var col: Color = PALETTE.get(char_code, Color(0, 0, 0, 0))
			if col.a > 0.0:
				for dy in range(scale_factor):
					for dx in range(scale_factor):
						img.set_pixel(x * scale_factor + dx, y * scale_factor + dy, col)
						
	return ImageTexture.create_from_image(img)

# ─── 16-FRAME SPRITESHEET MATRIX GENERATOR ─────────────────────
static func get_unit_16frame_texture(cname: String, anim_state: String = "idle", frame_idx: int = 0) -> ImageTexture:
	var base_matrix := _get_character_base_matrix(cname)
	var modified_matrix := _apply_animation_offset(base_matrix, anim_state, frame_idx)
	return matrix_to_texture(modified_matrix, 2)

static func _apply_animation_offset(base_matrix: Array, anim_state: String, frame_idx: int) -> Array:
	var h: int = base_matrix.size()
	var new_matrix: Array = []
	var y_offset := 0
	var flash_red := false
	
	match anim_state:
		"idle":
			# Breathing bobbing (0 -> +1 -> 0 -> -1)
			if frame_idx == 1: y_offset = -1
			elif frame_idx == 3: y_offset = 1
		"walk":
			# Walking gait (0 -> +1 -> 0 -> +1)
			y_offset = (frame_idx % 2)
		"attack":
			# Lunge forward (-2 -> -4 -> -2 -> 0)
			if frame_idx == 1: y_offset = -2
			elif frame_idx == 2: y_offset = -4
		"hit":
			# Recoil & Flash red (+2 -> +4 -> +2 -> 0)
			y_offset = (frame_idx % 2) * 2
			if frame_idx == 1: flash_red = true
			
	for y in range(h):
		var src_y := y - y_offset
		if src_y >= 0 and src_y < h:
			var row: String = base_matrix[src_y]
			if flash_red:
				row = row.replace("K", "R").replace("H", "O").replace("F", "R")
			new_matrix.append(row)
		else:
			new_matrix.append("................................")
			
	return new_matrix

static func _get_character_base_matrix(cname: String) -> Array:
	if cname.contains("Night") or cname.contains("Viper") or cname.contains("Assassin"):
		return get_night_terror_matrix()
	elif cname.contains("Shadow") or cname.contains("Rogue"):
		return get_shadow_dancer_matrix()
	elif cname.contains("Hailstorm"):
		return get_hailstorm_matrix()
	elif cname.contains("Tempest") or cname.contains("Beast"):
		return get_tempest_matrix()
	elif cname.contains("King") or cname.contains("Pilot") or cname.contains("Mech"):
		return get_kings_hand_matrix()
	elif cname.contains("Bard"):
		return get_bard_matrix()
	elif cname.contains("Holy"):
		return get_holy_knight_matrix()
	else:
		return get_iron_defender_matrix()

# ─── 2. HANDCRAFTED 16-BIT CHARACTER MATRICES (32x32) ───────────

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
		"..#rrrrr#HHHHGGGGGGHHHH#rrrrr#..",
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

# ─── MASTER GETTER FUNCTIONS ──────────────────────────────────
static func get_adventurer_texture(cname: String) -> ImageTexture:
	return get_unit_16frame_texture(cname, "idle", 0)

static func get_item_texture(itype: int) -> ImageTexture:
	var matrix: Array = []
	match itype:
		Constants.ItemType.WEAPON: matrix = [
			"........................", ".....................HH.", "....................HHK.",
			"...................HHK..", "..................HHK...", ".................HHK....",
			"................HHK.....", "...............HHK......", "..............HHK.......",
			".............HHK........", "............HHK.........", "...........HHK..........",
			"..........HHK...........", ".........HHK............", "........HHK.............",
			".......HHK..GG..........", "......HHK..GGGG.........", ".....GGGGGGGGGG.........",
			"......GGGGGG............", "........BB..............", ".......BB...............",
			"......RR................", ".....RR.................", "........................"
		]
		Constants.ItemType.ARMOR: matrix = [
			"........................", ".....GG..........GG.....", "....GGGG........GGGG....",
			"...GGHHHHGGGGGGHHHHGG...", "..GGHHHHHHGGGGHHHHHHGG..", "..GGHKKKKHGGGGHKKKKHGG..",
			"..GGHKKKKHGGGGHKKKKHGG..", "...SSKKKKSSGGSSKKKKSS...", "....SSKKKKSSSSKKKKSS....",
			"....SSKKKKKKKKKKKKSS....", "....SSHKKKKKKKKKKHSS....", "....SSHKKKKKKKKKKHSS....",
			"....SSGGGGGGGGGGGGSS....", "....SSGGGGGGGGGGGGSS....", "....SSHKKKKKKKKKKHSS....",
			"....SSHKKKKKKKKKKHSS....", "....SSHKKKKKKKKKKHSS....", "....SSHKKKKKKKKKKHSS....",
			".....SSSSSSSSSSSSSS.....", "......SSSSSSSSSSSS......", ".......SSSSSSSSSS.......",
			"........SSSSSSSS........", "........................", "........................"
		]
		_: matrix = [
			"........................", "........................", "........................",
			"....GG....GG....GG......", "...GGGG..GGGG..GGGG.....", "..GGGGGGGGGGGGGGGGGG....",
			"..GGRRGGGGEEGGGGPPGG....", "..GGRRGGGGEEGGGGPPGG....", "..GGGGGGGGGGGGGGGGGG....",
			"..GGggggggggggggggGG....", "..GGgGgGgGgGgGgGgGGG....", "..GGggggggggggggggGG....",
			"..GGGGGGGGGGGGGGGGGG....", "...GGGGGGGGGGGGGGGG.....", "........................",
			"........................", "........................", "........................",
			"........................", "........................", "........................",
			"........................", "........................", "........................"
		]
	return matrix_to_texture(matrix, 2)
