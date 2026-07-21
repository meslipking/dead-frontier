# ═══════════════════════════════════════════════════════════════
#  TRADING POST ROOM CONTROLLER (trading_post_room.gd)
# ═══════════════════════════════════════════════════════════════
extends Control

const ItemDb = preload("res://scripts/data/item_database.gd")
const InvSys = preload("res://scripts/systems/inventory_system.gd")

@export var shop_container: VBoxContainer
@export var lbl_status: Label
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	populate_shop()

func populate_shop() -> void:
	if not shop_container:
		return
		
	for child in shop_container.get_children():
		child.queue_free()
		
	var items := [
		{ "id": "mat_scrap_iron", "name": "5x Phế liệu sắt", "cost": 30, "item": ItemDb.get_item("mat_scrap_iron") },
		{ "id": "mat_circuit_board", "name": "3x Mạch điện hỏng", "cost": 60, "item": ItemDb.get_item("mat_circuit_board") },
		{ "id": "wpn_machete", "name": "Dao rựa sinh tồn", "cost": 150, "item": ItemDb.get_item("wpn_machete") },
	]
	
	for shop_item in items:
		var btn := Button.new()
		btn.text = "Mua %s (%d Vàng)" % [shop_item["name"], shop_item["cost"]]
		btn.pressed.connect(func():
			if GameManager.spend_currency(Constants.Currency.GOLD, shop_item["cost"]):
				InvSys.add_item(shop_item["item"])
				if lbl_status: lbl_status.text = "🛒 ĐÃ MUA: " + shop_item["name"]
			else:
				if lbl_status: lbl_status.text = "❌ Không đủ Vàng!"
		)
		shop_container.add_child(btn)
