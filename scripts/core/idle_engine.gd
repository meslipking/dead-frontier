# ═══════════════════════════════════════════════════════════════
#  IDLE ENGINE (idle_engine.gd) — Autoload Singleton
#  Manages idle tick, offline progress calculation
# ═══════════════════════════════════════════════════════════════
extends Node

var _tick_timer: float = 0.0
const TICK_INTERVAL := 1.0  # 1 giây mỗi tick

func _ready() -> void:
	# Khi game loaded → check offline progress
	EventBus.game_loaded.connect(_on_game_loaded)

func _process(delta: float) -> void:
	if not GameManager.is_loaded:
		return
	
	_tick_timer += delta
	if _tick_timer >= TICK_INTERVAL:
		_tick_timer -= TICK_INTERVAL
		_idle_tick()

# ─── Idle Tick (1/giây khi online) ─────────────────────────
func _idle_tick() -> void:
	var zone_teams: Dictionary = GameManager.game_data.get("zone_teams", {})
	var zone_progress: Dictionary = GameManager.game_data.get("zone_progress", {})
	
	for zone_id in zone_teams:
		var team: Array = zone_teams[zone_id]
		if team.is_empty():
			continue
		
		# Tính team power
		var team_power := _calculate_team_power(team)
		
		# Tăng progress
		var current: float = zone_progress.get(zone_id, 0.0)
		var gain: float = team_power * 0.01  # base rate
		current += gain
		
		# Check sector clear (mỗi 100 progress = 1 sector)
		var sectors_before := int(current - gain) / 100
		var sectors_after := int(current) / 100
		if sectors_after > sectors_before:
			EventBus.zone_sector_cleared.emit(zone_id, sectors_after)
			_generate_sector_loot(zone_id, sectors_after)
		
		zone_progress[zone_id] = current
		EventBus.zone_progress_updated.emit(zone_id, current)
	
	GameManager.game_data["zone_progress"] = zone_progress
	
	# Update playtime
	var stats: Dictionary = GameManager.game_data.get("lifetime_stats", {})
	stats["playtime_seconds"] = stats.get("playtime_seconds", 0) + 1
	GameManager.game_data["lifetime_stats"] = stats

# ─── Team Power Calculation ─────────────────────────────────
func _calculate_team_power(team_ids: Array) -> float:
	var total_power := 0.0
	var survivors: Array = GameManager.game_data.get("survivors", [])
	var monsters: Array = GameManager.game_data.get("monsters", [])
	var mechas: Array = GameManager.game_data.get("mechas", [])
	
	for unit_id in team_ids:
		for s in survivors:
			if s.get("id") == unit_id:
				var stats: Dictionary = s.get("stats", {})
				total_power += stats.get("atk", 10) + stats.get("def", 5) + stats.get("hp", 50) * 0.1
				break
		for m in monsters:
			if m.get("id") == unit_id:
				var stats: Dictionary = m.get("stats", {})
				total_power += stats.get("atk", 10) + stats.get("def", 5) + stats.get("hp", 50) * 0.1
				break
		for mc in mechas:
			if mc.get("id") == unit_id:
				total_power += mc.get("power_level", 50)
				break
	
	return max(total_power, 1.0)

# ─── Sector Loot Generation ────────────────────────────────
func _generate_sector_loot(zone_id: String, sector: int) -> void:
	# TODO: Use zone_database loot tables + seeded PRNG
	var loot := []
	# Placeholder: give some gold per sector
	GameManager.add_currency(Constants.Currency.GOLD, 5 + sector)
	EventBus.loot_acquired.emit(loot)

# ─── Offline Progress ──────────────────────────────────────
func _on_game_loaded() -> void:
	var last_time: int = GameManager.game_data.get("last_online_timestamp", 0)
	if last_time <= 0:
		return
	
	var now := int(Time.get_unix_time_from_system())
	var offline_seconds := now - last_time
	
	if offline_seconds < 60:
		return  # Quá ngắn, bỏ qua
	
	# Cap offline at 8 hours
	offline_seconds = min(offline_seconds, 8 * 3600)
	
	print("[IdleEngine] Offline for ", offline_seconds, " seconds. Simulating...")
	
	var report := _simulate_offline(offline_seconds)
	
	if report.get("total_gold", 0) > 0 or report.get("sectors_cleared", 0) > 0:
		EventBus.offline_report_ready.emit(report)

func _simulate_offline(seconds: int) -> Dictionary:
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
	
	# Simulate ticks
	var ticks := seconds  # 1 tick/giây
	for zone_id in zone_teams:
		var team: Array = zone_teams[zone_id]
		if team.is_empty():
			continue
		
		var team_power := _calculate_team_power(team)
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
	
	# Apply rewards
	GameManager.game_data["zone_progress"] = zone_progress
	GameManager.add_currency(Constants.Currency.GOLD, report["gold_earned"])
	
	return report
