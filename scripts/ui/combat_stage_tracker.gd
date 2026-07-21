# ═══════════════════════════════════════════════════════════════
#  COMBAT STAGE TRACKER CONTROLLER (combat_stage_tracker.gd)
#  Điều khiển Thanh Tiến Trình Di Chuyển Thám Hiểm Ải Realtime & SQUAD VALIDATION
# ═══════════════════════════════════════════════════════════════
extends Control

const MasterPixel = preload("res://scripts/utils/master_pixel_art_engine.gd")
const StageGen = preload("res://scripts/systems/procedural_stage_generator.gd")
const DropSys = preload("res://scripts/systems/procedural_drop_system.gd")

@export var lbl_stage_title: Label
@export var lbl_modifier: Label
@export var progress_bar: ProgressBar
@export var party_avatar: TextureRect
@export var lbl_drop_toast: Label

var cur_stage := 1
var progress_val := 0.0
var frame_idx := 0
var anim_timer := 0.0

func _ready() -> void:
	if party_avatar:
		party_avatar.texture = MasterPixel.get_unit_16frame_texture("Iron Defender", "walk", 0)
	_load_stage(cur_stage)

func _process(delta: float) -> void:
	# Squad Validation Check: Do not allow exploration with 0 heroes!
	var survivors: Array = GameManager.get_survivors()
	if survivors.size() == 0:
		if lbl_drop_toast:
			lbl_drop_toast.text = "⚠️ BẠN CHƯA CÓ ANH HÙNG! VÀO HEADQUARTERS -> TAVERN ĐỂ CHIÊU MỘ."
			lbl_drop_toast.add_theme_color_override("font_color", Color(1.0, 0.3, 0.3))
		if party_avatar: party_avatar.visible = false
		return
	else:
		if party_avatar: party_avatar.visible = true
	
	# Advance stage progress bar smoothly
	progress_val += delta * 15.0
	if progress_val >= 100.0:
		progress_val = 0.0
		cur_stage += 1
		_load_stage(cur_stage)
		
	if progress_bar: progress_bar.value = progress_val
	if party_avatar and progress_bar:
		var parent_width: float = progress_bar.size.x
		party_avatar.position.x = (progress_val / 100.0) * (parent_width - 24.0)
		
	# Animate walking avatar
	anim_timer += delta
	if anim_timer >= 0.15:
		anim_timer -= 0.15
		frame_idx = (frame_idx + 1) % 4
		if party_avatar:
			var hero_name: String = str(survivors[0].get("name", "Iron Defender"))
			party_avatar.texture = MasterPixel.get_unit_16frame_texture(hero_name, "walk", frame_idx)

func _load_stage(stg_num: int) -> void:
	var stg_data: Dictionary = StageGen.generate_stage_data(stg_num)
	if lbl_stage_title: lbl_stage_title.text = str(stg_data["title"])
	if lbl_modifier:
		lbl_modifier.text = "⚙️ QUY TẮC: " + str(stg_data["modifier_name"]).to_upper() + " (" + str(stg_data["modifier_effect"]) + ")"
		lbl_modifier.add_theme_color_override("font_color", stg_data["modifier_color"])
		
	var rewards: Dictionary = DropSys.calculate_stage_rewards(str(stg_data["env_name"]), stg_num)
	GameManager.add_currency(Constants.Currency.GOLD, int(rewards["gold"]))
	if lbl_drop_toast:
		lbl_drop_toast.text = "🎁 VỪA RỢI: +1 " + str(rewards["special_material"]) + " & " + str(rewards["gold"]) + " VÀNG"
		lbl_drop_toast.add_theme_color_override("font_color", Color(0.3, 0.9, 0.4))
