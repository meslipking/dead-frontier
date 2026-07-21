# ═══════════════════════════════════════════════════════════════
#  VFX ENGINE (vfx_engine.gd)
#  Động cơ hiệu ứng hình ảnh cao cấp: Hạt Particle, Rung màn hình,
#  Tia lửa chém & Aura Nguyên Tố (Fire, Ice, Poison, Electric, Shadow)
# ═══════════════════════════════════════════════════════════════
class_name VFXEngine

static func spawn_slash_sparks(parent: Node, global_pos: Vector2, color: Color = Color(1.0, 0.8, 0.3)) -> void:
	if not parent: return
	
	var particles := CPUParticles2D.new()
	particles.emitting = true
	particles.one_shot = true
	particles.explosiveness = 0.95
	particles.amount = 16
	particles.lifetime = 0.4
	particles.direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	particles.spread = 180.0
	particles.gravity = Vector2(0, 98)
	particles.initial_velocity_min = 40.0
	particles.initial_velocity_max = 120.0
	particles.scale_amount_min = 2.0
	particles.scale_amount_max = 4.0
	particles.color = color
	particles.global_position = global_pos
	
	parent.add_child(particles)
	var timer := parent.get_tree().create_timer(0.5)
	timer.timeout.connect(particles.queue_free)

static func trigger_screen_shake(viewport: Viewport, intensity: float = 8.0, duration: float = 0.25) -> void:
	if not viewport: return
	var camera := viewport.get_camera_2d()
	if not camera: return
	
	var orig_offset := camera.offset
	var tween := viewport.create_tween()
	
	for i in range(5):
		var offset := Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))
		tween.tween_property(camera, "offset", orig_offset + offset, duration / 5.0)
		
	tween.tween_property(camera, "offset", orig_offset, 0.05)
