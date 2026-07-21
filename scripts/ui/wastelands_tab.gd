# ═══════════════════════════════════════════════════════════════
#  WASTELANDS TAB CONTROLLER (wastelands_tab.gd)
# ═══════════════════════════════════════════════════════════════
extends Control

const ZoneDb = preload("res://scripts/data/zone_database.gd")

@export var zone_container: VBoxContainer
var zone_card_scene = preload("res://scenes/shared/ZoneCard.tscn")
var card_instances := {}

func _ready() -> void:
	EventBus.zone_progress_updated.connect(_on_zone_progress_updated)
	EventBus.combat_started.connect(_on_combat_started)
	populate_zones()

func populate_zones() -> void:
	if not zone_container:
		return
		
	for child in zone_container.get_children():
		child.queue_free()
		
	card_instances.clear()
	var zones: Array = ZoneDb.get_all_zones()
	
	for z in zones:
		var card = zone_card_scene.instantiate()
		zone_container.add_child(card)
		card.setup(z)
		card_instances[z.get("id")] = card

func _on_zone_progress_updated(zone_id: String, _progress: float) -> void:
	if card_instances.has(zone_id):
		var zone: Dictionary = ZoneDb.get_zone(zone_id)
		card_instances[zone_id].setup(zone)

func _on_combat_started(zone_id: String) -> void:
	print("[WastelandsTab] Selected zone for exploration: ", zone_id)
