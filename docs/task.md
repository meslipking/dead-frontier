# 📋 TASK LIST — Dead Frontier: Mecha & Monsters
# Engine: Godot 4 + GDScript | Art: SNES 16-bit | Lang: Tiếng Việt | Model: Premium

---

# ═══════════════════════════════════════════════════════════════
# PHASE 1 — FOUNDATION & MVP (HOÀN THÀNH)
# Mục tiêu: Game chạy được, 4 tab, idle loop, save/load
# ═══════════════════════════════════════════════════════════════

## 1.1 Project Setup & Config
- [x] Cài đặt Godot 4.4+ config
- [x] Tạo Godot project tại `d:\New game\DeadFrontier\`
- [x] Cấu hình `project.godot`: tên game, icon, resolution 360x640 (portrait mobile, scale up PC)
- [x] Cấu hình stretch mode = `canvas_items`, aspect = `expand` (responsive)
- [x] Cấu hình rendering: Compatibility (GL Compatibility)
- [x] Tạo cấu trúc thư mục: scenes/, scripts/, resources/, assets/, locale/, docs/
- [x] Tạo `.gitignore` cho Godot project
- [x] Init git repository & push lên GitHub

## 1.2 Autoload Singletons
- [x] Tạo `scripts/core/constants.gd` — Enums & data dictionaries (UnitType, Element, Rarity, ItemType, RoomType)
- [x] Tạo `scripts/core/event_bus.gd` — Autoload signal bus (30+ signals)
- [x] Tạo `scripts/core/game_manager.gd` — Autoload game state & currency
- [x] Tạo `scripts/core/save_manager.gd` — Autoload save/load + FNV-1a encryption + starter save data
- [x] Tạo `scripts/core/idle_engine.gd` — Autoload idle tick & offline simulation
- [x] Đăng ký 5 autoloads trong `project.godot`

## 1.3 Design System & Theme
- [x] Cấu hình theme màu sắc (Deep Dark #0a0d12, Post-apocalyptic Orange #e85d3a, Toxic Teal #4ecdc4)
- [x] Cấu hình Rarity color palette (Common → Mythic)
- [x] Setup font sizes & layout spacing

## 1.4 Main Scene & Navigation
- [x] Tạo `scenes/main/Main.tscn` (Root scene với TopBar & ContentArea)
- [x] Tạo `scenes/shared/BottomNavBar.tscn` (4 tab buttons: Tiền đồn, Đội hình, Vùng hoang, Vây hãm)
- [x] Tạo `scripts/ui/bottom_nav.gd` (Highlight active tab, emit signals)
- [x] Tạo `scripts/ui/main_controller.gd` (Show/hide tab scenes & update currencies)

## 1.5 Outpost Tab (Tab 1)
- [x] Tạo `scenes/outpost/OutpostTab.tscn` (2-column GridContainer)
- [x] Tạo `scenes/shared/RoomCard.tscn` (Reusable room card component)
- [x] Tạo `scripts/ui/room_card.gd` (Setup room icon, title, level, description)
- [x] Tạo `scripts/ui/outpost_tab.gd` (Populate 8 phòng: Boong-ke, Đài Phát Sóng, Kho Vũ Khí, Chợ Đen, Xưởng Máy, Chuồng Thú, Nhà Kho Mecha, Trung Tâm Chỉ Huy)

## 1.6 Squad Tab (Tab 2) — Survivors Sub-tab
- [x] Tạo `scenes/squad/SquadTab.tscn` (Sub-tab nav: Người sống sót \| Quái vật \| Mecha)
- [x] Tạo `scenes/shared/UnitCard.tscn` (Reusable unit card component)
- [x] Tạo `scripts/data/survivor_database.gd` (6 classes, base stats, traits, random generator)
- [x] Tạo `scripts/ui/unit_card.gd` (Display unit icon, name, level, class/type)
- [x] Tạo `scripts/ui/squad_tab.gd` (Switch sub-tabs, populate units from save data)
- [x] 4 starter survivors được tự động tạo trong save data

## 1.7 Wastelands Tab (Tab 3)
- [x] Tạo `scenes/wastelands/WastelandsTab.tscn` (List container cho 7 zones)
- [x] Tạo `scenes/shared/ZoneCard.tscn` (Zone card component với progress bar & lock overlay)
- [x] Tạo `scripts/data/zone_database.gd` (7 zones: Ngoại ô, Cống ngầm, Nhà máy, Cảng đóng băng, Hố bom, Tổ zombie, Pháo đài)
- [x] Tạo `scripts/ui/zone_card.gd` (Display zone name, difficulty stars, progress bar, unlock state)
- [x] Tạo `scripts/ui/wastelands_tab.gd` (Populate zones, update exploration progress live)

## 1.8 Sieges Tab (Tab 4)
- [x] Tạo `scenes/sieges/SiegesTab.tscn` (Header attempts counter & Boss challenge cards)
- [x] Tạo `scripts/ui/sieges_tab.gd` (Manage daily attempts & countdown timer)

## 1.9 Idle Engine — Core Loop
- [x] Hoàn thiện `scripts/core/idle_engine.gd` (Per-second tick, zone exploration progress, loot generation)
- [x] Tạo `scripts/utils/prng.gd` (Mulberry32 seeded PRNG cho offline calculation)

## 1.10 Save System — Foundation
- [x] Hoàn thiện `scripts/core/save_manager.gd` (Save/Load JSON + FNV-1a checksum + XOR cipher)
- [x] Starter save data chứa currencies, 4 survivors, starter items, 8 outpost rooms, zone progress

## 1.11 Offline Progress
- [x] Offline calculation trong `idle_engine.gd` khi mở lại game (up to 8 hours)
- [x] Tạo `scripts/ui/exploration_report.gd` & `scenes/wastelands/ExplorationReport.tscn` popup

---

# ═══════════════════════════════════════════════════════════════
# PHASE 2 — CORE COMBAT & SYSTEMS (ĐANG TIẾN HÀNH)
# ═══════════════════════════════════════════════════════════════
- [ ] 2.1 Item Database & Inventory System
- [ ] 2.2 Equipment System
- [ ] 2.3 Turn-Based Combat Engine (Damage formula, Element wheel, Turn order)
- [ ] 2.4 Combat UI & Visuals
- [ ] 2.5 Monster Capture System
- [ ] 2.6 Crafting System
