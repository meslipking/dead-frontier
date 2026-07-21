# ═══════════════════════════════════════════════════════════════
#  SQUAD TAB CONTROLLER (squad_tab.gd)
#  Quản lý 3 sub-tabs: Người sống sót | Quái vật | Mecha
# ═══════════════════════════════════════════════════════════════
extends Control

@export var btn_survivors: Button
@export var btn_monsters: Button
@export var btn_mechas: Button
@export var list_container: VBoxContainer

var unit_card_scene = preload("res://scenes/shared/UnitCard.tscn")
var current_sub_tab: int = Constants.UnitType.SURVIVOR

func _ready() -> void:
	if btn_survivors: btn_survivors.pressed.connect(func(): switch_sub_tab(Constants.UnitType.SURVIVOR))
	if btn_monsters: btn_monsters.pressed.connect(func(): switch_sub_tab(Constants.UnitType.MONSTER))
	if btn_mechas: btn_mechas.pressed.connect(func(): switch_sub_tab(Constants.UnitType.MECHA))
	
	switch_sub_tab(Constants.UnitType.SURVIVOR)

func switch_sub_tab(sub_tab_type: int) -> void:
	current_sub_tab = sub_tab_type
	
	var btns := [btn_survivors, btn_monsters, btn_mechas]
	for i in btns.size():
		if btns[i]:
			btns[i].modulate = Color(1.0, 0.85, 0.3) if i == current_sub_tab else Color(0.7, 0.75, 0.8)
			
	populate_units()

func populate_units() -> void:
	if not list_container:
		return
		
	for child in list_container.get_children():
		child.queue_free()
		
	var units := []
	match current_sub_tab:
		Constants.UnitType.SURVIVOR: units = GameManager.get_survivors()
		Constants.UnitType.MONSTER: units = GameManager.get_monsters()
		Constants.UnitType.MECHA: units = GameManager.get_mechas()
		
	if units.is_empty():
		var empty_lbl := Label.new()
		empty_lbl.text = "Chưa có unit nào trong mục này."
		empty_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		list_container.add_child(empty_lbl)
		return
		
	for u in units:
		var card = unit_card_scene.instantiate()
		list_container.add_child(card)
		card.setup(u, current_sub_tab)
