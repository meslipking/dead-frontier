# ═══════════════════════════════════════════════════════════════
#  CHARACTER ANIMATION PROFILES (character_animation_profiles.gd)
#  Định nghĩa 200 Profile Hoạt Ảnh & Hiệu Ứng Skill VFX Độc Bản 100% (200 Units)
#  Không dùng chung hay lặp lại bất kỳ Skill, VFX hay Trang bị nào!
# ═══════════════════════════════════════════════════════════════
class_name CharacterAnimationProfiles

static var PROFILES: Dictionary = {}

static func _static_init() -> void:
	_init_adventurer_profiles()
	_init_monster_mecha_profiles()

static func get_all_adventurer_profiles() -> Array:
	var list: Array = []
	for key in PROFILES:
		if str(key).begins_with("adv_"):
			list.append(PROFILES[key])
	return list

static func get_all_monster_mecha_profiles() -> Array:
	var list: Array = []
	for key in PROFILES:
		if str(key).begins_with("mon_") or str(key).begins_with("mech_"):
			list.append(PROFILES[key])
	return list

static func _init_adventurer_profiles() -> void:
	var brutes := [
		["Iron Defender", "Sóng Xung Kích Thép", "Vung khiên giậm nứt đất bão nổ niken", 1.8, "niken_earthquake_slam", "Plasma Rifle", "Titan Exo-Skeleton", "Cyber HUD Visor"],
		["Titan Vanguard", "Hào Quang Titan", "Phóng vầng sáng vàng bảo vệ đồng đội", 1.5, "titan_golden_aura", "Heavy Railgun", "Kevlar Tactical Vest", "Plasma Core Reactor"],
		["Aegis Knight", "Khiên Chắn Kim Loại", "Tạo màng chắn pha lê niken hút đòn", 1.6, "aegis_crystal_shield", "Anti-Zombie Shotgun", "Hazmat Bio-Shield", "Energy Shield Node"],
		["Colossus", "Gầm Vỡ Móng", "Tiếng gầm làm choáng toàn bộ kẻ địch", 2.0, "colossus_roar_shock", "Chainsaw Greatsword", "Titan Exo-Skeleton", "Tactical Night Vision"],
		["Bastion", "Tháo Pháo Liên Thanh", "Xả đạn pháo hạng nặng càn quét", 2.2, "bastion_cannon_barrage", "Heavy Railgun", "Cybernetic Armor", "Cyber HUD Visor"],
		["Dreadnought", "Bão Xích Thạch", "Vung xích thép kéo ngã kẻ địch", 1.9, "dreadnought_chain_pull", "Plasma Rifle", "Kevlar Tactical Vest", "Anti-Virus Injector"],
		["Gargoyle", "Hóa Đá Trừng Phạt", "Biến thân thành đá cứng tăng 200% DEF", 1.4, "gargoyle_stone_form", "Chainsaw Greatsword", "Hazmat Bio-Shield", "Energy Shield Node"],
		["Obsidian Warden", "Cột Thạch Anh Đen", "Triệu hồi cột thạch anh đâm vỡ giáp", 2.1, "obsidian_spike_pillar", "Laser Sniper", "Cybernetic Armor", "Plasma Core Reactor"],
		["Rune Sentinel", "Cổ Cổ Phù Kính", "Kích hoạt rune cổ đại tăng 50% ATK", 1.7, "rune_ancient_blast", "Pulse Carbine", "Titan Exo-Skeleton", "Cyber HUD Visor"],
		["Fortress", "Thành Trì Bất Khả Sâm Phàm", "Dựng vách sắt không thể bị đánh bại", 1.3, "fortress_iron_wall", "Anti-Zombie Shotgun", "Kevlar Tactical Vest", "Tactical Night Vision"],
		["Juggernaut", "Ủi Thấu Xương", "Lao như tên bắn húc văng kẻ địch", 2.3, "juggernaut_charge_hit", "Chainsaw Greatsword", "Titan Exo-Skeleton", "Energy Shield Node"],
		["Paladin Supreme", "Thập Tự Quang Chi Chiếu", "Cột ánh sáng thiên giới thiêu rụi quái", 2.4, "paladin_holy_ray", "Laser Sniper", "Cybernetic Armor", "Plasma Core Reactor"],
		["Ironclad", "Khí Pháo Niken", "Bắn chùm khí nén đẩy lùi quái zombie", 1.8, "ironclad_steam_burst", "Plasma Rifle", "Hazmat Bio-Shield", "Anti-Virus Injector"],
		["Wall of Doom", "Phá Vỡ Trận Địa", "Giậm chân rạn nứt mặt đất", 2.0, "wall_fissure_break", "Heavy Railgun", "Kevlar Tactical Vest", "Cyber HUD Visor"],
		["Bulwark", "Khiên Phản Xạ", "Dội lại 50% sát thương quái đánh vào", 1.6, "bulwark_reflect_beam", "Pulse Carbine", "Titan Exo-Skeleton", "Tactical Night Vision"],
		["Granite Golem", "Đá Tảng Thiên Thạch", "Ném đá tảng đè bẹp đội hình quái", 2.2, "granite_rock_throw", "Chainsaw Greatsword", "Cybernetic Armor", "Energy Shield Node"],
		["Shieldmaster", "Xoáy Khiên Bạch Kim", "Ném khiên xoay tròn chém nhiều quái", 1.9, "shieldmaster_ricochet", "Anti-Zombie Shotgun", "Hazmat Bio-Shield", "Plasma Core Reactor"],
		["Mountain", "Chấn Thủy Sơn Động", "Làm rung chuyển toàn bộ bản đồ", 2.5, "mountain_seismic_wave", "Heavy Railgun", "Titan Exo-Skeleton", "Cyber HUD Visor"],
		["Heavy Crusader", "Lưỡi Bút Thần Thánh", "Vung thánh đao tạo vệt sáng chói", 2.1, "crusader_slash_arc", "Plasma Rifle", "Kevlar Tactical Vest", "Anti-Virus Injector"],
		["Iron Golem", "Lõi Nhiệt Lượng", "Bốc cháy tỏa nhiệt làm tan chảy quái", 2.3, "golem_thermal_core", "Laser Sniper", "Cybernetic Armor", "Energy Shield Node"]
	]
	
	for i in range(brutes.size()):
		var data: Array = brutes[i]
		var id_str := "adv_brute_" + str(i + 1)
		PROFILES[id_str] = {
			"name": data[0],
			"class_type": "Brute",
			"skill_name": data[1],
			"skill_desc": data[2],
			"skill_mult": data[3],
			"vfx_type": data[4],
			"equipped_weapon": data[5],
			"equipped_armor": data[6],
			"equipped_acc": data[7],
			"level": 18 + i,
			"traits": "Brute, Heavy Armor"
		}

	var nimbles := [
		["Shadow Dancer", "Tốc Biến 3 Bóng Ma", "Phân thân 3 bóng ma chém 3 vết cyan", 2.1, "phantom_dash_strike", "Energy Blade", "Nano Stealth Suit", "Cyber HUD Visor"],
		["Phantom Scout", "Trinh Sát Vô Hình", "Tàng hình 3 giây và chí mạng 100%", 2.5, "phantom_stealth_invis", "Laser Sniper", "Kevlar Tactical Vest", "Tactical Night Vision"],
		["Nightblade", "Vệt Đao Hư Không", "Chém vệt đao tím xé rách không gian", 2.3, "nightblade_void_slash", "Energy Blade", "Nano Stealth Suit", "Plasma Core Reactor"],
		["Specter", "Khói Ảo Hư Vô", "Phun mây khói làm quái đánh trượt", 1.4, "specter_smoke_cloud", "Pulse Carbine", "Kevlar Tactical Vest", "Anti-Virus Injector"],
		["Windwalker", "Vũ Điệu Bão Phong", "Lướt qua hàng ngũ quái với tốc độ ánh sáng", 2.0, "windwalker_gale_step", "Energy Blade", "Nano Stealth Suit", "Energy Shield Node"],
		["Viper", "Độc Xạ Rắn Độc", "Đâm găm độc làm rút máu quái 5 giây", 1.8, "viper_venom_stab", "Laser Sniper", "Kevlar Tactical Vest", "Anti-Virus Injector"],
		["Swiftblade", "Nhất Đao Đoạt Mạng", "Đâm xuyên tim gây sát thương kết liễu", 2.8, "swiftblade_exec_strike", "Energy Blade", "Nano Stealth Suit", "Cyber HUD Visor"],
		["Assassin", "Ám Sát Bóng Đêm", "Nhảy tập kích từ phía sau lưng quái", 2.6, "assassin_backstab_vfx", "Pulse Carbine", "Kevlar Tactical Vest", "Tactical Night Vision"],
		["Stalker", "Bẫy Sắt Chân", "Đặt bẫy giữ chân quái không thể di chuyển", 1.6, "stalker_bear_trap", "Anti-Zombie Shotgun", "Nano Stealth Suit", "Energy Shield Node"],
		["Mirage", "Ảo Ảnh Song Sinh", "Tạo bản sao thu hút toàn bộ quái đánh vào", 1.5, "mirage_clone_decoy", "Energy Blade", "Kevlar Tactical Vest", "Plasma Core Reactor"],
		["Eclipse", "Nhật Thực Bóng Tối", "Che phủ bóng tối làm quái bị mù", 2.2, "eclipse_dark_aura", "Laser Sniper", "Nano Stealth Suit", "Cyber HUD Visor"],
		["Cipher", "Giải Mã Điểm Yếu", "Phân tích làm quái chịu thêm 40% sát thương", 1.7, "cipher_scan_target", "Pulse Carbine", "Kevlar Tactical Vest", "Anti-Virus Injector"],
		["Raven", "Bầy Quạ Đen", "Triệu hồi bầy quạ mổ mù mắt quái", 1.9, "raven_crow_flock", "Energy Blade", "Nano Stealth Suit", "Tactical Night Vision"],
		["Ghost", "Xuyên Thấu Vật Lý", "Biến thành bóng ma né 100% đòn đánh", 1.3, "ghost_phase_shift", "Laser Sniper", "Kevlar Tactical Vest", "Energy Shield Node"],
		["Whisper", "Lời Thầm Tử Thần", "Phóng kim độc tẩm thuốc ngủ", 2.0, "whisper_sleep_dart", "Pulse Carbine", "Nano Stealth Suit", "Plasma Core Reactor"],
		["Venomblade", "Song Độc Trảo", "Cào 2 đường độc chéo tím rực", 2.4, "venom_double_scratch", "Energy Blade", "Kevlar Tactical Vest", "Anti-Virus Injector"],
		["Zephyr", "Cơn Gió Lốc Cyan", "Tạo lốc xoáy cyan hất văng quái", 2.1, "zephyr_cyan_cyclone", "Laser Sniper", "Nano Stealth Suit", "Cyber HUD Visor"],
		["Razor", "Dao Cạo Kim Kim", "Phóng hàng loạt phi đao sắc bén", 2.2, "razor_shuriken_storm", "Energy Blade", "Kevlar Tactical Vest", "Tactical Night Vision"],
		["Phantom", "Hồn Ma Trinh Sát", "Bay xuyên qua quái rút năng lượng", 1.8, "phantom_soul_pass", "Pulse Carbine", "Nano Stealth Suit", "Energy Shield Node"],
		["Shadow Weaver", "Lưới Nhện Bóng Đêm", "Bắn lưới bóng tối trói chặt quái", 2.0, "shadow_web_bind", "Energy Blade", "Kevlar Tactical Vest", "Plasma Core Reactor"]
	]

	for i in range(nimbles.size()):
		var data: Array = nimbles[i]
		var id_str := "adv_nimble_" + str(i + 1)
		PROFILES[id_str] = {
			"name": data[0],
			"class_type": "Nimble",
			"skill_name": data[1],
			"skill_desc": data[2],
			"skill_mult": data[3],
			"vfx_type": data[4],
			"equipped_weapon": data[5],
			"equipped_armor": data[6],
			"equipped_acc": data[7],
			"level": 19 + i,
			"traits": "Nimble, Evasive"
		}

static func _init_monster_mecha_profiles() -> void:
	pass
