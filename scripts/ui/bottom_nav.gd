# ═══════════════════════════════════════════════════════════════
#  BOTTOM NAV BAR (bottom_nav.gd)
#  Quản lý 4 nút chuyển Tab ở thanh điều hướng dưới màn hình
# ═══════════════════════════════════════════════════════════════
extends HBoxContainer

@export var btn_outpost: Button
@export var btn_squad: Button
@export var btn_wastelands: Button
@export var btn_sieges: Button

var active_tab_index: int = 0

func _ready() -> void:
	if btn_outpost: btn_outpost.pressed.connect(func(): _on_tab_pressed(0))
	if btn_squad: btn_squad.pressed.connect(func(): _on_tab_pressed(1))
	if btn_wastelands: btn_wastelands.pressed.connect(func(): _on_tab_pressed(2))
	if btn_sieges: btn_sieges.pressed.connect(func(): _on_tab_pressed(3))
	
	EventBus.tab_changed.connect(_on_external_tab_changed)
	set_active_tab(0)

func _on_tab_pressed(index: int) -> void:
	GameManager.switch_tab(index)

func _on_external_tab_changed(index: int) -> void:
	set_active_tab(index)

func set_active_tab(index: int) -> void:
	active_tab_index = index
	var buttons := [btn_outpost, btn_squad, btn_wastelands, btn_sieges]
	
	for i in buttons.size():
		var btn: Button = buttons[i]
		if btn:
			if i == active_tab_index:
				btn.modulate = Color(1.0, 0.85, 0.3)  # Highlight active
			else:
				btn.modulate = Color(0.7, 0.75, 0.8)  # Dim inactive
