# ═══════════════════════════════════════════════════════════════
#  UNIT CARD CONTROLLER (unit_card.gd) — Premium Edition
#  Hiển thị thông tin Unit với Full Card Click & Micro-Animations
# ═══════════════════════════════════════════════════════════════
extends PanelContainer

const SurvDb = preload("res://scripts/data/survivor_database.gd")
const PixelGen = preload("res://scripts/utils/pixel_art_generator.gd")
const AnimEng = preload("res://scripts/utils/sprite_animation_engine.gd")

@export var icon_texture: TextureRect
@export var icon_label: Label
@export var name_label: Label
@export var class_label: Label
@export var level_label: Label
@export var hp_bar: ProgressBar
@export var btn_select: Button

var unit_data: Dictionary = {}
var unit_type: int = Constants.UnitType.SURVIVOR

func _ready() -> void:
	pivot_offset = size / 2.0
	mouse_filter = Control.MOUSE_FILTER_STOP
	gui_input.connect(_on_gui_input)
	mouse_entered.connect(func(): AnimEng.animate_button_click(self))

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_select_unit()

func setup(p_data: Dictionary, p_unit_type: int = Constants.UnitType.SURVIVOR) -> void:
	unit_data = p_data
	unit_type = p_unit_type
	
	var uname: String = unit_data.get("name", "Vô danh")
	var level: int = unit_data.get("level", 1)
	
	if name_label: name_label.text = uname
	if level_label: level_label.text = "Lv." + str(level)
	
	var theme_color := Color(0.9, 0.4, 0.2)
	match unit_type:
		Constants.UnitType.SURVIVOR:
			var sclass: int = unit_data.get("class", 0)
			if class_label: class_label.text = SurvDb.CLASS_DATA[sclass]["name"]
			theme_color = Color(0.3, 0.7, 1.0)
		Constants.UnitType.MONSTER:
			if class_label: class_label.text = "Quái vật"
			theme_color = Color(0.9, 0.3, 0.3)
		Constants.UnitType.MECHA:
			if class_label: class_label.text = "Robot Mecha"
			theme_color = Color(0.2, 0.9, 0.5)

	var tex := PixelGen.create_unit_texture(unit_type, theme_color, 48, 48)
	if icon_texture:
		icon_texture.texture = tex
		icon_texture.visible = true
		if icon_label: icon_label.visible = false

	if btn_select:
		btn_select.mouse_filter = Control.MOUSE_FILTER_PASS
		btn_select.pressed.connect(_select_unit)

func _select_unit() -> void:
	AnimEng.animate_button_click(self)
	AudioManager.play_sfx("ui_click")
	print("[UnitCard] Unit card clicked! Selected unit ID: ", unit_data.get("id", ""))
	EventBus.unit_selected.emit(unit_type, unit_data.get("id", ""))
