# ═══════════════════════════════════════════════════════════════
#  PIXEL ART GENERATOR (pixel_art_generator.gd)
#  Tự động sinh texture Pixel Art 16-bit SNES style cho Game
# ═══════════════════════════════════════════════════════════════
class_name PixelArtGenerator

static func create_unit_texture(unit_type: int, color_theme: Color, width: int = 32, height: int = 32) -> ImageTexture:
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))  # Transparent
	
	# Draw outline & body shape
	var margin := 4
	for x in range(margin, width - margin):
		for y in range(margin, height - margin):
			# Base color with subtle gradient
			var shade := 1.0 - (float(y) / float(height)) * 0.3
			var pixel_color := Color(
				color_theme.r * shade,
				color_theme.g * shade,
				color_theme.b * shade,
				1.0
			)
			
			# Add pixel eyes/features
			if y == margin + 4 and (x == margin + 4 or x == width - margin - 5):
				pixel_color = Color(1.0, 1.0, 1.0, 1.0)  # Eye white
			elif y == margin + 4 and (x == margin + 5 or x == width - margin - 6):
				pixel_color = Color(0.1, 0.1, 0.1, 1.0)  # Eye pupil
				
			img.set_pixel(x, y, pixel_color)
			
	# Border pixel outline
	var border_color := Color(0.05, 0.05, 0.08, 1.0)
	for x in range(margin - 1, width - margin + 1):
		img.set_pixel(x, margin - 1, border_color)
		img.set_pixel(x, height - margin, border_color)
	for y in range(margin - 1, height - margin + 1):
		img.set_pixel(margin - 1, y, border_color)
		img.set_pixel(width - margin, y, border_color)
		
	return ImageTexture.create_from_image(img)

static func create_item_icon(item_type: int, rarity_color: Color) -> ImageTexture:
	var img := Image.create(24, 24, false, Image.FORMAT_RGBA8)
	img.fill(Color(0, 0, 0, 0))
	
	# Draw item shape
	for x in range(2, 22):
		for y in range(2, 22):
			if (x + y) % 2 == 0:
				img.set_pixel(x, y, rarity_color)
			else:
				img.set_pixel(x, y, rarity_color.darkened(0.2))
				
	return ImageTexture.create_from_image(img)

static func create_zone_bg(bg_color: Color, width: int = 320, height: int = 180) -> ImageTexture:
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	for x in range(width):
		for y in range(height):
			var dist := float(y) / float(height)
			var col := bg_color.darkened(dist * 0.4)
			img.set_pixel(x, y, col)
	return ImageTexture.create_from_image(img)
