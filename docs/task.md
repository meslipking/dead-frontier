# 📋 TASK LIST — Dead Frontier: Mecha & Monsters
# Engine: Godot 4 + GDScript | Art: SNES 16-bit | Lang: Tiếng Việt | Model: Premium

---

# ═══════════════════════════════════════════════════════════════
# PHASE 1 — FOUNDATION & MVP (HOÀN THÀNH 100%)
# ═══════════════════════════════════════════════════════════════

## 1.1 Project Setup & Config
- [x] Cài đặt Godot 4.4+ config
- [x] Tạo Godot project tại `d:\New game\DeadFrontier\`
- [x] Cấu hình `project.godot`: resolution 360x640, stretch canvas_items, GL Compatibility
- [x] Tạo cấu trúc thư mục 39 subdirectories
- [x] Tạo `.gitignore` & init git repository push lên GitHub

## 1.2 Autoload Singletons
- [x] `scripts/core/constants.gd` — 15 Enums & data tables
- [x] `scripts/core/event_bus.gd` — 30+ Signals
- [x] `scripts/core/game_manager.gd` — State & 4 Currencies
- [x] `scripts/core/save_manager.gd` — FNV-1a Checksum + XOR encryption
- [x] `scripts/core/idle_engine.gd` — Offline simulation & tick engine

## 1.3 - 1.11 Navigation, UI & Scenes
- [x] `scenes/main/Main.tscn` & `main_controller.gd`
- [x] `scenes/shared/BottomNavBar.tscn` & `bottom_nav.gd`
- [x] `scenes/outpost/OutpostTab.tscn` & `room_card.gd` (8 Outpost rooms)
- [x] `scenes/squad/SquadTab.tscn` & `unit_card.gd` (Survivors, Monsters, Mechas)
- [x] `scenes/wastelands/WastelandsTab.tscn` & `zone_card.gd` (7 Zones)
- [x] `scenes/sieges/SiegesTab.tscn` & `sieges_tab.gd` (Daily boss raids)
- [x] `scenes/wastelands/ExplorationReport.tscn` & `exploration_report.gd`

---

# ═══════════════════════════════════════════════════════════════
# PHASE 2 — CORE COMBAT & SYSTEMS (HOÀN THÀNH 100%)
# ═══════════════════════════════════════════════════════════════
- [x] 2.1 Item Database (`item_database.gd`) & Inventory System (`inventory_system.gd`)
- [x] 2.2 Equipment System (`equipment_system.gd`) - equip/unequip & stat bonuses
- [x] 2.3 Turn-Based Combat Engine (`damage_calculator.gd`, `turn_system.gd`, `combat_ai.gd`, `combat_manager.gd`)
- [x] 2.4 Combat UI & Visuals (`CombatScene.tscn`, `combat_ui.gd`)
- [x] 2.5 Monster Capture System (`capture_system.gd`, `monster_database.gd`)
- [x] 2.6 Crafting System (`crafting_system.gd`, `crafting_database.gd`)

---

# ═══════════════════════════════════════════════════════════════
# PHASE 3 — ADVANCED FEATURES (HOÀN THÀNH 100%)
# ═══════════════════════════════════════════════════════════════
- [x] 3.1 Mecha System (`mecha_system.gd`, `mecha_database.gd`) - 4-part robot assembly
- [x] 3.2 Monster Evolution & Breeding (`monster_system.gd`) - 5 evolution stages
- [x] 3.3 Siege System (`siege_database.gd`) - 4 daily boss challenges
- [x] 3.4 Outpost Room Upgrades & Progression (`progression_system.gd`)
- [x] 3.5 Achievement System (`achievement_system.gd`, `achievement_database.gd`) - 50+ achievements
- [x] 3.6 Localization i18n (`vi.csv`, `en.csv`)

---

# ═══════════════════════════════════════════════════════════════
# PHASE 4 — POLISH & DISTRIBUTION (READY FOR DEPLOY)
# ═══════════════════════════════════════════════════════════════
- [x] Save file anti-cheat encryption verified
- [x] Godot project structure verified
- [x] GitHub sync complete (100% code pushed)
