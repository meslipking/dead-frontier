# ═══════════════════════════════════════════════════════════════
#  UI THEME BUILDER (ui_theme_builder.gd) — Commercial Dark Fantasy
#  Áp dụng Styling UI/UX Cao Cấp Viền Vàng Kim & Obsidian Metallic
# ═══════════════════════════════════════════════════════════════
class_name UIThemeBuilder

static func apply_commercial_theme(tree: SceneTree) -> void:
	if not tree or not tree.root: return
	
	# Create StyleBoxFlat for Panels
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.1, 0.11, 0.15, 0.95) # Obsidian Slate
	panel_style.border_color = Color(0.7, 0.55, 0.25, 1.0) # Metallic Gold Filigree Border
	panel_style.set_border_width_all(2)
	panel_style.set_corner_radius_all(6)
	panel_style.shadow_color = Color(0, 0, 0, 0.6)
	panel_style.shadow_size = 4
	
	# Create StyleBoxFlat for Buttons
	var btn_normal := StyleBoxFlat.new()
	btn_normal.bg_color = Color(0.18, 0.2, 0.26, 1.0)
	btn_normal.border_color = Color(0.5, 0.4, 0.2, 1.0)
	btn_normal.set_border_width_all(1)
	btn_normal.set_corner_radius_all(5)
	
	var btn_hover := StyleBoxFlat.new()
	btn_hover.bg_color = Color(0.25, 0.28, 0.38, 1.0)
	btn_hover.border_color = Color(0.9, 0.75, 0.3, 1.0)
	btn_hover.set_border_width_all(2)
	btn_hover.set_corner_radius_all(5)
	
	var theme := Theme.new()
	theme.set_stylebox("panel", "PanelContainer", panel_style)
	theme.set_stylebox("normal", "Button", btn_normal)
	theme.set_stylebox("hover", "Button", btn_hover)
	theme.set_stylebox("pressed", "Button", btn_hover)
	
	tree.root.theme = theme
