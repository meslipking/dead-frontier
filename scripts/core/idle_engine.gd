# ═══════════════════════════════════════════════════════════════
#  IDLE ENGINE (idle_engine.gd) — Autoload Singleton
#  Manages idle tick, offline progress calculation & optimized unit power cache
# ═══════════════════════════════════════════════════════════════
extends Node

const EquipSys = preload("res://scripts/systems/equipment_system.gd")

var _tick_timer: float = 0.0
const TICK_INTERVAL := 1.0  # 1 giây mỗi tick
var _unit_power_cache := {}
var _cache_dirty := true

func _ready() -> void:
	EventBus.game_loaded.connect(_on_game_loaded)
	EventBus.unit_leveled_up.connect(func(_t, _id, _l): mark_cache_dirty())
	EventBus.item_equipped.connect(func(_u, _i, _s): mark_cache_dirty())
	EventBus.item_unequipped.connect(func(_u, _s): mark_cache_dirty())

func mark_cache_dirty() -> void:
	_cache_dirty = true

func _process(delta: float) -> void:
	if not GameManager.is_loaded:
		return
	
	_tick_timer += delta
	if _tick_timer >= TICK_INTERVAL:
		_tick_timer -= TICK_INTERVAL
		_idle_tick()

func _idle_tick() -> void:
	if _cache_dirty:
		_rebuild_unit_power_cache()
		
	var zone_teams: Dictionary = GameManager.game_data.get("zone_teams", {})
	var zone_progress: Dictionary = GameManager.game_data.get("zone_progress", {})
	
	for zone_id in zone_teams:
		var team: Array = zone_teams[zone_id]
		if team.is_empty():
			continue
		
		var team_power := _calculate_cached_team_power(team)
		var current: float = zone_progress.get(zone_id, 0.0)
		var gain: float = team_power * 0.01
		current += gain
		
		var sectors_before := int(current - gain) / 100
		var sectors_after := int(current) / 100
		if sectors_after > sectors_before:
			EventBus.zone_sector_cleared.emit(zone_id, sectors_after)
			_generate_sector_loot(zone_id, sectors_after)
		
		zone_progress[zone_id] = current
		EventBus.zone_progress_updated.emit(zone_id, current)
	
	GameManager.game_data["zone_progress"] = zone_progress
	
	var stats: Dictionary = GameManager.game_data.get("lifetime_stats", {})
	stats["playtime_seconds"] = stats.get("playtime_seconds", 0) + 1
	GameManager.game_data["lifetime_stats"] = stats

func _rebuild_unit_power_cache() -> void:
	_unit_power_cache.clear()
	var survivors: Array = GameManager.game_data.get("survivors", [])
	for s in survivors:
		var stats: Dictionary = s.get("stats", {})
		var eq_stats: Dictionary = EquipSys.get_total_equipment_stats(s.get("id", ""))
		var atk: float = stats.get("atk", 10) + eq_stats.get("atk", 0)
		var def: float = stats.get("def", 5) + eq_stats.get("def", 0)
		var hp: float = stats.get("hp", 50) + eq_stats.get("hp", 0)
		_unit_power_cache[s.get("id")] = atk + def + hp * 0.1
		
	var monsters: Array = GameManager.game_data.get("monsters", [])
	for m in monsters:
		var stats: Dictionary = m.get("stats", {})
		_unit_power_cache[m.get("id")] = stats.get("atk", 10) + stats.get("def", 5) + stats.get("hp", 50) * 0.1
		
	var mechas: Array = GameManager.game_data.get("mechas", [])
	for mc in mechas:
		_unit_power_cache[mc.get("id")] = mc.get("power_level", 50)
		
	_cache_dirty = false

func _calculate_cached_team_power(team_ids: Array) -> float:
	var total := 0.0
	for uid in team_ids:
		total += _unit_power_cache.get(uid, 10.0)
	return max(total, 1.0)

func _generate_sector_loot(zone_id: String, sector: int) -> void:
	GameManager.add_currency(Constants.Currency.GOLD, 5 + sector)
	EventBus.loot_acquired.emit([])

func _on_game_loaded() -> void:
	_cache_dirty = true
	var last_time: int = GameManager.game_data.get("last_online_timestamp", 0)
	if last_time <= 0:
		return
	
	var now := int(Time.get_unix_time_from_system())
	var offline_seconds := now - last_time
	if offline_seconds < 60:
		return
		
	offline_seconds = min(offline_seconds, 8 * 3600)
	print("[IdleEngine] Offline for ", offline_seconds, " seconds. Simulating...")
	
	var report := _simulate_offline(offline_seconds)
	if report.get("gold_earned", 0) > 0 or report.get("sectors_cleared", 0) > 0:
		EventBus.offline_report_ready.emit(report)

func _simulate_offline(seconds: int) -> Dictionary:
	_rebuild_unit_power_cache()
	var report := {
		"duration_seconds": seconds,
		"sectors_cleared": 0,
		"gold_earned": 0,
		"exp_earned": 0,
		"enemies_slain": 0,
		"loot": [],
	}
	
	var zone_teams: Dictionary = GameManager.game_data.get("zone_teams", {})
	var zone_progress: Dictionary = GameManager.game_data.get("zone_progress", {})
	
	var ticks := seconds
	for zone_id in zone_teams:
		var team: Array = zone_teams[zone_id]
		if team.is_empty():
			continue
		
		var team_power := _calculate_cached_team_power(team)
		var total_gain: float = team_power * 0.01 * ticks
		var current: float = zone_progress.get(zone_id, 0.0)
		
		var sectors_before := int(current) / 100
		current += total_gain
		var sectors_after := int(current) / 100
		
		var new_sectors := sectors_after - sectors_before
		report["sectors_cleared"] += new_sectors
		report["gold_earned"] += new_sectors * 10
		report["enemies_slain"] += new_sectors * 5
		report["exp_earned"] += new_sectors * 15
		
		zone_progress[zone_id] = current
	
	GameManager.game_data["zone_progress"] = zone_progress
	GameManager.add_currency(Constants.Currency.GOLD, report["gold_earned"])
	return report
