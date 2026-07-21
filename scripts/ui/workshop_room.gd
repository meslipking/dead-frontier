# ═══════════════════════════════════════════════════════════════
#  WORKSHOP ROOM CONTROLLER (workshop_room.gd)
#  Quản lý Xưởng Máy Chế Tạo Trang Bị & Nguyên Liệu
# ═══════════════════════════════════════════════════════════════
extends Control

@export var recipe_list_container: VBoxContainer
@export var lbl_status: Label
@export var btn_close: Button

func _ready() -> void:
	if btn_close: btn_close.pressed.connect(func(): hide())
	populate_recipes()

func populate_recipes() -> void:
	if not recipe_list_container:
		return
		
	for child in recipe_list_container.get_children():
		child.queue_free()
		
	var recipes := CraftingDatabase.get_all_recipes()
	for r in recipes:
		var btn := Button.new()
		btn.text = "Chế tạo %s (50 Vàng)" % r["name"]
		btn.pressed.connect(func():
			var result := CraftingSystem.craft_item(r)
			if result["success"]:
				if lbl_status: lbl_status.text = "✨ CHẾ TẠO THÀNH CÔNG: " + r["name"]
			else:
				if lbl_status: lbl_status.text = "❌ Thất bại: " + result.get("reason", "")
		)
		recipe_list_container.add_child(btn)
