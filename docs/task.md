# 📋 TASK LIST — Dead Frontier: Mecha & Monsters
# Engine: Godot 4 + GDScript | Art: SNES 16-bit | Lang: Tiếng Việt | Model: Premium

---

# ═══════════════════════════════════════════════════════════════
# PHASE 1 — FOUNDATION & MVP (Tuần 1-3)
# Mục tiêu: Game chạy được, 4 tab, idle loop, save/load
# ═══════════════════════════════════════════════════════════════

## 1.1 Project Setup & Config
- [ ] Cài đặt Godot 4.4+ (bản Standard, không cần .NET)
- [ ] Tạo Godot project tại `d:\New game\DeadFrontier\`
- [ ] Cấu hình `project.godot`: tên game, icon, resolution 360x640 (portrait mobile, scale up PC)
- [ ] Cấu hình stretch mode = `canvas_items`, aspect = `expand` (responsive)
- [ ] Cấu hình rendering: Compatibility (mobile) hoặc Forward+ (PC)
- [ ] Tạo cấu trúc thư mục: scenes/, scripts/, resources/, assets/, locale/, docs/
- [ ] Tạo `.gitignore` cho Godot project (bỏ .godot/, builds/)
- [ ] Init git repository

## 1.2 Autoload Singletons
- [ ] Tạo `scripts/core/constants.gd` — Enums (UnitType, Element, Rarity, ItemType, RoomType)
- [ ] Tạo `scripts/core/event_bus.gd` — Autoload signal bus (signal tab_changed, unit_selected, item_acquired...)
- [ ] Tạo `scripts/core/game_manager.gd` — Autoload game state (current_tab, game_data dict, init/reset)
- [ ] Tạo `scripts/core/save_manager.gd` — Autoload save/load (placeholder, chưa encryption)
- [ ] Tạo `scripts/core/idle_engine.gd` — Autoload idle tick (placeholder timer)
- [ ] Đăng ký 5 autoloads trong Project Settings → Autoload

## 1.3 Design System & Theme
- [ ] Chọn và import pixel font hỗ trợ tiếng Việt có dấu (VD: "Press Start 2P" hoặc custom)
- [ ] Tạo `resources/themes/dark_apocalypse_theme.tres`:
  - [ ] Background: #0a0d12 (deep dark)
  - [ ] Panel: #151922 (card background)
  - [ ] Border: #2a3040 (subtle border)
  - [ ] Primary: #e85d3a (post-apocalyptic orange-red)
  - [ ] Secondary: #4ecdc4 (toxic teal)
  - [ ] Accent: #ffd93d (warning yellow)
  - [ ] Text: #e8e0d4 (warm white)
  - [ ] Text dim: #6b7280 (muted)
  - [ ] Rarity colors: Common #9ca3af, Uncommon #4ade80, Rare #60a5fa, Epic #a78bfa, Legendary #fbbf24, Mythic #f43f5e
- [ ] Tạo StyleBoxFlat presets: card_style, button_style, progress_style, modal_style
- [ ] Tạo font resources: pixel_regular.tres (14px), pixel_small.tres (10px), pixel_title.tres (20px)
- [ ] Test theme trên 1 panel đơn giản — đảm bảo font hiển thị đúng tiếng Việt có dấu

## 1.4 Main Scene & Navigation
- [ ] Tạo `scenes/main/Main.tscn`:
  - [ ] Root: Control (full_rect)
  - [ ] VBoxContainer: TopBar + ContentArea + BottomNavBar
  - [ ] TopBar: HBoxContainer (game_name_label, currency_display: 💎⚙️⚡🪙)
  - [ ] ContentArea: TabContainer hoặc MarginContainer (chứa 4 tab scenes)
  - [ ] BottomNavBar: HBoxContainer (4 tab buttons)
- [ ] Tạo `scenes/shared/BottomNavBar.tscn`:
  - [ ] 4 nút: Tiền đồn | Đội hình | Vùng hoang | Vây hãm
  - [ ] Mỗi nút có icon placeholder + label
  - [ ] Highlight nút active (đổi màu/underline)
- [ ] Tạo `scripts/ui/bottom_nav.gd`:
  - [ ] Signal `tab_changed(tab_index)`
  - [ ] Hàm `set_active_tab(index)` — đổi visual active
- [ ] Tạo `scripts/ui/main_controller.gd` (attached Main.tscn):
  - [ ] Kết nối signal tab_changed → show/hide tab scenes
  - [ ] Preload 4 tab scenes
  - [ ] Hàm `switch_tab(index)` — instance/show correct tab, hide others

## 1.5 Outpost Tab (Tab 1)
- [ ] Tạo `scenes/outpost/OutpostTab.tscn`:
  - [ ] ScrollContainer > GridContainer (2 columns)
  - [ ] 8 room cards (mỗi card = PanelContainer)
- [ ] Tạo `scenes/shared/RoomCard.tscn` (reusable component):
  - [ ] VBoxContainer: room_icon (TextureRect), room_name (Label), status_label (Label "8/12 units")
  - [ ] Hover effect: modulate brightness
  - [ ] Click → emit signal `room_pressed(room_type)`
- [ ] Tạo `scripts/ui/outpost_tab.gd`:
  - [ ] Populate 8 room cards từ RoomType enum
  - [ ] room_pressed → show room detail modal (placeholder)
- [ ] 8 phòng với tên tiếng Việt:
  - [ ] "Boong-ke" (Bunker) — Quản lý đội
  - [ ] "Đài Phát Sóng" (Radio Tower) — Tuyển mộ
  - [ ] "Kho Vũ Khí" (Armory) — Kho đồ
  - [ ] "Chợ Đen" (Trading Post) — Mua bán
  - [ ] "Xưởng Máy" (Workshop) — Chế tạo
  - [ ] "Chuồng Thú" (Beast Pen) — Quái vật
  - [ ] "Nhà Kho Mecha" (Mecha Hangar) — Robot
  - [ ] "Trung Tâm Chỉ Huy" (Command Center) — Thống kê

## 1.6 Squad Tab (Tab 2) — Survivors Sub-tab
- [ ] Tạo `scenes/squad/SquadTab.tscn`:
  - [ ] 3 sub-tab buttons: "Người sống sót" | "Quái vật" | "Mecha"
  - [ ] Content area cho sub-tabs
- [ ] Tạo `scenes/squad/SurvivorList.tscn`:
  - [ ] ScrollContainer > VBoxContainer
  - [ ] Danh sách UnitCard instances
- [ ] Tạo `scenes/shared/UnitCard.tscn` (reusable):
  - [ ] HBoxContainer: avatar_rect (48x48), VBoxContainer(name, level, class_label, stats_bar)
  - [ ] Click → emit signal `unit_selected(unit_id)`
- [ ] Tạo `scripts/data/survivor_database.gd`:
  - [ ] 6 class definitions: Trinh sát (Scout), Y tá (Medic), Kỹ sư (Engineer), Xạ thủ (Sniper), Đấu sĩ (Brawler), Thủ lĩnh (Leader)
  - [ ] Base stats per class: HP, ATK, DEF, SPD, ACC, LUCK
  - [ ] 10+ traits: Cứng cỏi, May mắn, Thợ máy, Thì thầm thú, Sói đơn độc...
  - [ ] Hàm `generate_random_survivor()` → tên ngẫu nhiên + class + traits
- [ ] Tạo `scripts/ui/squad_tab.gd`:
  - [ ] Switch sub-tabs
  - [ ] Populate survivor list từ game_data
- [ ] Tạo 6 survivor units mặc định trong save data khởi tạo

## 1.7 Wastelands Tab (Tab 3)
- [ ] Tạo `scenes/wastelands/WastelandsTab.tscn`:
  - [ ] ScrollContainer > VBoxContainer
  - [ ] Danh sách ZoneCard instances
- [ ] Tạo `scenes/shared/ZoneCard.tscn` (reusable):
  - [ ] PanelContainer: zone_bg (TextureRect background), zone_name, difficulty_stars, team_avatars (HBoxContainer), progress_bar, chest_count_label
  - [ ] Click → show zone detail
- [ ] Tạo `scripts/data/zone_database.gd`:
  - [ ] 7 zones: Ngoại ô hoang tàn, Cống ngầm độc, Nhà máy bỏ hoang, Cảng đóng băng, Hố bom hạt nhân, Tổ zombie, Pháo đài trên mây
  - [ ] Mỗi zone: name, difficulty (1-6 sao), description, enemy_pool[], loot_table[], unlock_requirement
- [ ] Tạo `scripts/ui/wastelands_tab.gd`:
  - [ ] Populate zone list
  - [ ] Show locked zones (chưa unlock)
  - [ ] Display progress cho zones đang thám hiểm

## 1.8 Sieges Tab (Tab 4) — Placeholder
- [ ] Tạo `scenes/sieges/SiegesTab.tscn`:
  - [ ] 4 siege cards (placeholder)
  - [ ] Timer label "THỬ LẠI SAU: 23g 21p"
  - [ ] "SẮP RA MẮT" badge
- [ ] Tạo `scripts/ui/sieges_tab.gd`: Placeholder display

## 1.9 Idle Engine — Core Loop
- [ ] Hoàn thiện `scripts/core/idle_engine.gd`:
  - [ ] Timer tick mỗi 1 giây khi game online
  - [ ] Cho mỗi zone có team đang thám hiểm:
    - [ ] Tăng `progress` += team_power * tick_rate
    - [ ] Khi progress >= sector_threshold → clear sector, generate loot
    - [ ] Khi clear hết sectors → reset + increase chest count
  - [ ] Emit signal `zone_progress_updated(zone_id, progress)`
  - [ ] Emit signal `loot_acquired(item_data)`
- [ ] Tạo `scripts/utils/prng.gd` — Mulberry32 seeded PRNG:
  - [ ] `func seed(s: int)`
  - [ ] `func next_float() -> float` (0.0 - 1.0)
  - [ ] `func next_int(min, max) -> int`

## 1.10 Save System — Foundation
- [ ] Hoàn thiện `scripts/core/save_manager.gd`:
  - [ ] `func default_save() -> Dictionary` — Trả về save mặc định:
    - [ ] gold, alloys, energy, crystals (4 loại tiền tệ)
    - [ ] survivors[] (6 unit mặc định)
    - [ ] monsters[] (rỗng)
    - [ ] mechas[] (rỗng)
    - [ ] inventory[] (vài item cơ bản)
    - [ ] outpost_levels{} (mỗi phòng level 1)
    - [ ] zone_progress{} (zone 1 unlocked)
    - [ ] achievements[]
    - [ ] settings{lang, sfx_vol, music_vol}
    - [ ] lifetime_stats{kills, gold_collected, zones_cleared...}
    - [ ] last_online_timestamp
  - [ ] `func save_game()` — Serialize dict → JSON → FileAccess write
  - [ ] `func load_game()` — FileAccess read → JSON parse → dict
  - [ ] Auto-save mỗi 30 giây (Timer node)
  - [ ] Save on `_notification(NOTIFICATION_WM_CLOSE_REQUEST)`
- [ ] Tạo `scripts/utils/encryption.gd` (placeholder — implement Phase 4):
  - [ ] `func encrypt(text: String) -> String`
  - [ ] `func decrypt(text: String) -> String`

## 1.11 Offline Progress
- [ ] Trong `save_manager.gd` hoặc `idle_engine.gd`:
  - [ ] Khi load game → tính `offline_seconds = now - last_online_timestamp`
  - [ ] Nếu offline_seconds > 60 → chạy idle simulation nhanh
  - [ ] Dùng seeded PRNG với seed = last_online_timestamp
  - [ ] Tạo report dict: {duration, sectors_cleared, exp_gained, enemies_slain, loot[]}
  - [ ] Emit signal `offline_report_ready(report)`
- [ ] Tạo `scenes/wastelands/ExplorationReport.tscn`:
  - [ ] Modal popup hiển thị report
  - [ ] Nút "Thu thập" → add loot vào inventory, close modal

## 1.12 Phase 1 Testing & Polish
- [ ] Test 4 tab switching mượt mà
- [ ] Test outpost hiển thị 8 phòng đúng
- [ ] Test squad hiển thị 6 survivors đúng
- [ ] Test wastelands hiển thị 7 zones (1 unlocked, 6 locked)
- [ ] Test idle tick: progress bar tăng mỗi giây
- [ ] Test save/load: refresh → data persist
- [ ] Test offline progress: tắt game 5 phút → mở lại → report popup
- [ ] Test font tiếng Việt có dấu hiển thị đúng mọi nơi
- [ ] Test responsive: resize window từ 360x640 đến 1920x1080

---

# ═══════════════════════════════════════════════════════════════
# PHASE 2 — CORE COMBAT & SYSTEMS (Tuần 4-7)
# Mục tiêu: Chiến đấu, trang bị, chế tạo, thu phục quái vật
# ═══════════════════════════════════════════════════════════════

## 2.1 Item Database & Inventory
- [ ] Tạo `scripts/data/item_database.gd`:
  - [ ] Custom Resource class `ItemData`: id, name_vi, type, rarity, stats{}, description, icon_path, set_id
  - [ ] 20 weapons (melee + ranged, 6 rarity tiers)
  - [ ] 15 armor pieces (6 rarity tiers)
  - [ ] 10 accessories (rings, amulets)
  - [ ] 15 materials (Phế liệu, Mạch điện, Dung dịch độc, Hợp kim lạnh, Lõi năng lượng...)
  - [ ] Hàm `generate_random_item(rarity, type)` — random stats trong range
- [ ] Tạo `scripts/systems/inventory_system.gd`:
  - [ ] `func add_item(item) -> bool` (kiểm tra capacity)
  - [ ] `func remove_item(item_id)`
  - [ ] `func get_items_by_type(type) -> Array`
  - [ ] `func stack_materials()` — gộp materials cùng loại
  - [ ] Signal `inventory_changed`

## 2.2 Equipment System
- [ ] Tạo `scripts/systems/equipment_system.gd`:
  - [ ] `func equip_item(unit_id, item_id, slot)` — equip + update stats
  - [ ] `func unequip_item(unit_id, slot)` — unequip + revert stats
  - [ ] `func calculate_set_bonus(unit_id)` — kiểm tra set bonus
  - [ ] 5 set bonuses: Bộ Hazmat (Poison immune), Bộ Đông Cứng (Freeze chance), Bộ Phế Liệu (Mecha buff), Bộ Máu (Lifesteal), Bộ Bóng Tối (Crit)
- [ ] Tạo `scenes/squad/SurvivorDetail.tscn`:
  - [ ] Character portrait lớn (128x128)
  - [ ] 3 equipment slots (Weapon, Armor, Accessory) — tap để equip
  - [ ] Stats panel (HP/ATK/DEF/SPD/ACC/LUCK bars)
  - [ ] Traits display
  - [ ] Level + EXP bar
- [ ] Tạo `scenes/shared/ItemSlot.tscn`:
  - [ ] TextureRect (item icon) + rarity border color
  - [ ] Click → show item tooltip hoặc open inventory picker
- [ ] Tạo `scenes/shared/ItemTooltip.tscn`:
  - [ ] Item name (colored by rarity), stats, description
  - [ ] Buttons: "Trang bị" / "Tháo ra" / "Bán"

## 2.3 Combat Engine
- [ ] Tạo `scripts/combat/damage_calculator.gd`:
  - [ ] `func calculate_damage(attacker, defender, skill) -> DamageResult`
  - [ ] Formula: `(ATK * skill_mult * random(0.85-1.15) - DEF * 0.4) * element_bonus`
  - [ ] Element wheel: Lửa > Băng > Độc > Điện > Bóng tối > Lửa (1.5x damage)
  - [ ] Crit chance: base 5% + LUCK * 0.5%, crit damage = 1.5x
  - [ ] Dodge chance: SPD difference based
- [ ] Tạo `scripts/combat/turn_system.gd`:
  - [ ] Action bar fill rate = base_rate * (SPD / 100)
  - [ ] Unit với bar đầy trước → hành động trước
  - [ ] `func get_next_actor(units: Array) -> CombatUnit`
- [ ] Tạo `scripts/combat/combat_ai.gd`:
  - [ ] Enemy AI: target lowest HP, target highest threat, random
  - [ ] Priority: healers > DPS > tanks
- [ ] Tạo `scripts/combat/combat_unit.gd`:
  - [ ] Extend Resource: unit_data_ref, current_hp, max_hp, action_bar, buffs[], debuffs[]
  - [ ] `func take_damage(amount) -> bool` (return true if dead)
  - [ ] `func heal(amount)`
  - [ ] `func apply_buff(buff_data)`
- [ ] Tạo `scripts/combat/combat_manager.gd`:
  - [ ] `func start_combat(team: Array, enemies: Array, zone_id)`
  - [ ] Run combat loop: fill action bars → next actor → choose action → apply damage → check deaths → generate loot if win
  - [ ] Signal `combat_log_entry(text)`, `combat_ended(result)`
  - [ ] Auto-speed option: 1x, 2x, 4x

## 2.4 Combat UI
- [ ] Tạo `scenes/wastelands/CombatScene.tscn`:
  - [ ] Background: zone pixel art
  - [ ] Top row: 4 enemy unit sprites (right side)
  - [ ] Bottom row: 4 player unit sprites (left side)
  - [ ] HP bars trên mỗi unit
  - [ ] Action bar hiển thị
  - [ ] Combat log panel (ScrollContainer, append text mỗi action)
  - [ ] Speed buttons: 1x / 2x / 4x
  - [ ] Nút "Rút lui" (retreat)
- [ ] Tạo `scripts/ui/combat_ui.gd`:
  - [ ] Kết nối signals từ combat_manager
  - [ ] Animate: unit flash khi bị đánh, shake khi crit
  - [ ] Floating damage numbers (Label + Tween)
  - [ ] Victory screen: loot display, EXP gained
  - [ ] Defeat screen: "Thử lại" / "Quay về"

## 2.5 Loot & Capture System
- [ ] Tạo `scripts/combat/loot_generator.gd`:
  - [ ] `func generate_loot(zone_id, enemies_killed, seed) -> Array[ItemData]`
  - [ ] Loot table per zone: material drops, equipment drops, gold
  - [ ] Rarity roll: seeded PRNG
- [ ] Tạo `scripts/combat/capture_system.gd`:
  - [ ] `func attempt_capture(monster_data, capturer_luck) -> CaptureResult`
  - [ ] Base rate per species: Common 60%, Rare 30%, Epic 15%, Legendary 5%, Mythic 1%
  - [ ] Rate tăng khi monster HP thấp: `base * (1 - currentHP/maxHP) * (1 + luck*0.01)`
  - [ ] Signal `capture_success(monster_data)`, `capture_failed`

## 2.6 Monster System — Foundation
- [ ] Tạo `scripts/data/monster_database.gd`:
  - [ ] Custom Resource class `MonsterSpecies`: id, name_vi, element, base_stats, evolution_chain[], skills[], capture_rate, sprite_path
  - [ ] 10 base species:
    - [ ] Lửa: Chó Lửa (Flame Hound), Rắn Dung Nham (Lava Serpent)
    - [ ] Băng: Bọ Băng (Ice Beetle), Sói Tuyết (Frost Wolf)
    - [ ] Độc: Bọ Cạp Độc (Toxic Scorpion), Rêu Di Động (Toxic Crawler)
    - [ ] Điện: Chuột Sét (Volt Rat), Chim Giông (Storm Bird)
    - [ ] Bóng tối: Dơi Bóng (Shadow Bat), Bạch Tuộc Đêm (Night Octopus)
- [ ] Tạo `scripts/systems/monster_system.gd`:
  - [ ] `func add_captured_monster(species_id)` — thêm vào beast pen
  - [ ] `func feed_monster(monster_id, food_item)` — tăng EXP
  - [ ] Monster level up: stats grow per species growth_rate
- [ ] Tạo `scenes/squad/MonsterList.tscn` + `MonsterDetail.tscn`:
  - [ ] Monster portrait + element icon + level + rarity stars
  - [ ] Stats bars, skill list
  - [ ] "Cho ăn" button (feed)

## 2.7 Crafting System — Foundation
- [ ] Tạo `scripts/data/crafting_database.gd`:
  - [ ] 15 recipes: material combinations → equipment/consumables
  - [ ] Mỗi recipe: inputs[], output, success_rate, gold_cost
- [ ] Tạo `scripts/systems/crafting_system.gd`:
  - [ ] `func can_craft(recipe_id) -> bool` — check materials in inventory
  - [ ] `func craft(recipe_id) -> CraftResult` — consume materials, roll success
  - [ ] Signal `craft_success(item)`, `craft_failed`
- [ ] Tạo `scenes/outpost/WorkshopRoom.tscn`:
  - [ ] Recipe list (ScrollContainer)
  - [ ] Recipe detail: inputs display, output preview, success %, gold cost
  - [ ] "Chế tạo" button
  - [ ] Animation: crafting progress bar + success/fail feedback

## 2.8 Level Up & Progression
- [ ] Tạo `scripts/systems/progression_system.gd`:
  - [ ] EXP curve: `required_exp = base_exp * (level ^ 1.5)`
  - [ ] `func add_exp(unit_id, amount)` — check level up
  - [ ] On level up: increase stats by growth_rate, unlock skill slot tại level 5/10/15
  - [ ] Signal `unit_leveled_up(unit_id, new_level)`
  - [ ] Outpost room upgrades: cost scaling, unlock new features per level
- [ ] Implement level up popup:
  - [ ] "TĂNG CẤP!" notification
  - [ ] Stat comparison before/after

## 2.9 Armory Room (Inventory UI)
- [ ] Tạo `scenes/outpost/ArmoryRoom.tscn`:
  - [ ] GridContainer hiển thị tất cả items (icons + rarity borders)
  - [ ] Filter tabs: Tất cả | Vũ khí | Giáp | Phụ kiện | Nguyên liệu
  - [ ] Sort: Theo rarity | Theo level | Theo type
  - [ ] Tap item → ItemTooltip modal
  - [ ] Capacity bar: "58/68 vật phẩm"

## 2.10 Phase 2 Testing
- [ ] Test combat: 4v4 auto-battle hoàn chỉnh
- [ ] Test damage formula: element bonus 1.5x đúng
- [ ] Test loot drops: items vào inventory đúng
- [ ] Test equip/unequip: stats thay đổi đúng
- [ ] Test monster capture: rate tăng khi HP thấp
- [ ] Test crafting: consume materials + output item đúng
- [ ] Test level up: stats grow, skill unlock
- [ ] Test offline progress: combat simulation deterministic
- [ ] Test inventory UI: filter, sort, tooltip hoạt động

---

# ═══════════════════════════════════════════════════════════════
# PHASE 3 — ADVANCED FEATURES (Tuần 8-11)
# Mục tiêu: Mecha, evolution, sieges, prestige, achievements, pixel art
# ═══════════════════════════════════════════════════════════════

## 3.1 Mecha System
- [ ] Tạo `scripts/data/mecha_database.gd`:
  - [ ] 4 part types: Đầu (Head), Thân (Torso), Tay (Arms), Chân (Legs)
  - [ ] 5 variants per type (25 total parts): Scout, Heavy, Assault, Support, Stealth
  - [ ] Mỗi part: stats bonuses, special_ability, rarity, required_materials
  - [ ] Combination bonuses: matching set → special ability unlock
- [ ] Tạo `scripts/systems/mecha_system.gd`:
  - [ ] `func assemble_mecha(head_id, torso_id, arms_id, legs_id) -> MechaUnit`
  - [ ] `func calculate_mecha_power(mecha) -> int`
  - [ ] Fuel system: `func consume_fuel(mecha_id, amount)`, `func refuel(mecha_id, fuel_item)`
  - [ ] Paint/skin customization: color palette per mecha
- [ ] Tạo `scenes/outpost/MechaHangarRoom.tscn`:
  - [ ] Assembly view: 4 part slots (drag-drop or tap-to-select)
  - [ ] Preview mecha sprite (composite từ 4 parts)
  - [ ] Stats summary panel
  - [ ] Fuel gauge
  - [ ] "Lắp ráp" button
- [ ] Tạo `scenes/squad/MechaList.tscn` + `MechaDetail.tscn`:
  - [ ] Mecha card: composite sprite + power level
  - [ ] Detail: 4 part slots, weapon mount, fuel gauge, abilities

## 3.2 Monster Evolution & Breeding
- [ ] Mở rộng `monster_database.gd`:
  - [ ] Evolution chains: Baby → Juvenile → Adult → Elder → Apex
  - [ ] Evolution requirements: level + specific material
  - [ ] Mỗi stage: new sprite, stat jump, new skill
- [ ] Tạo breeding system trong `monster_system.gd`:
  - [ ] `func breed(monster_a_id, monster_b_id) -> BreedResult`
  - [ ] Element inheritance: child gets 1 of 2 parent elements
  - [ ] Stat inheritance: average of parents + random mutation
  - [ ] Breeding cooldown: 4 giờ thực
  - [ ] Rare hybrid species possible (VD: Lửa + Băng = Hơi Nước)
- [ ] Tạo `scenes/outpost/BeastPenRoom.tscn`:
  - [ ] Monster grid display
  - [ ] "Tiến hóa" button (khi đủ điều kiện)
  - [ ] "Lai tạo" panel: chọn 2 monsters → preview offspring
  - [ ] Evolution animation: flash + sprite morph
- [ ] Tạo evolution popup:
  - [ ] Before/after comparison
  - [ ] New skill reveal
  - [ ] Particle effects celebration

## 3.3 Siege System (Daily Boss Raids)
- [ ] Tạo `scripts/data/siege_database.gd`:
  - [ ] 4 sieges: Bầy Zombie (100 waves), Titan Mecha (DPS check), Mẹ Trứng Khổng Lồ (phá trứng trước), Quái Vật Hạt Nhân (multi-phase)
  - [ ] Mỗi siege: boss_stats, mechanics_description, reward_pool, daily_attempts(3)
- [ ] Mở rộng `combat_manager.gd`:
  - [ ] Siege mode: special boss AI patterns
  - [ ] Phase transitions: boss rage mode at 50% HP, 25% HP
  - [ ] Enrage timer: DPS check — nếu chậm quá → boss tăng DMG
- [ ] Tạo `scenes/sieges/SiegeBattle.tscn`:
  - [ ] Boss sprite lớn (128x128)
  - [ ] Phase indicator
  - [ ] Boss HP bar riêng (thanh lớn trên cùng)
  - [ ] Special mechanic UI (VD: trứng counter, enrage timer)
- [ ] Hoàn thiện `scenes/sieges/SiegesTab.tscn`:
  - [ ] 4 siege cards với boss preview
  - [ ] Attempts remaining: "Còn 3/3 lượt"
  - [ ] Timer đếm ngược đến reset daily
  - [ ] Reward preview

## 3.4 Outpost Upgrade System
- [ ] Tạo `scripts/systems/upgrade_system.gd`:
  - [ ] Mỗi phòng: level 1-10
  - [ ] Upgrade costs: gold + materials, scaling per level
  - [ ] Upgrade benefits per room:
    - [ ] Bunker: +2 unit capacity per level
    - [ ] Radio Tower: +1 recruit slot, better rarity chance
    - [ ] Armory: +10 inventory slots per level
    - [ ] Trading Post: better sell prices
    - [ ] Workshop: unlock new recipes, higher success rates
    - [ ] Beast Pen: +2 monster slots, unlock breeding at level 5
    - [ ] Mecha Hangar: +1 mecha slot, unlock paint at level 3
    - [ ] Command Center: unlock prestige at level 10
- [ ] UI cho mỗi room: "Nâng cấp" button + cost display + next level benefits

## 3.5 Prestige System
- [ ] Tạo prestige logic trong `progression_system.gd`:
  - [ ] "Ngày Tận Thế" (Apocalypse Reset):
    - [ ] Reset: unit levels, inventory, zone progress
    - [ ] Keep: achievements, prestige currency, unlocked species
    - [ ] Gain: "Mảnh Tận Thế" (Apocalypse Shards) based on progress
    - [ ] Permanent bonuses: +X% ATK, +X% DEF, +X% loot rate per prestige level
  - [ ] Prestige shop: spend shards on permanent upgrades
- [ ] Tạo prestige UI:
  - [ ] Confirmation modal with detailed reset explanation
  - [ ] Shard gain preview
  - [ ] Permanent bonus display

## 3.6 Achievement System
- [ ] Tạo `scripts/data/achievement_database.gd`:
  - [ ] 50+ achievements:
    - [ ] Tiến độ: "Hoàn thành Zone 1", "Đạt level 10", "Thu phục 5 quái vật"
    - [ ] Chiến đấu: "Giết 1000 zombie", "Không bị trúng đòn trong 1 trận"
    - [ ] Sưu tầm: "Sở hữu item Legendary", "Hoàn thành bộ set"
    - [ ] Mecha: "Lắp ráp mecha đầu tiên", "Mecha đạt power 1000"
    - [ ] Quái vật: "Tiến hóa quái vật lên Apex", "Lai tạo hybrid thành công"
  - [ ] Mỗi achievement: id, name_vi, description, icon, reward(gold/crystals), steam_achievement_id
- [ ] Tạo `scripts/systems/achievement_system.gd`:
  - [ ] Track progress trong lifetime_stats
  - [ ] `func check_achievements()` — gọi sau mỗi action quan trọng
  - [ ] Signal `achievement_unlocked(ach_id)`
  - [ ] Toast notification khi unlock
- [ ] Tạo `scenes/outpost/CommandCenterRoom.tscn`:
  - [ ] Achievement grid (locked/unlocked display)
  - [ ] Lifetime stats panel
  - [ ] Settings panel (language, volume, save export/import)

## 3.7 Pixel Art Assets — SNES 16-bit Style
- [ ] Vẽ/tạo sprite sheets cho 6 survivor classes (32x32):
  - [ ] Mỗi class: idle (4 frames), walk (6 frames), attack (4 frames), hit (2 frames)
  - [ ] Import vào Godot: SpriteFrames resource cho AnimatedSprite2D
- [ ] Vẽ/tạo sprite sheets cho 10 monster species (32x32 → 64x64):
  - [ ] Mỗi species: idle (4 frames), attack (3 frames), hit (2 frames), death (4 frames)
  - [ ] 3 evolution stages (Baby/Adult/Apex) cho mỗi species
- [ ] Vẽ/tạo mecha part sprites (64x64):
  - [ ] 5 head variants, 5 torso, 5 arms, 5 legs
  - [ ] Composite rendering: draw layers
- [ ] Vẽ/tạo item icons (16x16):
  - [ ] 20 weapons, 15 armor, 10 accessories, 15 materials
  - [ ] Rarity border effects (glow/sparkle per rarity)
- [ ] Vẽ/tạo zone backgrounds (320x180, upscale lên game resolution):
  - [ ] 7 zone backgrounds với parallax layers (far/mid/near)
- [ ] Vẽ/tạo UI pixel art elements:
  - [ ] Tab icons (4 icons cho bottom nav)
  - [ ] Currency icons (4 loại)
  - [ ] Room icons (8 phòng)
  - [ ] Button styles (pixel art borders)
  - [ ] Modal frames
  - [ ] HP bar, EXP bar, action bar designs

## 3.8 Radio Tower (Recruitment)
- [ ] Tạo `scenes/outpost/RadioTowerRoom.tscn`:
  - [ ] 3 "tín hiệu" slots (recruit candidates)
  - [ ] Mỗi slot: unit preview card + "Tuyển mộ" button + cost
  - [ ] Refresh timer: "Tín hiệu mới sau: 4g 00p"
  - [ ] Manual refresh: cost crystals
  - [ ] Recruit rarity influenced by Radio Tower level

## 3.9 Trading Post
- [ ] Tạo `scenes/outpost/TradingPostRoom.tscn`:
  - [ ] Sell panel: chọn items từ inventory → sell price preview → "Bán" button
  - [ ] Bulk sell: "Bán tất cả Common" button
  - [ ] Daily deals: 3 random items available for purchase (refresh daily)

## 3.10 Phase 3 Testing
- [ ] Test mecha assembly: 4 parts → mecha unit hoạt động trong combat
- [ ] Test mecha fuel: tiêu thụ fuel khi combat, refuel đúng
- [ ] Test monster evolution: đủ điều kiện → evolve → new stats/sprite
- [ ] Test breeding: 2 monsters → offspring với element inheritance
- [ ] Test siege bosses: phase transitions, enrage mechanic
- [ ] Test outpost upgrades: capacity tăng, features unlock
- [ ] Test prestige: reset đúng items, keep achievements, shards correct
- [ ] Test achievements: trigger đúng điều kiện
- [ ] Test pixel art: tất cả sprites hiển thị đúng SNES style
- [ ] Test recruitment: 3 candidates, refresh timer
- [ ] Test trading: sell items, daily deals

---

# ═══════════════════════════════════════════════════════════════
# PHASE 4 — POLISH & DISTRIBUTION (Tuần 12-14)
# Mục tiêu: Steam, Android, iOS, audio, i18n, anti-cheat, QA
# ═══════════════════════════════════════════════════════════════

## 4.1 Save Encryption & Anti-Cheat
- [ ] Hoàn thiện `scripts/utils/encryption.gd`:
  - [ ] FNV-1a hash function: checksum integrity
  - [ ] XOR cipher: key = game-specific secret
  - [ ] `func encrypt(json_str) -> String` — hash + XOR + hex encode
  - [ ] `func decrypt(hex_str) -> String` — hex decode + XOR + verify hash
  - [ ] Nếu hash fail → reset save (anti-tamper)
- [ ] Tích hợp encryption vào save_manager: encrypt trước khi write, decrypt sau khi read
- [ ] Test: modify save file manually → game detects tamper → reset

## 4.2 Steam Integration (GodotSteam)
- [ ] Download và cài đặt GodotSteam plugin (https://godotsteam.com)
- [ ] Tạo Steam App ID (Steamworks partner account)
- [ ] Cấu hình `steam_appid.txt` trong project root
- [ ] Tích hợp GodotSteam Singleton:
  - [ ] `Steam.steamInit()` khi game start
  - [ ] DRM check: `Steam.restartAppIfNecessary(APP_ID)`
  - [ ] `Steam.setAchievement(ach_name)` khi achievement unlock
  - [ ] Cloud Save: `Steam.fileWrite()` / `Steam.fileRead()`
- [ ] Tạo Steam store page assets:
  - [ ] Header Capsule (460x215)
  - [ ] Small Capsule (231x87)
  - [ ] Library Hero (600x900)
  - [ ] Library Logo (600x900)
  - [ ] Community Icon (32x32)
  - [ ] 5+ Screenshots (1920x1080)
  - [ ] Trailer video (optional)
- [ ] Cấu hình export preset Windows:
  - [ ] Executable name: "DeadFrontier.exe"
  - [ ] Icon: game icon
  - [ ] Company: studio name
  - [ ] Export → test .exe chạy + Steam overlay works

## 4.3 Android Build
- [ ] Cài Android SDK, JDK (nếu chưa có)
- [ ] Cấu hình Godot Editor → Editor Settings → Export → Android:
  - [ ] Android SDK path
  - [ ] Debug keystore
  - [ ] Release keystore (tạo mới cho production)
- [ ] Cấu hình export preset Android:
  - [ ] Package name: `com.studio.deadfrontier`
  - [ ] Min SDK: API 24 (Android 7.0)
  - [ ] Target SDK: API 34
  - [ ] Screen orientation: Portrait
  - [ ] Permissions: INTERNET (cho cloud save)
- [ ] Touch input adaptations:
  - [ ] Tất cả buttons có kích thước tối thiểu 44x44dp
  - [ ] Swipe gestures cho tab switching
  - [ ] Long press cho item tooltip
  - [ ] Pinch zoom cho combat scene (optional)
- [ ] Export → test APK trên thiết bị Android thật
- [ ] Test performance: FPS counter, memory usage

## 4.4 iOS Build
- [ ] Cấu hình export preset iOS:
  - [ ] Bundle identifier: `com.studio.deadfrontier`
  - [ ] Team ID (Apple Developer account)
  - [ ] Signing: Development → Distribution
- [ ] App Store assets:
  - [ ] App icon (1024x1024)
  - [ ] Launch screen
  - [ ] Screenshots cho iPhone + iPad
- [ ] Export → test trên iOS Simulator / TestFlight
- [ ] Xử lý App Store review guidelines:
  - [ ] No web wrapper → native Godot → ✅
  - [ ] Privacy policy link
  - [ ] Age rating

## 4.5 Audio System
- [ ] Tạo `scripts/systems/audio_manager.gd` (Autoload):
  - [ ] Background music tracks (2-3 tracks): menu, exploration, combat
  - [ ] Approach: procedural audio (Web Audio style) HOẶC import .ogg files
  - [ ] SFX: tap, equip, craft_success, craft_fail, level_up, achievement, combat_hit, combat_crit, capture_success, capture_fail
  - [ ] Volume controls: Master, Music, SFX (save in settings)
  - [ ] Fade in/out transitions giữa tracks
- [ ] Tạo/import audio assets:
  - [ ] Menu BGM: dark ambient, low tempo
  - [ ] Combat BGM: intense, higher tempo
  - [ ] Exploration BGM: atmospheric, mysterious
  - [ ] 15+ SFX files

## 4.6 Internationalization (i18n)
- [ ] Tạo `locale/vi.csv`:
  - [ ] Tất cả strings in-game bằng tiếng Việt (300+ entries)
  - [ ] Format: `KEY,vi` (CSV hoặc .po Godot format)
- [ ] Tạo `locale/en.csv`:
  - [ ] English translations cho tất cả strings
- [ ] Tạo `scripts/utils/i18n_manager.gd`:
  - [ ] `func set_language(lang_code)` — VI hoặc EN
  - [ ] `func tr(key) -> String` — translate key
  - [ ] Tích hợp Godot built-in TranslationServer
- [ ] Tích hợp: thay tất cả hardcoded strings bằng `tr("KEY")`
- [ ] Test: switch VI ↔ EN, kiểm tra tất cả UI cập nhật

## 4.7 UI Polish & Animations
- [ ] Tab switching animation: slide left/right
- [ ] Modal open/close: fade + scale (Tween)
- [ ] Button hover/press: scale bounce (1.0 → 0.95 → 1.0)
- [ ] Level up celebration: particle effects + screen flash
- [ ] Achievement unlock: slide-in toast from top
- [ ] Combat: hit shake, crit flash, death fade
- [ ] Loot acquire: item icon fly from source to inventory icon
- [ ] Currency change: number count-up animation
- [ ] Progress bar: smooth fill with glow
- [ ] Loading screen: animated pixel art loading indicator

## 4.8 Balancing Pass
- [ ] Damage numbers: kiểm tra combat không quá nhanh/chậm
- [ ] Progression curve: level 1→50 mất bao lâu (target: 2 tuần casual play)
- [ ] Loot rates: player nhận đủ equipment để progress
- [ ] Craft success rates: không quá frustrating
- [ ] Monster capture rates: đủ thách thức nhưng không quá khó
- [ ] Siege boss difficulty: hard nhưng beatable với proper gear
- [ ] Idle income: đủ để progress khi AFK nhưng active play vẫn tốt hơn
- [ ] Prestige value: reset nên mang lại cảm giác "worth it"
- [ ] Currency economy: không inflation, không deflation

## 4.9 QA & Bug Fixing
- [ ] Tạo QA test script (automated):
  - [ ] Save/Load round-trip test
  - [ ] Combat simulation: 100 battles, verify no crashes
  - [ ] Offline progress: verify deterministic (same seed → same result)
  - [ ] All achievements: trigger conditions met → unlock
- [ ] Manual testing checklist:
  - [ ] Chạy từ đầu đến cuối game (fresh save)
  - [ ] Prestige 1 lần → verify reset correct
  - [ ] Test edge cases: full inventory, 0 gold, max level
  - [ ] Test trên 3 devices: PC (1920x1080), Android phone, Android tablet
  - [ ] Test memory leak: chạy game 1 giờ liên tục
  - [ ] Test offline: tắt game 8 giờ → mở lại

## 4.10 Final Build & Release Prep
- [ ] Windows build: Export → test .exe → verify Steam overlay
- [ ] Android build: Export signed APK → test trên 3+ devices
- [ ] iOS build: Export → TestFlight → test
- [ ] Tạo Steam store page:
  - [ ] Game description (Tiếng Việt + English)
  - [ ] System requirements
  - [ ] Tags: Idle, RPG, Pixel Graphics, Singleplayer
  - [ ] Capsule images + screenshots
  - [ ] Release date
- [ ] Tạo Google Play store listing:
  - [ ] Title, description, screenshots
  - [ ] Content rating questionnaire
  - [ ] Privacy policy
- [ ] Tạo App Store listing:
  - [ ] Title, subtitle, keywords, description
  - [ ] Screenshots, preview video
  - [ ] App Review information
- [ ] Version numbering: v1.0.0

---

# Tổng Kết Ước Tính

| Phase | Tasks | Thời gian ước tính |
|---|---|---|
| Phase 1: Foundation | 56 tasks | 2-3 tuần |
| Phase 2: Combat & Systems | 47 tasks | 3-4 tuần |
| Phase 3: Advanced | 52 tasks | 3-4 tuần |
| Phase 4: Polish & Ship | 48 tasks | 2-3 tuần |
| **Tổng** | **203 tasks** | **10-14 tuần** |
