# ═══════════════════════════════════════════════════════════════
#  ARMORY ROOM CONTROLLER (armory_room.gd)
#  Quản lý Kho Vũ Khí: Danh sách vật phẩm, lọc kho & bán phế liệu
# ═══════════════════════════════════════════════════════════════
extends Control

@export var lbl_capacity: Label
@export var item_grid: GridContainer
@export var btn_upgrade: Button
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	if btn_upgrade:
		btn_upgrade.pressed.connect(func():
			if ProgressionSystem.upgrade_room("armory"):
				update_ui()
		)
	update_ui()

func update_ui() -> void:
	var lvl: int = GameManager.game_data.get("outpost_levels", {}).get("armory", 1)
	var inv: Array = GameManager.get_inventory()
	var cap: int = InventorySystem.get_capacity()
	
	if lbl_capacity:
		lbl_capacity.text = "Sức chứa kho: %d / %d (Cấp %d)" % [inv.size(), cap, lvl]
		
	if item_grid:
		for child in item_grid.get_children():
			child.queue_free()
			
		for item in inv:
			var btn := Button.new()
			var iname: String = item.get("name", "Vật phẩm")
			var cnt: int = item.get("count", 1)
			btn.text = "%s (x%d)" % [iname, cnt] if cnt > 1 else iname
			item_grid.add_child(btn)
