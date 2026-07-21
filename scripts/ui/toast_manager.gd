# ═══════════════════════════════════════════════════════════════
#  TOAST MANAGER (toast_manager.gd)
#  Quản lý thông báo nổi (Floating Toast Notifications) góc màn hình
# ═══════════════════════════════════════════════════════════════
extends CanvasLayer

var container: VBoxContainer

func _ready() -> void:
	layer = 100  # Always on top
	container = VBoxContainer.new()
	container.anchors_preset = Control.PRESET_TOP_RIGHT
	container.position = Vector2(10, 50)
	add_child(container)
	
	EventBus.toast_requested.connect(show_toast)
	EventBus.achievement_unlocked.connect(func(id): show_toast("🏆 THÀNH TỰU MỚI: " + id, Color(1, 0.85, 0.2)))
	EventBus.item_acquired.connect(func(item): show_toast("📦 THU NHẬN: " + item.get("name", ""), Color(0.3, 0.9, 0.4)))

func show_toast(message: String, color: Color = Color(1, 1, 1), duration: float = 2.5) -> void:
	var lbl := Label.new()
	lbl.text = message
	lbl.modulate = color
	lbl.add_theme_font_size_override("font_size", 12)
	container.add_child(lbl)
	
	var tween := create_tween()
	tween.tween_property(lbl, "modulate:a", 0.0, duration)
	tween.tween_callback(lbl.queue_free)
