# ═══════════════════════════════════════════════════════════════
#  PIXEL ART GENERATOR (pixel_art_generator.gd) — Commercial Grade 16-Bit
#  Động cơ sinh Texture Pixel Art 16-bit SNES chuẩn Commercial Premium
# ═══════════════════════════════════════════════════════════════
class_name PixelArtGenerator

# ─── 1. Facility Wooden Hanging Sign Icon ──────────────────────
static func create_room_icon(room_type: int, size: int = 40) -> ImageTexture:
	var img := Image.create(size, size, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	# Draw Chain Links at Top
	var chain_col := Color(0.65, 0.65, 0.7)
	var chain_dark := Color(0.25, 0.25, 0.3)
	for y in range(0, 8):
		img.set_pixel(10, y, chain_col if y % 2 == 0 else chain_dark)
		img.set_pixel(11, y, chain_col if y % 2 == 0 else chain_dark)
		img.set_pixel(size - 12, y, chain_col if y % 2 == 0 else chain_dark)
		img.set_pixel(size - 11, y, chain_col if y % 2 == 0 else chain_dark)

	# Draw Oak Wooden Signboard (y from 6 to size-2)
	var wood_base := Color(0.35, 0.22, 0.12)
	var wood_light := Color(0.52, 0.34, 0.18)
	var wood_dark := Color(0.22, 0.13, 0.07)
	var border := Color(0.12, 0.07, 0.03)

	for x in range(4, size - 4):
		for y in range(6, size - 2):
			var c := wood_base
			if (y % 6 == 0 or y % 6 == 1) and (x % 3 != 0):
				c = wood_light
			elif (y % 4 == 2) and (x % 5 == 0):
				c = wood_dark
			img.set_pixel(x, y, c)

	# Wooden Sign Border
	for x in range(4, size - 4):
		img.set_pixel(x, 6, border)
		img.set_pixel(x, size - 3, border)
	for y in range(6, size - 2):
		img.set_pixel(4, y, border)
		img.set_pixel(size - 5, y, border)

	# Draw 16-Bit Pixel Emblems Inside
	var center_x := size / 2
	var center_y := (size + 4) / 2
	
	match room_type:
		Constants.RoomType.BUNKER: # QUARTERS: Gold Crescent Moon & Stars
			var moon_col := Color(0.95, 0.82, 0.3)
			for x in range(center_x - 5, center_x + 5):
				for y in range(center_y - 6, center_y + 6):
					var dist := Vector2(x - (center_x - 1), y - center_y).length()
					var cut := Vector2(x - (center_x + 2), y - (center_y - 1)).length()
					if dist <= 5.5 and cut >= 3.8:
						img.set_pixel(x, y, moon_col)
			img.set_pixel(center_x + 4, center_y - 4, Color(1, 1, 0.8))
			img.set_pixel(center_x + 5, center_y + 3, Color(1, 1, 0.8))
			
		Constants.RoomType.RADIO_TOWER: # TAVERN: Frothy Beer Mug
			var mug_col := Color(0.7, 0.45, 0.2)
			var foam_col := Color(0.95, 0.95, 0.9)
			var beer_col := Color(0.95, 0.75, 0.2)
			for x in range(center_x - 5, center_x + 5):
				for y in range(center_y - 5, center_y + 5):
					if y in range(center_y - 5, center_y - 2):
						img.set_pixel(x, y, foam_col)
					elif y in range(center_y - 2, center_y + 4):
						img.set_pixel(x, y, beer_col)
			for y in range(center_y - 2, center_y + 3):
				img.set_pixel(center_x - 6, y, mug_col)
				
		Constants.RoomType.ARMORY: # STORAGE: Wooden Chest / Crate
			var crate_wood := Color(0.45, 0.28, 0.15)
			var crate_iron := Color(0.6, 0.65, 0.7)
			for x in range(center_x - 6, center_x + 6):
				for y in range(center_y - 5, center_y + 5):
					var c := crate_wood
					if x == center_x - 6 or x == center_x + 5 or y == center_y - 5 or y == center_y + 4 or x == center_x or y == center_y:
						c = crate_iron
					img.set_pixel(x, y, c)
					
		Constants.RoomType.TRADING_POST: # MARKET: Gold Pouch & Coins
			var pouch_col := Color(0.85, 0.65, 0.25)
			var tie_col := Color(0.8, 0.2, 0.2)
			for x in range(center_x - 5, center_x + 5):
				for y in range(center_y - 4, center_y + 5):
					var dist := Vector2(x - center_x, y - (center_y + 1)).length()
					if dist <= 4.5:
						img.set_pixel(x, y, pouch_col)
			img.set_pixel(center_x - 1, center_y - 3, tie_col)
			img.set_pixel(center_x, center_y - 3, tie_col)
			img.set_pixel(center_x + 1, center_y - 3, tie_col)
			
		Constants.RoomType.WORKSHOP: # WORKSHOP: Metal Anvil
			var anvil_col := Color(0.4, 0.45, 0.5)
			for x in range(center_x - 7, center_x + 7):
				for y in range(center_y - 4, center_y + 4):
					if y in range(center_y - 4, center_y - 1) and x in range(center_x - 6, center_x + 6):
						img.set_pixel(x, y, anvil_col)
					elif y in range(center_y - 1, center_y + 2) and x in range(center_x - 3, center_x + 3):
						img.set_pixel(x, y, anvil_col)
					elif y in range(center_y + 2, center_y + 4) and x in range(center_x - 5, center_x + 5):
						img.set_pixel(x, y, anvil_col)
						
		Constants.RoomType.BEAST_PEN: # SHELTER: Pet Bone
			var bone_col := Color(0.9, 0.9, 0.85)
			for i in range(-5, 6):
				img.set_pixel(center_x + i, center_y + i / 2, bone_col)
				img.set_pixel(center_x + i, center_y + i / 2 + 1, bone_col)
			img.set_pixel(center_x - 5, center_y - 3, bone_col)
			img.set_pixel(center_x - 6, center_y - 2, bone_col)
			img.set_pixel(center_x + 5, center_y + 3, bone_col)
			img.set_pixel(center_x + 6, center_y + 2, bone_col)
			
		_: # Default Shield
			var shield_col := Color(0.7, 0.3, 0.3)
			for x in range(center_x - 5, center_x + 5):
				for y in range(center_y - 5, center_y + 6):
					if abs(x - center_x) + (y - (center_y - 5)) / 2 <= 5:
						img.set_pixel(x, y, shield_col)

	return ImageTexture.create_from_image(img)

# ─── 2. Adventurer 16-Bit Pixel Art Portrait By Character Name ───────
static func create_unit_portrait_by_name(cname: String, width: int = 48, height: int = 48) -> ImageTexture:
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	var border := Color(0.08, 0.08, 0.12)
	var skin_col := Color(0.9, 0.72, 0.6)
	
	# Determine Character Archetype
	if cname.contains("Night") or cname.contains("Shadow") or cname.contains("Viper") or cname.contains("Assassin"):
		# 🥷 NIMBLE / ASSASSIN ARCHETYPE: Black Ninja Hood, Cyan Visor Slit, Dual Daggers
		var hood_col := Color(0.15, 0.18, 0.22)
		var hood_dark := Color(0.08, 0.1, 0.14)
		var visor_col := Color(0.2, 0.85, 0.8) # Cyan stealth glow
		
		# Hood
		for x in range(12, 36):
			for y in range(6, 26):
				img.set_pixel(x, y, hood_col if (x + y) % 2 == 0 else hood_dark)
		# Eyes Slit
		for x in range(16, 32):
			for y in range(15, 18):
				img.set_pixel(x, y, visor_col)
		# Leather Vest & Shoulder Straps
		for x in range(10, 38):
			for y in range(26, 44):
				var c := Color(0.25, 0.2, 0.18)
				if x in range(14, 18) or x in range(30, 34):
					c = Color(0.45, 0.3, 0.2) # Leather straps
				img.set_pixel(x, y, c)

	elif cname.contains("Terror") or cname.contains("Blood") or cname.contains("Soul") or cname.contains("Necro"):
		# 🔮 NOCTURNAL ARCHETYPE: Crimson Robes, Skull Mask, Glowing Red Horns
		var robe_col := Color(0.45, 0.12, 0.2)
		var skull_col := Color(0.85, 0.85, 0.8)
		var eye_red := Color(1.0, 0.1, 0.2)
		
		# Red Horns
		for y in range(4, 14):
			img.set_pixel(14 - y / 2, y, Color(0.3, 0.05, 0.1))
			img.set_pixel(34 + y / 2, y, Color(0.3, 0.05, 0.1))
		# Skull Face
		for x in range(16, 32):
			for y in range(12, 24):
				img.set_pixel(x, y, skull_col)
		# Red Eye Sockets
		img.set_pixel(19, 16, eye_red)
		img.set_pixel(20, 16, eye_red)
		img.set_pixel(27, 16, eye_red)
		img.set_pixel(28, 16, eye_red)
		# Crimson Robe
		for x in range(10, 38):
			for y in range(24, 44):
				img.set_pixel(x, y, robe_col if (x + y) % 2 == 0 else Color(0.3, 0.08, 0.14))

	elif cname.contains("Tempest") or cname.contains("Hailstorm") or cname.contains("Beast") or cname.contains("Feral"):
		# 🏹 FERAL ARCHETYPE: Dragon Horn, Forest Camo Cloak, Leather Cap
		var cap_col := Color(0.25, 0.45, 0.25)
		var horn_col := Color(0.9, 0.7, 0.2)
		
		# Dragon Horn
		for y in range(2, 12):
			img.set_pixel(24 + (12 - y) / 3, y, horn_col)
		# Skin Face
		for x in range(16, 32):
			for y in range(12, 24):
				img.set_pixel(x, y, skin_col)
		# Hunter Cap
		for x in range(14, 34):
			for y in range(8, 15):
				img.set_pixel(x, y, cap_col)
		# Camo Armor
		for x in range(10, 38):
			for y in range(24, 44):
				var c := cap_col if (x + y) % 3 != 0 else Color(0.35, 0.25, 0.15)
				img.set_pixel(x, y, c)

	elif cname.contains("King") or cname.contains("Holy") or cname.contains("Pilot") or cname.contains("Mech"):
		# 🤖 PILOT / DRAGON BLOOD ARCHETYPE: Royal Golden Crown & Plasma Visor
		var gold_col := Color(0.9, 0.75, 0.25)
		var plasma_col := Color(0.1, 0.85, 1.0)
		
		# Golden Crown Top
		for x in range(16, 32):
			if x % 3 == 0:
				img.set_pixel(x, 6, gold_col)
				img.set_pixel(x, 7, gold_col)
			img.set_pixel(x, 8, gold_col)
			img.set_pixel(x, 9, gold_col)
		# Full Glass Visor
		for x in range(16, 32):
			for y in range(12, 22):
				img.set_pixel(x, y, plasma_col if (x + y) % 2 == 0 else Color(0.05, 0.6, 0.8))
		# Golden Chest Armor
		for x in range(10, 38):
			for y in range(22, 44):
				img.set_pixel(x, y, gold_col if (x + y) % 2 == 0 else Color(0.7, 0.55, 0.15))

	else: # 🛡️ BRUTE ARCHETYPE (Iron Defender, Titan Vanguard, Colossus, etc.)
		# Steel Horned Plate Helmet, Red Eye Slit, Heavy Pauldrons
		var steel_base := Color(0.35, 0.4, 0.5)
		var steel_light := Color(0.6, 0.65, 0.75)
		var eye_red := Color(1.0, 0.2, 0.2)
		
		# Horns
		for y in range(4, 12):
			img.set_pixel(14 - y / 2, y, steel_light)
			img.set_pixel(34 + y / 2, y, steel_light)
		# Steel Helmet
		for x in range(14, 34):
			for y in range(8, 24):
				img.set_pixel(x, y, steel_base)
		# Visor T-Slit
		for x in range(18, 30):
			img.set_pixel(x, 16, eye_red)
		for y in range(14, 20):
			img.set_pixel(24, y, eye_red)
		# Heavy Steel Armor & Pauldrons
		for x in range(8, 40):
			for y in range(24, 44):
				var c := steel_base
				if x < 14 or x > 34: c = steel_light # Heavy Pauldrons
				img.set_pixel(x, y, c)

	# Outer Outline Border
	for x in range(1, width - 1):
		for y in range(1, height - 1):
			if img.get_pixel(x, y).a > 0.0:
				for dx in [-1, 0, 1]:
					for dy in [-1, 0, 1]:
						if img.get_pixel(x + dx, y + dy).a == 0.0:
							img.set_pixel(x + dx, y + dy, border)

	return ImageTexture.create_from_image(img)

# ─── Legacy Wrapper ──────────────────────────────────────────
static func create_unit_texture(unit_type: int, color_theme: Color, width: int = 48, height: int = 48) -> ImageTexture:
	return create_unit_portrait_by_name("Brute", width, height)

# ─── 3. Landscape Pixel Art Banner Header ─────────────────────
static func create_landscape_banner(banner_name: String, width: int = 320, height: int = 110) -> ImageTexture:
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	img.fill(Color(0.12, 0.12, 0.14))
	
	if banner_name.contains("Obsidian") or banner_name.contains("Digging"): # Dark Gothic Catacomb Mines
		var sky_col := Color(0.15, 0.15, 0.2)
		var pillar_col := Color(0.25, 0.28, 0.35)
		var arch_col := Color(0.35, 0.38, 0.45)
		var torch_col := Color(0.95, 0.55, 0.1)
		
		img.fill(sky_col)
		for p in range(0, width, 40):
			for x in range(p, p + 12):
				for y in range(0, height):
					img.set_pixel(x, y, pillar_col if x % 2 == 0 else arch_col)
		for t in range(20, width, 40):
			for y in range(height - 40, height - 20):
				img.set_pixel(t, y, torch_col if y % 2 == 0 else Color(1, 0.8, 0.2))

	elif banner_name.contains("Grove") or banner_name.contains("Rebels"): # Lush Pixel Forest Grove
		var sky_col := Color(0.18, 0.3, 0.25)
		var leaf_col := Color(0.2, 0.55, 0.3)
		var leaf_light := Color(0.35, 0.7, 0.4)
		var trunk_col := Color(0.4, 0.25, 0.15)
		
		img.fill(sky_col)
		for x in range(width):
			for y in range(0, 60):
				if (x + y) % 4 != 0:
					img.set_pixel(x, y, leaf_col if y % 2 == 0 else leaf_light)
		for t in range(30, width, 60):
			for x in range(t, t + 10):
				for y in range(40, height):
					img.set_pixel(x, y, trunk_col)

	else: # Post-Apocalyptic Barren Wastelands Sunset Sky
		for y in range(height):
			var ratio := float(y) / float(height)
			var sky_col := Color(0.45, 0.2, 0.15).lerp(Color(0.1, 0.08, 0.12), ratio)
			for x in range(width):
				img.set_pixel(x, y, sky_col)
		var wall_col := Color(0.22, 0.2, 0.25)
		for x in range(width):
			var wall_h := int(30.0 + sin(x * 0.05) * 15.0)
			for y in range(height - wall_h, height):
				img.set_pixel(x, y, wall_col if (x + y) % 3 == 0 else Color(0.15, 0.14, 0.18))

	return ImageTexture.create_from_image(img)

# ─── 4. Item 16-Bit Pixel Art Icon ────────────────────────────
static func create_item_icon(item_type: int, color_theme: Color, size: int = 36) -> ImageTexture:
	var img := Image.create(size, size, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	var center := size / 2
	var metal := Color(0.8, 0.8, 0.85)
	var gold := Color(0.95, 0.8, 0.25)
	var shadow := Color(0.15, 0.15, 0.2)

	match item_type:
		Constants.ItemType.WEAPON: # 16-Bit Sword
			for i in range(-10, 11):
				img.set_pixel(center + i, center - i, metal)
				img.set_pixel(center + i + 1, center - i, metal)
			img.set_pixel(center - 6, center + 7, gold)
			img.set_pixel(center - 7, center + 6, gold)
			img.set_pixel(center - 5, center + 8, gold)
			
		Constants.ItemType.ARMOR: # 16-Bit Plate Armor
			for x in range(center - 8, center + 9):
				for y in range(center - 8, center + 9):
					if abs(x - center) + abs(y - center) <= 12:
						img.set_pixel(x, y, color_theme)
			for x in range(center - 10, center - 6):
				for y in range(center - 8, center - 3):
					img.set_pixel(x, y, gold)
			for x in range(center + 7, center + 11):
				for y in range(center - 8, center - 3):
					img.set_pixel(x, y, gold)

		Constants.ItemType.ACCESSORY: # 16-Bit Crown / Ring
			for x in range(center - 8, center + 9):
				for y in range(center - 4, center + 5):
					if y == center - 4 and (x % 4 == 0):
						img.set_pixel(x, y, gold)
					elif y > center - 4:
						img.set_pixel(x, y, gold if (x + y) % 2 == 0 else Color(0.8, 0.6, 0.1))

		_: # Material / Elixir Potion Bottle
			for x in range(center - 6, center + 7):
				for y in range(center - 7, center + 8):
					var dist := Vector2(x - center, y - (center + 1)).length()
					if dist <= 5.5:
						img.set_pixel(x, y, color_theme)
			img.set_pixel(center - 1, center - 6, Color(0.5, 0.3, 0.1))
			img.set_pixel(center, center - 6, Color(0.5, 0.3, 0.1))
			img.set_pixel(center + 1, center - 6, Color(0.5, 0.3, 0.1))

	# Border
	for x in range(1, size - 1):
		for y in range(1, size - 1):
			if img.get_pixel(x, y).a > 0.0:
				for dx in [-1, 0, 1]:
					for dy in [-1, 0, 1]:
						if img.get_pixel(x + dx, y + dy).a == 0.0:
							img.set_pixel(x + dx, y + dy, shadow)

	return ImageTexture.create_from_image(img)
