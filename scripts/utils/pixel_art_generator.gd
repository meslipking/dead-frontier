# ═══════════════════════════════════════════════════════════════
#  PIXEL ART GENERATOR (pixel_art_generator.gd)
#  Động cơ sinh Texture Pixel Art 16-bit SNES chuẩn Commercial Premium
# ═══════════════════════════════════════════════════════════════
class_name PixelArtGenerator

static func create_unit_texture(unit_type: int, color_theme: Color, width: int = 48, height: int = 48) -> ImageTexture:
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	var border_color := Color(0.05, 0.05, 0.08, 1.0)
	var highlight := color_theme.lightened(0.3)
	var shadow := color_theme.darkened(0.4)
	
	# Draw detailed 16-bit sprite outline & body structure
	match unit_type:
		Constants.UnitType.SURVIVOR:
			# Tactical Survivor silhouette with armor, visor & boots
			for x in range(12, 36):
				for y in range(8, 44):
					var c := color_theme
					if y in range(8, 18): # Helmet / Head
						c = highlight if x in range(16, 32) else color_theme
						if y in range(12, 15) and x in range(18, 30):
							c = Color(0.1, 0.9, 1.0) # Glowing visor
					elif y in range(18, 32): # Armor Chestplate
						c = color_theme if (x + y) % 2 == 0 else shadow
						if x in range(20, 28) and y in range(20, 26):
							c = highlight # Emblem
					elif y in range(32, 44): # Boots & Legs
						c = shadow
					img.set_pixel(x, y, c)
					
		Constants.UnitType.MONSTER:
			# Beast Monster silhouette with claws, spikes & glowing eyes
			for x in range(8, 40):
				for y in range(10, 42):
					var dist: float = Vector2(x - 24, y - 26).length()
					if dist < 16.0:
						var c := color_theme.darkened(dist / 20.0)
						if y < 18 and (x in range(14, 18) or x in range(30, 34)):
							c = Color(1.0, 0.2, 0.2) # Glowing eyes
						if y > 34 and (x % 4 == 0):
							c = Color(0.9, 0.9, 0.8) # Claws
						img.set_pixel(x, y, c)
						
		Constants.UnitType.MECHA:
			# Heavy Combat Mecha silhouette with metallic plating & core
			for x in range(6, 42):
				for y in range(6, 44):
					var c := Color(0.3, 0.35, 0.42)
					if x in range(10, 38) and y in range(10, 38):
						c = color_theme
						if x in range(20, 28) and y in range(20, 28):
							c = Color(0.2, 1.0, 0.5) # Glowing reactor core
					if (x + y) % 4 == 0:
						c = c.lightened(0.25)
					img.set_pixel(x, y, c)

	# Apply 1-pixel dark border outline around non-transparent pixels
	for x in range(1, width - 1):
		for y in range(1, height - 1):
			if img.get_pixel(x, y).a > 0.0:
				for dx in [-1, 0, 1]:
					for dy in [-1, 0, 1]:
						if img.get_pixel(x + dx, y + dy).a == 0.0:
							img.set_pixel(x + dx, y + dy, border_color)
							
	return ImageTexture.create_from_image(img)

static func create_item_icon(item_type: int, rarity_color: Color) -> ImageTexture:
	var img := Image.create(32, 32, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	# Background item card glow
	for x in range(2, 30):
		for y in range(2, 30):
			img.set_pixel(x, y, rarity_color.darkened(0.65))
			
	# Detailed Item Shapes (32x32)
	match item_type:
		Constants.ItemType.WEAPON:
			# Sword / Blade shape
			for i in range(6, 26):
				img.set_pixel(i, 31 - i, Color(0.95, 0.95, 1.0))
				img.set_pixel(i + 1, 31 - i, Color(0.7, 0.75, 0.8))
			# Hilt
			for x in range(6, 12):
				img.set_pixel(x, 31 - x + 4, Color(0.6, 0.4, 0.2))
				
		Constants.ItemType.ARMOR:
			# Chestplate shape
			for x in range(8, 24):
				for y in range(8, 24):
					var col := rarity_color.lightened(0.2) if y < 14 else rarity_color.darkened(0.2)
					img.set_pixel(x, y, col)
					
		Constants.ItemType.ACCESSORY:
			# Gem Amulet shape
			for x in range(10, 22):
				for y in range(10, 22):
					if Vector2(x - 16, y - 16).length() < 6.0:
						img.set_pixel(x, y, Color(0.2, 0.9, 1.0))
						
		Constants.ItemType.MATERIAL:
			# Gear / Tech scrap shape
			for x in range(8, 24):
				for y in range(8, 24):
					if (x * y) % 3 == 0:
						img.set_pixel(x, y, Color(0.8, 0.85, 0.9))

	return ImageTexture.create_from_image(img)

static func create_zone_bg(bg_color: Color, width: int = 360, height: int = 200) -> ImageTexture:
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	for x in range(width):
		for y in range(height):
			var dist := float(y) / float(height)
			var col := bg_color.darkened(dist * 0.5)
			# Add subtle pixel star / dust noise
			if (x * 17 + y * 31) % 109 == 0:
				col = col.lightened(0.2)
			img.set_pixel(x, y, col)
	return ImageTexture.create_from_image(img)
