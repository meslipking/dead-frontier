# ═══════════════════════════════════════════════════════════════
#  GAME MANAGER (game_manager.gd) — Autoload Singleton & Permadeath System
#  Quản lý game state, tab routing, game data, Lực Chiến Squad CP & Tử Trận Permanently
# ═══════════════════════════════════════════════════════════════
extends Node

# ─── Game State ─────────────────────────────────────────────
var game_data: Dictionary = {}
var current_tab: int = 0
var is_loaded: bool = false

# ─── Tab indices ────────────────────────────────────────────
const TAB_OUTPOST := 0
const TAB_SQUAD := 1
const TAB_WASTELANDS := 2
const TAB_SIEGES := 3

func _ready() -> void:
	game_data = SaveManager.load_game()
	is_loaded = true
	EventBus.game_loaded.emit()
	print("[GameManager] Game loaded. Gold: ", game_data.get("gold", 0))

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
		get_tree().quit()

# ─── Tab Switching ──────────────────────────────────────────
func switch_tab(tab_index: int) -> void:
	current_tab = tab_index
	EventBus.tab_changed.emit(tab_index)

# ─── Currency Management ────────────────────────────────────
func get_currency(currency_type: int) -> int:
	match currency_type:
		Constants.Currency.GOLD: return game_data.get("gold", 0)
		Constants.Currency.ALLOYS: return game_data.get("alloys", 0)
		Constants.Currency.ENERGY: return game_data.get("energy", 0)
		Constants.Currency.CRYSTALS: return game_data.get("crystals", 0)
	return 0

func add_currency(currency_type: int, amount: int) -> void:
	var key := _currency_key(currency_type)
	game_data[key] = game_data.get(key, 0) + amount
	EventBus.currency_changed.emit(currency_type, game_data[key])

func spend_currency(currency_type: int, amount: int) -> bool:
	var key := _currency_key(currency_type)
	var current: int = game_data.get(key, 0)
	if current < amount:
		return false
	game_data[key] = current - amount
	EventBus.currency_changed.emit(currency_type, game_data[key])
	return true

func _currency_key(currency_type: int) -> String:
	match currency_type:
		Constants.Currency.GOLD: return "gold"
		Constants.Currency.ALLOYS: return "alloys"
		Constants.Currency.ENERGY: return "energy"
		Constants.Currency.CRYSTALS: return "crystals"
	return "gold"

# ─── Unit Access & Squad Combat Power (CP) ─────────────────
func get_survivors() -> Array:
	return game_data.get("survivors", [])

func calculate_squad_cp() -> int:
	var survivors: Array = get_survivors()
	var total_cp: int = 0
	for adv in survivors:
		var lvl: int = int(adv.get("level", 1))
		var stats: Dictionary = adv.get("stats", {})
		var atk: int = int(stats.get("atk", 20))
		var def: int = int(stats.get("def", 15))
		total_cp += (lvl * 15) + atk + def
	return total_cp

func remove_survivor(survivor_name: String) -> bool:
	var survivors: Array = game_data.get("survivors", [])
	for i in range(survivors.size() - 1, -1, -1):
		if str(survivors[i].get("name", "")) == survivor_name:
			survivors.remove_at(i)
			game_data["survivors"] = survivors
			save_game()
			EventBus.tab_changed.emit(current_tab) # Refresh UI list
			print("[GameManager] Permanent Death: ", survivor_name, " removed from squad roster.")
			return true
	return false

func get_monsters() -> Array:
	return game_data.get("monsters", [])

func get_mechas() -> Array:
	return game_data.get("mechas", [])

func get_inventory() -> Array:
	return game_data.get("inventory", [])

# ─── Save ───────────────────────────────────────────────────
func save_game() -> void:
	game_data["last_online_timestamp"] = int(Time.get_unix_time_from_system())
	SaveManager.save_game(game_data)
	EventBus.game_saved.emit()
