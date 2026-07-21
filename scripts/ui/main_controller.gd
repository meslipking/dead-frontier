# ═══════════════════════════════════════════════════════════════
#  MAIN CONTROLLER (main_controller.gd)
#  Điều khiển Root Scene, TopBar currencies, và Tab Scene switching
# ═══════════════════════════════════════════════════════════════
extends Control

@export var top_bar: HBoxContainer
@export var label_gold: Label
@export var label_alloys: Label
@export var label_energy: Label
@export var label_crystals: Label

@export var tab_container: Control
@export var outpost_tab: Control
@export var squad_tab: Control
@export var wastelands_tab: Control
@export var sieges_tab: Control

func _ready() -> void:
	EventBus.tab_changed.connect(_on_tab_changed)
	EventBus.currency_changed.connect(_on_currency_changed)
	EventBus.offline_report_ready.connect(_on_offline_report_ready)
	
	_update_all_currencies()
	_on_tab_changed(GameManager.current_tab)

func _on_tab_changed(index: int) -> void:
	var tabs := [outpost_tab, squad_tab, wastelands_tab, sieges_tab]
	for i in tabs.size():
		if tabs[i]:
			tabs[i].visible = (i == index)

func _update_all_currencies() -> void:
	if label_gold: label_gold.text = "🪙 " + _format_num(GameManager.get_currency(Constants.Currency.GOLD))
	if label_alloys: label_alloys.text = "⚙️ " + _format_num(GameManager.get_currency(Constants.Currency.ALLOYS))
	if label_energy: label_energy.text = "⚡ " + _format_num(GameManager.get_currency(Constants.Currency.ENERGY))
	if label_crystals: label_crystals.text = "💎 " + _format_num(GameManager.get_currency(Constants.Currency.CRYSTALS))

func _on_currency_changed(_type: int, _new_val: int) -> void:
	_update_all_currencies()

func _format_num(val: int) -> String:
	if val >= 1_000_000:
		return "%.1fM" % (val / 1_000_000.0)
	elif val >= 1_000:
		return "%.1fK" % (val / 1_000.0)
	return str(val)

func _on_offline_report_ready(report: Dictionary) -> void:
	# Show report popup when offline rewards are calculated
	print("[MainController] Offline rewards popup triggered: ", report)
