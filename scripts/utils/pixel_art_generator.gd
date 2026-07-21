# ═══════════════════════════════════════════════════════════════
#  PIXEL ART GENERATOR (pixel_art_generator.gd) — Commercial Grade
#  Động cơ sinh Texture Pixel Art 16-bit SNES chuẩn Commercial Premium
# ═══════════════════════════════════════════════════════════════
class_name PixelArtGenerator

static func create_unit_texture(unit_type: int, color_theme: Color, width: int = 48, height: int = 48) -> ImageTexture:
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	var border_color := Color(0.05, 0.05, 0.08, 1.0)
	var highlight := color_theme.lightened(0.3)
	var shadow := color_theme.darkened(0.4)
	
	match unit_type:
		Constants.UnitType.SURVIVOR:
			for x in range(12, 36):
				for y in range(8, 44):
					var c := color_theme
					if y in range(8, 18):
						c = highlight if x in range(16, 32) else color_theme
						if y in range(12, 15) and x in range(18, 30):
							c = Color(0.1, 0.9, 1.0)
					elif y in range(18, 32):
						c = color_theme if (x + y) % 2 == 0 else shadow
						if x in range(20, 28) and y in range(20, 26):
							c = highlight
					elif y in range(32, 44):
						c = shadow
					img.set_pixel(x, y, c)
					
		Constants.UnitType.MONSTER:
			for x in range(8, 40):
				for y in range(10, 42):
					var dist: float = Vector2(x - 24, y - 26).length()
					if dist < 16.0:
						var c := color_theme.darkened(dist / 20.0)
						if y < 18 and (x in range(14, 18) or x in range(30, 34)):
							c = Color(1.0, 0.2, 0.2)
						if y > 34 and (x % 4 == 0):
							c = Color(0.9, 0.9, 0.8)
						img.set_pixel(x, y, c)
						
		Constants.UnitType.MECHA:
			for x in range(6, 42):
				for y in range(6, 44):
					var c := Color(0.3, 0.35, 0.42)
					if x in range(10, 38) and y in range(10, 38):
						c = color_theme
						if x in range(20, 28) and y in range(20, 28):
							c = Color(0.2, 1.0, 0.5)
					if (x + y) % 4 == 0:
						c = c.lightened(0.25)
					img.set_pixel(x, y, c)

	for x in range(1, width - 1):
		for y in range(1, height - 1):
			if img.get_pixel(x, y).a > 0.0:
				for dx in [-1, 0, 1]:
					for dy in [-1, 0, 1]:
						if img.get_pixel(x + dx, y + dy).a == 0.0:
							img.set_pixel(x + dx, y + dy, border_color)
							
	return ImageTexture.create_from_image(img)

static func create_room_icon(room_type: int) -> ImageTexture:
	var img := Image.create(32, 32, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	var base_col := Color(0.2, 0.6, 0.9)
	match room_type:
		Constants.RoomType.BUNKER: base_col = Color(0.3, 0.7, 0.4)
		Constants.RoomType.RADIO_TOWER: base_col = Color(0.9, 0.7, 0.2)
		Constants.RoomType.ARMORY: base_col = Color(0.8, 0.3, 0.3)
		Constants.RoomType.TRADING_POST: base_col = Color(0.9, 0.8, 0.3)
		Constants.RoomType.WORKSHOP: base_col = Color(0.7, 0.5, 0.3)
		Constants.RoomType.BEAST_PEN: base_col = Color(0.8, 0.2, 0.6)
		Constants.RoomType.MECHA_HANGAR: base_col = Color(0.2, 0.8, 0.8)
		Constants.RoomType.COMMAND_CENTER: base_col = Color(0.9, 0.4, 0.2)
		
	# Draw detailed 16-bit room badge icon
	for x in range(4, 28):
		for y in range(4, 28):
			var dist := Vector2(x - 16, y - 16).length()
			if dist < 12.0:
				var c := base_col.darkened(dist / 24.0)
				if x in range(14, 18) or y in range(14, 18):
					c = c.lightened(0.4)
				img.set_pixel(x, y, c)
				
	# Border
	for x in range(32):
		for y in range(32):
			if img.get_pixel(x, y).a > 0.0:
				if x == 0 or x == 31 or y == 0 or y == 31:
					img.set_pixel(x, y, Color(0.1, 0.1, 0.1, 1.0))
					
	return ImageTexture.create_from_image(img)

static func create_currency_icon(currency_type: int) -> ImageTexture:
	var img := Image.create(16, 16, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	var col := Color(1.0, 0.8, 0.2)
	match currency_type:
		Constants.Currency.GOLD: col = Color(1.0, 0.8, 0.2)
		Constants.Currency.ALLOYS: col = Color(0.6, 0.7, 0.8)
		Constants.Currency.ENERGY: col = Color(0.2, 0.9, 1.0)
		Constants.Currency.CRYSTALS: col = Color(0.9, 0.3, 0.9)
		
	for x in range(2, 14):
		for y in range(2, 14):
			if Vector2(x - 8, y - 8).length() < 6.0:
				img.set_pixel(x, y, col)
				
	return ImageTexture.create_from_image(img)

static func create_item_icon(item_type: int, rarity_color: Color) -> ImageTexture:
	var img := Image.create(32, 32, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	for x in range(2, 30):
		for y in range(2, 30):
			img.set_pixel(x, y, rarity_color.darkened(0.65))
			
	match item_type:
		Constants.ItemType.WEAPON:
			for i in range(6, 26):
				img.set_pixel(i, 31 - i, Color(0.95, 0.95, 1.0))
				img.set_pixel(i + 1, 31 - i, Color(0.7, 0.75, 0.8))
			for x in range(6, 12):
				img.set_pixel(x, 31 - x + 4, Color(0.6, 0.4, 0.2))
				
		Constants.ItemType.ARMOR:
			for x in range(8, 24):
				for y in range(8, 24):
					var col := rarity_color.lightened(0.2) if y < 14 else rarity_color.darkened(0.2)
					img.set_pixel(x, y, col)
					
		Constants.ItemType.ACCESSORY:
			for x in range(10, 22):
				for y in range(10, 22):
					if Vector2(x - 16, y - 16).length() < 6.0:
						img.set_pixel(x, y, Color(0.2, 0.9, 1.0))
						
		Constants.ItemType.MATERIAL:
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
			if (x * 17 + y * 31) % 109 == 0:
				col = col.lightened(0.2)
			img.set_pixel(x, y, col)
	return ImageTexture.create_from_image(img)
