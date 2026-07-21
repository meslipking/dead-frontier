# ═══════════════════════════════════════════════════════════════
#  CHARACTER ANIMATION PROFILES (character_animation_profiles.gd)
#  Định nghĩa 200 Profile Hoạt Ảnh & Hiệu Ứng Độc Bản (200 Units)
# ═══════════════════════════════════════════════════════════════
class_name CharacterAnimationProfiles

static var PROFILES: Dictionary = {}

static func _static_init() -> void:
	_init_adventurer_profiles()
	_init_monster_mecha_profiles()

static func _init_adventurer_profiles() -> void:
	var names_brute := [
		"Iron Defender", "Titan Vanguard", "Aegis Knight", "Colossus", "Bastion",
		"Dreadnought", "Gargoyle", "Obsidian Warden", "Rune Sentinel", "Fortress",
		"Juggernaut", "Paladin Supreme", "Ironclad", "Wall of Doom", "Bulwark",
		"Granite Golem", "Shieldmaster", "Mountain", "Heavy Crusader", "Iron Golem"
	]
	for i in range(names_brute.size()):
		var id_str := "adv_brute_" + str(i + 1)
		PROFILES[id_str] = {
			"name": names_brute[i],
			"class_type": "Brute",
			"traits": "Brute, Nimble" if i % 2 == 0 else "Brute, Tough",
			"level": 18 + (i % 9),
			"primary_color": Color(0.35, 0.4, 0.5),
			"highlight_color": Color(0.85, 0.55, 0.25),
			"vfx_type": "ground_slam_earthquake",
			"weapon_icon_type": Constants.ItemType.WEAPON,
			"armor_icon_type": Constants.ItemType.ARMOR,
			"acc_icon_type": Constants.ItemType.ACCESSORY
		}

	var names_nimble := [
		"Shadow Dancer", "Phantom Scout", "Nightblade", "Specter", "Windwalker",
		"Viper", "Swiftblade", "Assassin", "Stalker", "Mirage",
		"Eclipse", "Cipher", "Raven", "Ghost", "Whisper",
		"Venomblade", "Zephyr", "Razor", "Phantom", "Shadow Weaver"
	]
	for i in range(names_nimble.size()):
		var id_str := "adv_nimble_" + str(i + 1)
		PROFILES[id_str] = {
			"name": names_nimble[i],
			"class_type": "Nimble",
			"traits": "Brute, Nocturnal" if i % 2 == 0 else "Nimble, Evasive",
			"level": 19 + (i % 7),
			"primary_color": Color(0.18, 0.22, 0.28),
			"highlight_color": Color(0.2, 0.85, 0.8),
			"vfx_type": "shadow_dash_teleport",
			"weapon_icon_type": Constants.ItemType.WEAPON,
			"armor_icon_type": Constants.ItemType.ARMOR,
			"acc_icon_type": Constants.ItemType.ACCESSORY
		}

	var names_nocturnal := [
		"Night Terror", "Blood Sorcerer", "Soul Harvester", "Void Weaver", "Necromancer",
		"Nether Lord", "Shadow Lich", "Doom Prophet", "Abyss Mage", "Cultist Leader",
		"Dread Caster", "Vampire Lord", "Skeleton King", "Dark Priest", "Corpse Weaver",
		"Chaos Seeker", "Grave Warden", "Nightmare", "Soul Stealer", "Phantom Weaver"
	]
	for i in range(names_nocturnal.size()):
		var id_str := "adv_nocturnal_" + str(i + 1)
		PROFILES[id_str] = {
			"name": names_nocturnal[i],
			"class_type": "Nocturnal",
			"traits": "Nocturnal" if i % 2 == 0 else "Nocturnal, Soul Drain",
			"level": 19 + (i % 8),
			"primary_color": Color(0.45, 0.15, 0.25),
			"highlight_color": Color(0.9, 0.2, 0.3),
			"vfx_type": "blood_drain_pulse",
			"weapon_icon_type": Constants.ItemType.WEAPON,
			"armor_icon_type": Constants.ItemType.ARMOR,
			"acc_icon_type": Constants.ItemType.ACCESSORY
		}

	var names_feral := [
		"Tempest", "Hailstorm", "Dragon Slayer", "Beastmaster", "Huntress",
		"Wild Fang", "Wolf Lord", "Storm Bow", "Venom Hunter", "Feral Tracker",
		"Eagle Eye", "Falcon", "Tiger Claw", "Bear Chief", "Primal Hunter",
		"Falconeer", "Shadow Panther", "Blood Hound", "Hydra Tamer", "Wyvern Rider"
	]
	for i in range(names_feral.size()):
		var id_str := "adv_feral_" + str(i + 1)
		PROFILES[id_str] = {
			"name": names_feral[i],
			"class_type": "Feral",
			"traits": "Feral, Dragon Blood" if i % 3 == 0 else "Feral",
			"level": 23 + (i % 6),
			"primary_color": Color(0.25, 0.45, 0.25),
			"highlight_color": Color(0.9, 0.7, 0.2),
			"vfx_type": "arrow_storm_slash",
			"weapon_icon_type": Constants.ItemType.WEAPON,
			"armor_icon_type": Constants.ItemType.ARMOR,
			"acc_icon_type": Constants.ItemType.ACCESSORY
		}

	var names_pilot := [
		"King's Hand", "Holy Knight", "Plasma Mech Pilot", "Archon", "Valkyrie",
		"Sun Lord", "Phoenix", "Nova Pilot", "Radiant Paladin", "Celestial Knight",
		"Aegis Commander", "Warp Pilot", "Quantum Knight", "Core Overlord", "Hyperion",
		"Chrono Sentinel", "Solari", "Astral Vanguard", "Zenith", "Mech Prime"
	]
	for i in range(names_pilot.size()):
		var id_str := "adv_pilot_" + str(i + 1)
		PROFILES[id_str] = {
			"name": names_pilot[i],
			"class_type": "Dragon Blood",
			"traits": "Brute" if i % 2 == 0 else "Dragon Blood, Pilot",
			"level": 19 + (i % 10),
			"primary_color": Color(0.75, 0.7, 0.5),
			"highlight_color": Color(0.2, 0.8, 1.0),
			"vfx_type": "plasma_beam_overload",
			"weapon_icon_type": Constants.ItemType.WEAPON,
			"armor_icon_type": Constants.ItemType.ARMOR,
			"acc_icon_type": Constants.ItemType.ACCESSORY
		}

