# ═══════════════════════════════════════════════════════════════
#  UNIT CARD CONTROLLER (unit_card.gd)
# ═══════════════════════════════════════════════════════════════
extends PanelContainer

const SurvDb = preload("res://scripts/data/survivor_database.gd")

@export var icon_label: Label
@export var name_label: Label
@export var class_label: Label
@export var level_label: Label
@export var hp_bar: ProgressBar
@export var btn_select: Button

var unit_data: Dictionary = {}
var unit_type: int = Constants.UnitType.SURVIVOR

func setup(p_data: Dictionary, p_unit_type: int = Constants.UnitType.SURVIVOR) -> void:
	unit_data = p_data
	unit_type = p_unit_type
	
	var uname: String = unit_data.get("name", "Vô danh")
	var level: int = unit_data.get("level", 1)
	
	if name_label: name_label.text = uname
	if level_label: level_label.text = "Lv." + str(level)
	
	match unit_type:
		Constants.UnitType.SURVIVOR:
			var sclass: int = unit_data.get("class", 0)
			if class_label: class_label.text = SurvDb.CLASS_DATA[sclass]["name"]
			if icon_label: icon_label.text = SurvDb.CLASS_DATA[sclass]["icon"]
		Constants.UnitType.MONSTER:
			if class_label: class_label.text = "Quái vật"
			if icon_label: icon_label.text = "🐉"
		Constants.UnitType.MECHA:
			if class_label: class_label.text = "Robot"
			if icon_label: icon_label.text = "🤖"

	if btn_select:
		btn_select.pressed.connect(func(): EventBus.unit_selected.emit(unit_type, unit_data.get("id", "")))
