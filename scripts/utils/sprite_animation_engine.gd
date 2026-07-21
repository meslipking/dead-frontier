# ═══════════════════════════════════════════════════════════════
#  SPRITE ANIMATION ENGINE (sprite_animation_engine.gd)
#  Cung cấp hiệu ứng hoạt ảnh cao cấp (Animation & Micro-UX Effects)
# ═══════════════════════════════════════════════════════════════
class_name SpriteAnimationEngine

static func apply_idle_breathing(node: Control, speed: float = 1.5, amplitude: float = 4.0) -> void:
	if not node: return
	var orig_y: float = node.position.y
	var tween := node.create_tween().set_loops()
	tween.tween_property(node, "position:y", orig_y - amplitude, speed).set_trans(Tween.TRANS_SINE)
	tween.tween_property(node, "position:y", orig_y + amplitude, speed).set_trans(Tween.TRANS_SINE)

static func animate_button_click(node: Control) -> void:
	if not node: return
	var tween := node.create_tween()
	tween.tween_property(node, "scale", Vector2(0.92, 0.92), 0.08).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(node, "scale", Vector2(1.0, 1.0), 0.12).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

static func animate_hit_flash(node: CanvasItem) -> void:
	if not node: return
	var orig_mod := node.modulate
	var tween := node.create_tween()
	tween.tween_property(node, "modulate", Color(2.5, 2.5, 2.5, 1.0), 0.08)
	tween.tween_property(node, "modulate", orig_mod, 0.12)

static func animate_attack_dash(node: Control, target_offset: Vector2) -> void:
	if not node: return
	var orig_pos := node.position
	var tween := node.create_tween()
	tween.tween_property(node, "position", orig_pos + target_offset, 0.15).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(node, "position", orig_pos, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
