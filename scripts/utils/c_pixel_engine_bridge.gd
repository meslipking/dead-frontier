# ═══════════════════════════════════════════════════════════════
#  C PIXEL ENGINE BRIDGE (c_pixel_engine_bridge.gd)
#  Cần cầu kết nối thuật toán C Pure Rasterizer vào Godot Engine
# ═══════════════════════════════════════════════════════════════
class_name CPixelEngineBridge

static func render_c_survivor_texture(color_theme: Color, width: int = 48, height: int = 48) -> ImageTexture:
	var bytes := PackedByteArray()
	bytes.resize(width * height * 4)
	
	var armor_r := int(color_theme.r * 255)
	var armor_g := int(color_theme.g * 255)
	var armor_b := int(color_theme.b * 255)
	
	# Pure C-style raw memory buffer manipulation
	for y in height:
		for x in width:
			var idx := (y * width + x) * 4
			var r := 0; var g := 0; var b := 0; var a := 0
			
			if x in range(12, 36) and y in range(8, 44):
				r = armor_r; g = armor_g; b = armor_b; a = 255
				if y in range(12, 16) and x in range(18, 30):
					r = 20; g = 230; b = 255 # Visor
				elif y in range(32, 44):
					r = int(armor_r * 0.4); g = int(armor_g * 0.4); b = int(armor_b * 0.4) # Boots
			
			bytes[idx + 0] = r
			bytes[idx + 1] = g
			bytes[idx + 2] = b
			bytes[idx + 3] = a
			
	var img := Image.create_from_data(width, height, false, Image.FORMAT_RGBA8, bytes)
	return ImageTexture.create_from_image(img)

static func render_c_monster_texture(color_theme: Color, width: int = 48, height: int = 48) -> ImageTexture:
	var bytes := PackedByteArray()
	bytes.resize(width * height * 4)
	
	var beast_r := int(color_theme.r * 255)
	var beast_g := int(color_theme.g * 255)
	var beast_b := int(color_theme.b * 255)
	
	for y in height:
		for x in width:
			var idx := (y * width + x) * 4
			var r := 0; var g := 0; var b := 0; var a := 0
			
			var dist: float = Vector2(x - 24, y - 26).length()
			if dist < 16.0:
				r = beast_r; g = beast_g; b = beast_b; a = 255
				if y < 18 and (x in range(14, 18) or x in range(30, 34)):
					r = 255; g = 40; b = 40 # Eyes
				elif y > 34 and (x % 4 == 0):
					r = 230; g = 230; b = 210 # Claws
					
			bytes[idx + 0] = r
			bytes[idx + 1] = g
			bytes[idx + 2] = b
			bytes[idx + 3] = a
			
	var img := Image.create_from_data(width, height, false, Image.FORMAT_RGBA8, bytes)
	return ImageTexture.create_from_image(img)
