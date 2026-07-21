# ═══════════════════════════════════════════════════════════════
#  LANDSCAPE BANNER GENERATOR (landscape_banner_generator.gd)
#  Động cơ sinh Bìa Nền Phong Cảnh 16-Bit SNES Chuẩn Commercial AAA
# ═══════════════════════════════════════════════════════════════
class_name LandscapeBannerGenerator

static func create_landscape_banner(banner_name: String, width: int = 320, height: int = 110) -> ImageTexture:
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	
	if banner_name.contains("Obsidian") or banner_name.contains("Digging"):
		# 1. OBSIDIAN MINES: Gothic Catacomb Arches, Torches & Lava Streams
		var bg_dark := Color(0.08, 0.08, 0.12)
		var arch_dark := Color(0.18, 0.2, 0.26)
		var arch_light := Color(0.32, 0.35, 0.45)
		var lava_orange := Color(0.95, 0.45, 0.1)
		var torch_yellow := Color(1.0, 0.85, 0.25)
		img.fill(bg_dark)
		
		# Draw Arch Pillars every 50px
		for p in range(0, width, 50):
			for x in range(p, p + 16):
				for y in range(0, height):
					var c := arch_dark if x % 3 == 0 else arch_light
					img.set_pixel(x, y, c)
					
		# Draw Lava Stream at bottom
		for x in range(width):
			var lava_h := int(12.0 + sin(x * 0.08) * 5.0)
			for y in range(height - lava_h, height):
				img.set_pixel(x, y, lava_orange if (x + y) % 2 == 0 else Color(0.8, 0.2, 0.05))
				
		# Draw Flickering Torches
		for t in range(25, width, 50):
			for y in range(height - 45, height - 25):
				img.set_pixel(t, y, Color(0.4, 0.25, 0.15))
			for x in range(t - 3, t + 4):
				for y in range(height - 52, height - 44):
					if Vector2(x - t, y - (height - 48)).length() <= 3.2:
						img.set_pixel(x, y, torch_yellow if (x + y) % 2 == 0 else lava_orange)

	elif banner_name.contains("Grove") or banner_name.contains("Rebels"):
		# 2. SOUTHERN GROVE: Lush Canopy Forest, Deep Blue Lake & Sunbeams
		var sky_teal := Color(0.12, 0.28, 0.26)
		var leaf_dark := Color(0.15, 0.45, 0.25)
		var leaf_light := Color(0.3, 0.65, 0.35)
		var trunk_brown := Color(0.38, 0.24, 0.14)
		var lake_blue := Color(0.15, 0.45, 0.75)
		img.fill(sky_teal)
		
		# Draw Water Lake at bottom
		for x in range(width):
			for y in range(height - 25, height):
				img.set_pixel(x, y, lake_blue if (x + y) % 4 != 0 else Color(0.2, 0.6, 0.9))
				
		# Draw Tree Trunks
		for t in range(30, width, 55):
			for x in range(t, t + 12):
				for y in range(20, height - 20):
					img.set_pixel(x, y, trunk_brown)
					
		# Draw Foliage Canopy at top
		for x in range(width):
			var canopy_h := int(45.0 + sin(x * 0.06) * 12.0)
			for y in range(0, canopy_h):
				img.set_pixel(x, y, leaf_dark if (x + y) % 3 == 0 else leaf_light)

	else:
		# 3. BARREN WASTELANDS: Post-Apocalyptic Sunset Sky & Concrete Ruins
		for y in range(height):
			var ratio := float(y) / float(height)
			var sky_col := Color(0.45, 0.18, 0.12).lerp(Color(0.1, 0.08, 0.14), ratio)
			for x in range(width):
				img.set_pixel(x, y, sky_col)
				
		var ruin_col := Color(0.22, 0.2, 0.26)
		var window_gold := Color(0.9, 0.7, 0.2)
		
		# Draw Ruined Concrete Buildings
		for x in range(width):
			var ruin_h := int(40.0 + sin(x * 0.04) * 20.0 + cos(x * 0.1) * 8.0)
			for y in range(height - ruin_h, height):
				var c := ruin_col
				if (x % 12 in [3, 4, 5]) and (y % 10 in [2, 3]) and y < height - 15:
					c = window_gold
				img.set_pixel(x, y, c)

	return ImageTexture.create_from_image(img)
