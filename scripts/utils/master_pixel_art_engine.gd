# ═══════════════════════════════════════════════════════════════
#  MASTER PIXEL ART ENGINE (master_pixel_art_engine.gd) — Modular Facade AAA 2.0
#  Động cơ sinh Texture Pixel Art 16-bit/64-bit SNES 16-Frame Spritesheet
#  TÍCH HỢP HIỆU ỨNG VŨ KHÍ & TRANG BỊ HIỆN ĐẠI TƯƠNG ỨNG TRÊN SPRITE SHEET!
# ═══════════════════════════════════════════════════════════════
class_name MasterPixelArtEngine

const CharMatrices = preload("res://scripts/utils/pixel_art/character_pixel_matrices.gd")
const GearMatrices = preload("res://scripts/utils/pixel_art/modern_gear_matrices.gd")
const CharProfiles = preload("res://scripts/data/character_animation_profiles.gd")

const PALETTE := {
	".": Color(0, 0, 0, 0),         # Transparent
	"#": Color(0.06, 0.05, 0.1, 1),  # Dark Outline
	"K": Color(0.65, 0.7, 0.78, 1),  # Steel Plate / Gun Metal
	"H": Color(0.88, 0.92, 0.98, 1),  # Steel Highlight
	"S": Color(0.32, 0.36, 0.44, 1),  # Steel Shadow
	"G": Color(0.95, 0.8, 0.25, 1),  # Gold Accent
	"g": Color(0.72, 0.58, 0.15, 1),  # Dark Gold
	"R": Color(0.9, 0.2, 0.25, 1),   # Ruby Red / Laser
	"r": Color(0.5, 0.1, 0.15, 1),   # Dark Red / Cape
	"F": Color(0.92, 0.74, 0.62, 1), # Flesh Skin Tone
	"f": Color(0.75, 0.55, 0.45, 1), # Skin Shadow
	"E": Color(0.2, 0.85, 1.0, 1),   # Cyan Plasma Glow / Visor
	"P": Color(0.7, 0.3, 0.85, 1),   # Purple Energy / Quantum
	"p": Color(0.4, 0.15, 0.55, 1),  # Dark Purple
	"W": Color(0.25, 0.55, 0.3, 1),  # Forest Green / Kevlar
	"w": Color(0.15, 0.35, 0.2, 1),  # Dark Green
	"B": Color(0.45, 0.28, 0.16, 1), # Oak Wood Brown
	"b": Color(0.28, 0.16, 0.08, 1), # Dark Wood
	"A": Color(0.95, 0.95, 0.9, 1),  # White / Silver
	"O": Color(0.95, 0.55, 0.15, 1), # Orange / Fire Flame
	"I": Color(0.4, 0.75, 0.95, 1),  # Ice Blue
	"i": Color(0.2, 0.5, 0.75, 1),   # Dark Ice Blue
	"Y": Color(0.95, 0.95, 0.3, 1),  # Electric Yellow Shock
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

# ─── 16-FRAME SPRITESHEET MATRIX GENERATOR (CLASS-SPECIFIC ANIMATIONS) ─────
static func get_unit_16frame_texture(cname: String, anim_state: String = "idle", frame_idx: int = 0) -> ImageTexture:
	var base_matrix := CharMatrices.get_matrix_by_name(cname)
	
	# Lookup Character Profile for Assigned Weapon & Gear
	var profile: Dictionary = {}
	for pid in CharProfiles.PROFILES:
		if CharProfiles.PROFILES[pid].get("name") == cname:
			profile = CharProfiles.PROFILES[pid]
			break
			
	var weapon_name: String = str(profile.get("equipped_weapon", "Plasma Rifle"))
	var armor_name: String = str(profile.get("equipped_armor", "Titan Exo"))
	
	var modified_matrix := _apply_class_and_gear_animations(base_matrix, cname, weapon_name, armor_name, anim_state, frame_idx)
	return matrix_to_texture(modified_matrix, 2)

static func _apply_class_and_gear_animations(base_matrix: Array, cname: String, weapon_name: String, armor_name: String, anim_state: String, frame_idx: int) -> Array:
	var h: int = base_matrix.size()
	var new_matrix: Array = []
	var y_offset := 0
	var x_offset := 0
	var flash_red := false
	
	# Determine Class Archetype
	var class_type := "Brute"
	if cname.contains("Night") or cname.contains("Viper") or cname.contains("Assassin") or cname.contains("Nocturnal"):
		class_type = "Nocturnal"
	elif cname.contains("Shadow") or cname.contains("Rogue") or cname.contains("Phantom") or cname.contains("Nimble"):
		class_type = "Nimble"
	elif cname.contains("Tempest") or cname.contains("Hailstorm") or cname.contains("Feral") or cname.contains("Beast"):
		class_type = "Feral"
	elif cname.contains("King") or cname.contains("Pilot") or cname.contains("Mech") or cname.contains("Holy"):
		class_type = "Pilot"

	match class_type:
		"Brute":
			match anim_state:
				"idle":
					if frame_idx == 1: y_offset = -1
					elif frame_idx == 3: y_offset = 1
				"walk":
					y_offset = (frame_idx % 2) * 2
				"attack":
					if frame_idx == 1: y_offset = -3
					elif frame_idx == 2: y_offset = 4
				"hit":
					x_offset = -2
					if frame_idx == 1: flash_red = true

		"Nimble":
			match anim_state:
				"idle":
					if frame_idx == 1: x_offset = 1
					elif frame_idx == 3: x_offset = -1
				"walk":
					x_offset = (frame_idx % 2) * 3
				"attack":
					if frame_idx == 1: x_offset = 4
					elif frame_idx == 2: x_offset = 6
				"hit":
					x_offset = -4
					if frame_idx == 1: flash_red = true

		"Nocturnal":
			match anim_state:
				"idle":
					if frame_idx == 0: y_offset = 0
					elif frame_idx == 1: y_offset = -2
					elif frame_idx == 2: y_offset = -4
					elif frame_idx == 3: y_offset = -2
				"walk":
					y_offset = -3
					x_offset = (frame_idx % 2) * 2
				"attack":
					y_offset = -5
				"hit":
					if frame_idx == 1: flash_red = true

		"Feral":
			match anim_state:
				"idle":
					if frame_idx == 1: y_offset = -1
				"walk":
					y_offset = (frame_idx % 2) * 2
				"attack":
					if frame_idx == 1: x_offset = -4
					elif frame_idx == 2: x_offset = 2
				"hit":
					x_offset = -3
					if frame_idx == 1: flash_red = true

		_:
			match anim_state:
				"idle":
					if frame_idx % 2 == 1: y_offset = -2
				"walk":
					y_offset = -3
					x_offset = (frame_idx % 2) * 4
				"attack":
					if frame_idx == 1: y_offset = -4
				"hit":
					x_offset = -2
					if frame_idx == 1: flash_red = true

	# Apply Offsets, Weapon Gear Overlay & Attack Particle Effects
	for y in range(h):
		var src_y := y - y_offset
		if src_y >= 0 and src_y < h:
			var row: String = base_matrix[src_y]
			
			# Apply Horizontal Shift
			if x_offset > 0:
				row = ".".repeat(x_offset) + row.substr(0, 32 - x_offset)
			elif x_offset < 0:
				var abs_x: int = abs(x_offset)
				row = row.substr(abs_x) + ".".repeat(abs_x)
				
			if flash_red:
				row = row.replace("K", "R").replace("H", "O").replace("F", "R")
			else:
				# OVERLAY WEAPON GEAR & ATTACK VFX ACCORDING TO EQUIPPED WEAPON
				if weapon_name.contains("Plasma"):
					# Cyan Plasma Barrel on right hand + Laser Beam during attack
					if src_y in [16, 17]:
						if anim_state == "attack":
							row = row.substr(0, 20) + "EEEEEEEEEEEE" # Cyan laser beam extending 12px
						else:
							row = row.substr(0, 22) + "EEEEEE"
				elif weapon_name.contains("Chainsaw") or weapon_name.contains("Sword"):
					# Red Fire Chainsaw Blade + Orange Slash Wave during attack
					if src_y in [14, 15, 16, 17, 18]:
						if anim_state == "attack":
							row = row.substr(0, 20) + "OOOOOOOOOOOO" # Orange fire arc
						else:
							row = row.substr(0, 22) + "RRRRRR"
				elif weapon_name.contains("Railgun"):
					# Heavy Railgun Barrel + Electric Yellow Lightning Arc during attack
					if src_y in [16, 17, 18]:
						if anim_state == "attack":
							row = row.substr(0, 20) + "YYYYYYYYYYYY" # Yellow shock arc
						else:
							row = row.substr(0, 22) + "YYYYYY"
				elif weapon_name.contains("Sniper"):
					# Silver Rifle Barrel + Thin Red Target Laser Beam during attack
					if src_y == 16:
						if anim_state == "attack":
							row = row.substr(0, 20) + "RRRRRRRRRRRR" # Thin red sniper laser line
						else:
							row = row.substr(0, 22) + "AAAAAA"
							
				# OVERLAY ARMOR ACCENTS (Titan Exo Golden Shoulders)
				if armor_name.contains("Titan") or armor_name.contains("Exo"):
					if src_y in [12, 13]:
						row = row.substr(0, 10) + "GG" + row.substr(12, 8) + "GG" + row.substr(22)
				
			new_matrix.append(row)
		else:
			new_matrix.append("................................")
			
	return new_matrix

static func get_modern_gear_texture(gear_name: String) -> ImageTexture:
	return matrix_to_texture(GearMatrices.get_gear_matrix(gear_name), 2)

static func get_adventurer_texture(cname: String) -> ImageTexture:
	return get_unit_16frame_texture(cname, "idle", 0)

static func get_item_texture(itype: int) -> ImageTexture:
	match itype:
		Constants.ItemType.WEAPON: return get_modern_gear_texture("Plasma Rifle")
		Constants.ItemType.ARMOR: return get_modern_gear_texture("Titan Exo")
		Constants.ItemType.ACCESSORY: return get_modern_gear_texture("Cyber Visor")
		_: return get_modern_gear_texture("Cyber Visor")
