# ═══════════════════════════════════════════════════════════════
#  TOAST MANAGER (toast_manager.gd) — Autoload Singleton
#  Quản lý thông báo nổi Floating Toast Notifications cho Game
# ═══════════════════════════════════════════════════════════════
extends CanvasLayer

static var instance: CanvasLayer

func _ready() -> void:
	instance = self

static func show_toast(msg: String, color: Color = Color(1, 1, 1), duration: float = 2.0) -> void:
	EventBus.toast_requested.emit(msg, color, duration)
	print("[ToastManager] Toast: ", msg)