static func _init_monster_mecha_profiles() -> void:
	var elem_names: Array[String] = ["Ice", "Fire", "Poison", "Electric", "Mecha"]
	var base_cols: Array[Color] = [Color(0.2, 0.7, 1.0), Color(1.0, 0.3, 0.2), Color(0.3, 0.9, 0.3), Color(0.9, 0.8, 0.2), Color(0.5, 0.6, 0.7)]
	
	for i in range(1, 101):
		var id_str := "mon_unit_" + str(i)
		var elem_idx := (i - 1) / 20
		var elem_name: String = elem_names[elem_idx]
		var base_col: Color = base_cols[elem_idx]
		PROFILES[id_str] = {
			"name": elem_name + " Beast #" + str(i),
			"class_type": elem_name,
			"traits": elem_name + " Elemental",
			"level": 1 + (i % 50),
			"primary_color": base_col,
			"highlight_color": base_col.lightened(0.4),
			"vfx_type": elem_name.to_lower() + "_burst",
			"weapon_icon_type": Constants.ItemType.WEAPON,
			"armor_icon_type": Constants.ItemType.ARMOR,
			"acc_icon_type": Constants.ItemType.ACCESSORY
		}

static func get_profile(char_id: String) -> Dictionary:
	if PROFILES.is_empty():
		_static_init()
	return PROFILES.get(char_id, {})

static func get_all_adventurer_profiles() -> Array:
	if PROFILES.is_empty():
		_static_init()
	var list := []
	for k in PROFILES:
		if k.begins_with("adv_"):
			list.append(PROFILES[k])
	return list
