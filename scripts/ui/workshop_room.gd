# ═══════════════════════════════════════════════════════════════
#  WORKSHOP ROOM CONTROLLER (workshop_room.gd)
# ═══════════════════════════════════════════════════════════════
extends Control

const CraftDb = preload("res://scripts/data/crafting_database.gd")
const CraftSys = preload("res://scripts/systems/crafting_system.gd")

@export var recipe_container: VBoxContainer
@export var lbl_status: Label
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	populate_recipes()

func populate_recipes() -> void:
	if not recipe_container:
		return
		
	for child in recipe_container.get_children():
		child.queue_free()
		
	var recipes: Array = CraftDb.get_all_recipes()
	for r in recipes:
		var btn := Button.new()
		var cost: int = r.get("gold_cost", 50)
		btn.text = "Chế tạo %s (%d Vàng)" % [r.get("name", ""), cost]
		btn.pressed.connect(func():
			var res: Dictionary = CraftSys.craft_item(r)
			var ok: bool = res.get("success", false)
			if lbl_status:
				lbl_status.text = "🛠️ ĐÃ CHẾ TẠO THÀNH CÔNG!" if ok else ("❌ " + res.get("reason", "Thất bại!"))
		)
		recipe_container.add_child(btn)
