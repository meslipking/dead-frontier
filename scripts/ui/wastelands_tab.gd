# ═══════════════════════════════════════════════════════════════
#  WASTELANDS TAB CONTROLLER (wastelands_tab.gd)
#  Quản lý danh sách 7 Vùng hoang (Tab 3) và tiến độ thám hiểm
# ═══════════════════════════════════════════════════════════════
extends Control

@export var list_container: VBoxContainer
var zone_card_scene = preload("res://scenes/shared/ZoneCard.tscn")
var card_instances := {}

func _ready() -> void:
	EventBus.zone_progress_updated.connect(_on_zone_progress_updated)
	EventBus.combat_started.connect(_on_combat_started)
	populate_zones()

func populate_zones() -> void:
	if not list_container:
		return
		
	for child in list_container.get_children():
		child.queue_free()
		
	card_instances.clear()
	var zones := ZoneDatabase.get_all_zones()
	
	for z in zones:
		var card = zone_card_scene.instantiate()
		list_container.add_child(card)
		card.setup(z)
		card_instances[z["id"]] = card

func _on_zone_progress_updated(zone_id: String, _progress: float) -> void:
	if card_instances.has(zone_id):
		card_instances[zone_id].update_progress()

func _on_combat_started(zone_id: String) -> void:
	var zone: Dictionary = ZoneDatabase.get_zone(zone_id)
	print("[WastelandsTab] Selected zone for exploration: ", zone.get("name", zone_id))
