# ═══════════════════════════════════════════════════════════════
#  BOTTOM NAV CONTROLLER (bottom_nav.gd) — Premium Edition
#  Điều hướng 4 Tab chính với hiệu ứng micro-animations & SFX
# ═══════════════════════════════════════════════════════════════
extends HBoxContainer

const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

@export var btn_outpost: Button
@export var btn_squad: Button
@export var btn_wastelands: Button
@export var btn_sieges: Button

var buttons: Array[Button] = []

func _ready() -> void:
	buttons = [btn_outpost, btn_squad, btn_wastelands, btn_sieges]
	
	for i in buttons.size():
		if buttons[i]:
			var tab_idx := i
			buttons[i].pressed.connect(func():
				AnimEng.animate_button_click(buttons[tab_idx])
				AudioManager.play_sfx("ui_click")
				GameManager.switch_tab(tab_idx)
			)
			
	EventBus.tab_changed.connect(_on_tab_changed)
	_on_tab_changed(GameManager.current_tab)

func _on_tab_changed(active_index: int) -> void:
	for i in buttons.size():
		if buttons[i]:
			var btn := buttons[i]
			if i == active_index:
				btn.modulate = Color(1.0, 0.75, 0.2, 1.0) # Active Gold Glow
			else:
				btn.modulate = Color(0.65, 0.7, 0.8, 0.85) # Normal Inactive
