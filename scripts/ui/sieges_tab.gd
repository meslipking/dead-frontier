# ═══════════════════════════════════════════════════════════════
#  SIEGES TAB CONTROLLER (sieges_tab.gd)
#  Quản lý 4 trận Vây hãm Boss hàng ngày (Tab 4)
# ═══════════════════════════════════════════════════════════════
extends Control

@export var lbl_attempts: Label
@export var lbl_reset_timer: Label

func _ready() -> void:
	if lbl_attempts: lbl_attempts.text = "Lượt khiêu chiến hôm nay: 3/3"
	if lbl_reset_timer: lbl_reset_timer.text = "Làm mới sau: 23g 59p"
