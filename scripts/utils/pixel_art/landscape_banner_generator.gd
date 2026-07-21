# ═══════════════════════════════════════════════════════════════
#  LANDSCAPE BANNER GENERATOR (landscape_banner_generator.gd)
#  Động cơ sinh Bìa Nền Phong Cảnh & Nền Đất 3D 16-Bit SNES Chuẩn AAA (EXPLICIT TYPED)
# ═══════════════════════════════════════════════════════════════
class_name LandscapeBannerGenerator

static func create_landscape_banner(banner_name: String, width: int = 640, height: int = 160) -> ImageTexture:
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	
	var ground_height: int = int(height * 0.28)
	var floor_y: int = height - ground_height
	
	if banner_name.contains("Obsidian") or banner_name.contains("Digging") or banner_name.contains("Quên Lãng"):
		# 1. OBSIDIAN MINES: Gothic Catacomb Arches, Torches, Lava Streams & Solid Brick Ground
		var bg_dark := Color(0.08, 0.08, 0.12)
		var arch_dark := Color(0.18, 0.2, 0.26)
		var arch_light := Color(0.32, 0.35, 0.45)
		var lava_orange := Color(0.95, 0.45, 0.1)
		var torch_yellow := Color(1.0, 0.85, 0.25)
		var ground_stone := Color(0.22, 0.24, 0.32)
		var ground_top_gold := Color(0.95, 0.8, 0.25)
		
		img.fill(bg_dark)
		
		# Draw Arch Pillars every 60px
		for p in range(0, width, 60):
			for x in range(p, int(min(p + 20, width))):
				for y in range(0, floor_y):
					var c := arch_dark if x % 4 == 0 else arch_light
					img.set_pixel(x, y, c)
					
		# Draw Solid 3D Stone Ground Floor
		for x in range(width):
			if floor_y < height: img.set_pixel(x, floor_y, ground_top_gold) # Top golden highlight line
			if floor_y + 1 < height: img.set_pixel(x, floor_y + 1, Color(0.45, 0.48, 0.58))
			for y in range(floor_y + 2, height):
				var is_brick_line := (y % 12 == 0) or ((x + (y / 12) * 16) % 32 == 0)
				var c := Color(0.14, 0.15, 0.22) if is_brick_line else ground_stone
				img.set_pixel(x, y, c)
				
		# Draw Flickering Torches along the wall
		for t in range(30, width, 60):
			for y in range(int(max(0, floor_y - 45)), floor_y - 20):
				if t < width: img.set_pixel(t, y, Color(0.4, 0.25, 0.15))
			for x in range(int(max(0, t - 4)), int(min(t + 6, width))):
				for y in range(int(max(0, floor_y - 55)), floor_y - 43):
					if Vector2(x - t, y - (floor_y - 49)).length() <= 4.2:
						img.set_pixel(x, y, torch_yellow if (x + y) % 2 == 0 else lava_orange)

	elif banner_name.contains("Grove") or banner_name.contains("Rebels") or banner_name.contains("Cổ Thụ"):
		# 2. SOUTHERN GROVE: Forest Canopy, Wooden Pillars & Earth Soil Floor
		var sky_teal := Color(0.12, 0.28, 0.26)
		var leaf_dark := Color(0.15, 0.45, 0.25)
		var leaf_light := Color(0.3, 0.65, 0.35)
		var trunk_brown := Color(0.38, 0.24, 0.14)
		var soil_dark := Color(0.25, 0.16, 0.1)
		var grass_green := Color(0.2, 0.8, 0.35)
		
		img.fill(sky_teal)
		
		# Draw Tree Trunks
		for t in range(40, width, 70):
			for x in range(t, int(min(t + 16, width))):
				for y in range(30, floor_y):
					img.set_pixel(x, y, trunk_brown)
					
		# Draw Foliage Canopy at top
		for x in range(width):
			var canopy_h: int = int(float(height) * 0.35 + sin(x * 0.05) * 10.0)
			for y in range(0, int(min(canopy_h, floor_y))):
				img.set_pixel(x, y, leaf_dark if (x + y) % 3 == 0 else leaf_light)
				
		# Draw Solid Earth Soil Floor with Grass Layer
		for x in range(width):
			if floor_y < height: img.set_pixel(x, floor_y, grass_green) # Grass top border
			if floor_y + 1 < height: img.set_pixel(x, floor_y + 1, grass_green)
			for y in range(floor_y + 2, height):
				img.set_pixel(x, y, soil_dark if (x + y) % 5 != 0 else Color(0.18, 0.11, 0.06))

	else:
		# 3. BARREN WASTELANDS: Post-Apocalyptic Sunset Sky & Concrete Ruins Floor
		for y in range(floor_y):
			var ratio := float(y) / float(floor_y)
			var sky_col := Color(0.45, 0.18, 0.12).lerp(Color(0.1, 0.08, 0.14), ratio)
			for x in range(width):
				img.set_pixel(x, y, sky_col)
				
		var ruin_col := Color(0.22, 0.2, 0.26)
		var window_gold := Color(0.9, 0.7, 0.2)
		var floor_concrete := Color(0.3, 0.28, 0.34)
		
		# Draw Ruined Concrete Buildings in Background
		for x in range(width):
			var ruin_h: int = int(float(height) * 0.3 + sin(x * 0.03) * 12.0 + cos(x * 0.08) * 6.0)
			var start_y: int = int(max(0, floor_y - ruin_h))
			for y in range(start_y, floor_y):
				var c := ruin_col
				if (x % 16 in [4, 5, 6]) and (y % 12 in [3, 4]) and y < floor_y - 15:
					c = window_gold
				img.set_pixel(x, y, c)
				
		# Draw Solid Asphalt Concrete Floor
		for x in range(width):
			if floor_y < height: img.set_pixel(x, floor_y, Color(0.95, 0.8, 0.25)) # Warning strip highlight
			if floor_y + 1 < height: img.set_pixel(x, floor_y + 1, Color(0.5, 0.48, 0.55))
			for y in range(floor_y + 2, height):
				img.set_pixel(x, y, floor_concrete if (x + y) % 6 != 0 else Color(0.18, 0.16, 0.22))

	return ImageTexture.create_from_image(img)
