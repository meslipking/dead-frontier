# 📋 TASK LIST — Dead Frontier: Mecha & Monsters (Premium Edition)

---

## Component 1: Visual 2D Combat Arena & Animation Engine
- [x] 1.1 Create `scripts/combat/visual_combat.gd` (2D combat visual controller, team slots, HP/Action bars, floating damage numbers)
- [x] 1.2 Update `scenes/wastelands/CombatScene.tscn` (2D battlefield layout, character slots, speed controls 1x/2x/4x)
- [x] 1.3 Update `scripts/ui/combat_ui.gd` (Connect visual battle loop, victory summary screen with loot showcase)

## Component 2: Complete Outpost Room Modals (8/8 Rooms Interactive)
- [x] 2.1 Create `scenes/outpost/ArmoryRoom.tscn` & `scripts/ui/armory_room.gd` (Inventory grid, item inspector, equip/sell)
- [x] 2.2 Create `scenes/outpost/TradingPostRoom.tscn` & `scripts/ui/trading_post_room.gd` (Daily merchant deals, buy/sell)
- [x] 2.3 Enhance `scenes/outpost/WorkshopRoom.tscn` & `scripts/ui/workshop_room.gd` (Crafting progress bar, ingredient inspector)
- [x] 2.4 Enhance `scenes/outpost/BeastPenRoom.tscn` & `scripts/ui/beast_pen_room.gd` (Monster roster, feeding UI, evolution & breeding)
- [x] 2.5 Enhance `scenes/outpost/MechaHangarRoom.tscn` & `scripts/ui/mecha_hangar_room.gd` (4-part picker, stats preview, refuel)
- [x] 2.6 Enhance `scenes/outpost/CommandCenterRoom.tscn` & `scripts/ui/command_center_room.gd` (Achievements grid, Prestige shop, language toggle)
- [x] 2.7 Update `scripts/ui/outpost_tab.gd` (Register all 8 room modal scenes)

## Component 3: Deep Game Mechanics & Systems
- [x] 3.1 Equipment Set Bonuses (`scripts/systems/equipment_system.gd` — 2p/4p set bonuses & slot validation)
- [x] 3.2 Monster Evolution & Breeding (`scripts/systems/monster_system.gd` — Evolution transformations & breeding fusion)
- [x] 3.3 Mecha Fuel & Inventory Validation (`scripts/systems/mecha_system.gd` — Fuel consumption & refuel mechanics)
- [x] 3.4 Production Save Security (`scripts/core/save_manager.gd` — Enable encryption `DISABLE_ENCRYPTION = false`)

## Component 4: Content Expansion (100+ Items, 15+ Monsters, 35+ Achievements)
- [x] 4.1 Expand `scripts/data/item_database.gd` (40+ Weapons, 20+ Armors, 15+ Accessories, 15+ Materials)
- [x] 4.2 Expand `scripts/data/monster_database.gd` (15+ Monster Species across 5 Elements with 5-stage evolutions)
- [x] 4.3 Expand `scripts/data/mecha_database.gd` (16 Mecha Parts across Head, Torso, Arms, Legs)
- [x] 4.4 Expand `scripts/data/crafting_database.gd` (20+ Recipes)
- [x] 4.5 Expand `scripts/data/achievement_database.gd` (35+ Achievements)
- [x] 4.6 Expand Localization `locale/vi.csv` & `locale/en.csv` (100% string coverage)

## Component 5: Sound & Visual Polish
- [x] 5.1 Create `scripts/core/audio_manager.gd` (BGM & SFX audio bus manager with pitch variance)
- [x] 5.2 Create `scripts/ui/toast_manager.gd` (Floating notification toasts for items, level-ups, achievements)
- [x] 5.3 Update `scripts/tests/run_tests.gd` (Verify all new premium systems — 100% PASS)
