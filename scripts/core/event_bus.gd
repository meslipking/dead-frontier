# ═══════════════════════════════════════════════════════════════
#  EVENT BUS (event_bus.gd) — Autoload Singleton
#  Central signal hub cho toàn bộ game
# ═══════════════════════════════════════════════════════════════
extends Node

# ─── Navigation ─────────────────────────────────────────────
signal tab_changed(tab_index: int)
signal room_opened(room_type: int)
signal modal_opened(modal_name: String)
signal modal_closed(modal_name: String)

# ─── Unit Events ────────────────────────────────────────────
signal unit_selected(unit_type: int, unit_id: String)
signal unit_leveled_up(unit_type: int, unit_id: String, new_level: int)
signal survivor_recruited(survivor_data: Dictionary)
signal monster_captured(monster_data: Dictionary)
signal monster_evolved(monster_id: String, new_stage: int)
signal mecha_assembled(mecha_data: Dictionary)

# ─── Inventory & Items ──────────────────────────────────────
signal item_acquired(item_data: Dictionary)
signal item_removed(item_id: String)
signal item_equipped(unit_id: String, item_id: String, slot: int)
signal item_unequipped(unit_id: String, slot: int)
signal inventory_changed()

# ─── Crafting ───────────────────────────────────────────────
signal craft_started(recipe_id: String)
signal craft_completed(recipe_id: String, success: bool, item_data: Dictionary)

# ─── Combat ─────────────────────────────────────────────────
signal combat_started(zone_id: String)
signal combat_log_entry(text: String)
signal combat_unit_damaged(unit_id: String, damage: int, is_crit: bool)
signal combat_unit_died(unit_id: String)
signal combat_ended(victory: bool, rewards: Dictionary)

# ─── Idle / Exploration ─────────────────────────────────────
signal zone_progress_updated(zone_id: String, progress: float)
signal zone_sector_cleared(zone_id: String, sector: int)
signal zone_exploration_complete(zone_id: String)
signal loot_acquired(items: Array)
signal offline_report_ready(report: Dictionary)

# ─── Progression ────────────────────────────────────────────
signal currency_changed(currency_type: int, new_amount: int)
signal achievement_unlocked(achievement_id: String)
signal room_upgraded(room_type: int, new_level: int)
signal prestige_activated(shards_gained: int)

# ─── Save ───────────────────────────────────────────────────
signal game_saved()
signal game_loaded()
signal save_corrupted()

# ─── UI Feedback ────────────────────────────────────────────
signal toast_requested(message: String, color: Color, duration: float)
signal screen_shake_requested(intensity: float, duration: float)
