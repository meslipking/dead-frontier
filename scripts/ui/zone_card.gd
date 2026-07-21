# ═══════════════════════════════════════════════════════════════
#  ZONE CARD CONTROLLER (zone_card.gd)
#  Hiển thị 1 Vùng hoang (Zone) trong Wastelands Tab
# ═══════════════════════════════════════════════════════════════
extends PanelContainer

@export var name_label: Label
@export var difficulty_label: Label
@export var desc_label: Label
@export var progress_bar: ProgressBar
@export var btn_explore: Button
@export var lock_overlay: Control
@export var lock_reason_label: Label

var zone_data: Dictionary = {}
var is_unlocked: bool = false

func setup(p_zone: Dictionary) -> void:
	zone_data = p_zone
	var zid: String = zone_data.get("id", "")
	var unlocked_zones: Array = GameManager.game_data.get("unlocked_zones", [])
	is_unlocked = unlocked_zones.has(zid)
	
	if name_label: name_label.text = zone_data.get("name", "Vùng hoang")
	if difficulty_label:
		var diff: int = zone_data.get("difficulty", 1)
		var stars := ""
		for i in diff: stars += "⭐"
		difficulty_label.text = stars
		
	if desc_label: desc_label.text = zone_data.get("description", "")
	
	if lock_overlay:
		lock_overlay.visible = not is_unlocked
	if lock_reason_label:
		lock_reason_label.text = "🔒 " + zone_data.get("unlock_req", "Chưa mở khóa")
		
	if btn_explore:
		btn_explore.disabled = not is_unlocked
		btn_explore.pressed.connect(func(): EventBus.combat_started.emit(zid))
		
	update_progress()

func update_progress() -> void:
	var zid: String = zone_data.get("id", "")
	var zone_progress: Dictionary = GameManager.game_data.get("zone_progress", {})
	var prog: float = zone_progress.get(zid, 0.0)
	
	if progress_bar:
		progress_bar.value = fmod(prog, 100.0)
