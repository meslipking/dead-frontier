# ═══════════════════════════════════════════════════════════════
#  SPRITE FRAMES BUILDER (sprite_frames_builder.gd)
#  Dựng SpriteFrames hoạt ảnh 4 khung hình (Idle, Dash, Attack, Hit)
#  từ Sprite Sheet vẽ tay chuẩn 16-bit SNES Pixel Art
# ═══════════════════════════════════════════════════════════════
class_name SpriteFramesBuilder

static func build_unit_sprite_frames(texture: Texture2D, frame_w: int = 48, frame_h: int = 48) -> SpriteFrames:
	var frames := SpriteFrames.new()
	frames.add_animation("idle")
	frames.add_animation("attack")
	frames.add_animation("hit")
	
	frames.set_animation_speed("idle", 6.0)
	frames.set_animation_loop("idle", true)
	
	frames.set_animation_speed("attack", 12.0)
	frames.set_animation_loop("attack", false)
	
	frames.set_animation_speed("hit", 10.0)
	frames.set_animation_loop("hit", false)
	
	if not texture:
		return frames
		
	# Slice texture into AtlasTextures
	var cols: int = max(texture.get_width() / frame_w, 1)
	var rows: int = max(texture.get_height() / frame_h, 1)
	
	for col in range(min(cols, 4)):
		var atlas := AtlasTexture.new()
		atlas.atlas = texture
		atlas.region = Rect2(col * frame_w, 0, frame_w, frame_h)
		frames.add_frame("idle", atlas)
		
	for col in range(min(cols, 4)):
		var atlas := AtlasTexture.new()
		atlas.atlas = texture
		atlas.region = Rect2(col * frame_w, min(1 * frame_h, (rows - 1) * frame_h), frame_w, frame_h)
		frames.add_frame("attack", atlas)
		
	return frames
