# 📋 MASTER TASK ROADMAP — DEAD FRONTIER: MECHA & MONSTERS
# Target Engine: Godot 4.4+ GDScript | Art: 16-bit SNES Pixel Art | Target: Steam (PC) + Android + iOS ($4.99-$9.99 Premium Model)

---

# ═══════════════════════════════════════════════════════════════
# PHASE 1: CORE FOUNDATION & ENGINE ARCHITECTURE (HOÀN THÀNH 100%)
# ═══════════════════════════════════════════════════════════════

## 1.1 Project Setup & Nền Tảng Godot 4
- [x] Tạo Godot 4.4+ project tại `d:\New game\DeadFrontier\`
- [x] Cấu hình `project.godot`: Resolution 360x640 (Portrait Mobile), Window Override 405x720 (PC)
- [x] Cấu hình Stretch Mode = `canvas_items`, Aspect = `expand` (Responsive UI đa màn hình)
- [x] Cấu hình Rendering: `gl_compatibility` (OpenGL ES 3.0 / WebGL 2.0 tối ưu PC & di động)
- [x] Tạo cấu trúc 39 thư mục modular: scenes/, scripts/, resources/, assets/, locale/, docs/
- [x] Cấu hình `.gitignore` chuẩn Godot Engine & Init Git Repository

## 1.2 Autoload Singletons
- [x] `scripts/core/constants.gd` — 15 Enums & Từ điển dữ liệu toàn cục (Việt hóa)
- [x] `scripts/core/event_bus.gd` — 30+ Signals cho kiến trúc Event-Driven hoàn toàn độc lập
- [x] `scripts/core/game_manager.gd` — Quản lý State chính, Tab routing & 4 loại Tiền tệ
- [x] `scripts/core/save_manager.gd` — Nạp/lưu dữ liệu mã hóa FNV-1a Checksum + XOR Cipher
- [x] `scripts/core/idle_engine.gd` — Động cơ đếm nhịp Idle online & giả lập thám hiểm Offline
- [x] `scripts/utils/prng.gd` — Thuật toán Mulberry32 Seeded PRNG chống gian lận

## 1.3 Giao Diện Chính & Điều Hướng
- [x] `scenes/main/Main.tscn` & `main_controller.gd` — Root scene với TopBar tiền tệ real-time
- [x] `scenes/shared/BottomNavBar.tscn` & `bottom_nav.gd` — Thanh điều hướng 4 nút với highlight active tab
- [x] `locale/vi.csv` & `locale/en.csv` — Khởi tạo từ điển đa ngôn ngữ qua `TranslationServer`

---

# ═══════════════════════════════════════════════════════════════
# PHASE 2: INTERACTIVE OUTPOST & COMBAT ARENA (HOÀN THÀNH 100%)
# ═══════════════════════════════════════════════════════════════

## 2.1 Sàn Đấu Chiến Đấu 2D Trực Quan (Visual Combat Arena)
- [x] `scripts/combat/visual_combat.gd` — Điều khiển sàn đấu 2D trực quan, slot 4v4, nảy số sát thương Floating Damage
- [x] `scenes/wastelands/CombatScene.tscn` — Giao diện chiến đấu 2D với các nút tốc độ 1X, 2X, 4X và Bỏ qua trận
- [x] `scripts/ui/combat_ui.gd` — Xử lý kết quả trận đấu, trao thưởng Vàng/EXP và kiểm tra thành tựu

## 2.2 Hoàn Thiện Modals 8/8 Phòng Tiền Đồn (Outpost Rooms)
- [x] `scenes/outpost/BunkerRoom.tscn` & `bunker_room.gd` — Quản lý & nâng cấp sức chứa người sống sót
- [x] `scenes/outpost/RadioTowerRoom.tscn` & `radio_tower_room.gd` — Quét tín hiệu tuyển mộ đồng đội mới
- [x] `scenes/outpost/ArmoryRoom.tscn` & `armory_room.gd` — Xem lưới trang bị kho đồ, bộ lọc & mở rộng dung tích kho
- [x] `scenes/outpost/TradingPostRoom.tscn` & `trading_post_room.gd` — Cửa hàng Chợ Đen mua bán nguyên liệu/vũ khí
- [x] `scenes/outpost/WorkshopRoom.tscn` & `workshop_room.gd` — Chế tạo trang bị từ công thức
- [x] `scenes/outpost/BeastPenRoom.tscn` & `beast_pen_room.gd` — Quản lý, cho ăn, tiến hóa quái vật & bắt quái thử nghiệm
- [x] `scenes/outpost/MechaHangarRoom.tscn` & `mecha_hangar_room.gd` — Lắp ráp Robot 4 bộ phận & Nạp Nhiên liệu
- [x] `scenes/outpost/CommandCenterRoom.tscn` & `command_center_room.gd` — Bảng thành tựu, thống kê & Prestige Reset
- [x] `scripts/ui/outpost_tab.gd` — Đăng ký đầy đủ 8/8 room modal scenes tự động hiển thị khi click card

## 2.3 Cơ Chế Sâu & Bảo Mật Nâng Cao
- [x] `scripts/systems/equipment_system.gd` — Kích hoạt **Set Bonuses 2 món / 4 món** (Set Trinh Sát, Set Độc Hóa, Set Plasma)
- [x] `scripts/systems/monster_system.gd` — Tiến hóa quái vật 5 giai đoạn (*Baby → Juvenile → Adult → Elder → Apex*) & Lai tạo
- [x] `scripts/systems/mecha_system.gd` — Tiêu thụ 5 điểm nhiên liệu/hành động & chức năng Nạp Nhiên liệu
- [x] `scripts/core/save_manager.gd` — Bật mã hóa sản xuất `DISABLE_ENCRYPTION = false` chống hack save
- [x] `scripts/core/audio_manager.gd` — Autoload điều khiển BGM & SFX với pitch variance ngẫu nhiên
- [x] `scripts/ui/toast_manager.gd` — Thông báo nổi góc màn hình khi thu nhận item, mở khóa thành tựu hoặc lên cấp
- [x] `scripts/tests/run_tests.gd` — Bộ kiểm tra tự động vượt qua 100% cả 7 hệ thống chính

---

# ═══════════════════════════════════════════════════════════════
# PHASE 3: MASSIVE CONTENT EXPANSION & LOOT TABLES (HOÀN THÀNH 100%)
# ═══════════════════════════════════════════════════════════════

## 3.1 Mở Rộng Danh Mục Trang Bị & Nguyên Liệu (50+ Items)
- [x] Mở rộng `scripts/data/item_database.gd`:
  - [x] 15+ Vũ khí (Dao rỉ, Dao rựa, Súng săn, Kiếm Plasma, Súng Gauss, Pháo Điện từ...)
  - [x] 10+ Áo giáp (Áo da, Áo giáp chống đạn, Bộ Hazmat, Giáp Titan...)
  - [x] 10+ Phụ kiện (Radar Trinh Sát, Mặt Dây Chuyện Dị Năng, Lõi Tăng Tốc...)
  - [x] 15+ Nguyên liệu chế tạo (Phế liệu sắt, Mạch điện hỏng, Dung dịch độc, Hợp kim lạnh, Lõi năng lượng...)
  - [x] Định nghĩa 6 cấp độ hiếm (Common, Uncommon, Rare, Epic, Legendary, Mythic) với hệ số chỉ số tương ứng

## 3.2 Mở Rộng Danh Mục Quái Vật & Tiến Hóa (15+ Species)
- [x] Mở rộng `scripts/data/monster_database.gd`:
  - [x] 15+ Loài quái vật trải dài 5 Nguyên tố (Lửa, Băng, Độc, Điện, Bóng Tối)
  - [x] Định nghĩa đầy đủ chỉ số cơ bản, tỷ lệ thu phục & thông số 5 giai đoạn tiến hóa cho từng loài

## 3.3 Mở Rộng Danh Mục Linh Kiện Mecha (16 Parts)
- [x] Mở rộng `scripts/data/mecha_database.gd`:
  - [x] 4 Linh kiện Đầu (Head Parts)
  - [x] 4 Linh kiện Thân (Torso Parts)
  - [x] 4 Linh kiện Tay (Arms Parts)
  - [x] 4 Linh kiện Chân (Legs Parts)
  - [x] Công thức tính chỉ số Sức mạnh (Power Level) cộng dồn từ 4 linh kiện

## 3.4 Mở Rộng Công Thức Chế Tạo & Trận Vây Hãm
- [x] Mở rộng `scripts/data/crafting_database.gd` (20+ Công thức chế tạo trang bị & linh kiện)
- [x] Mở rộng `scripts/data/siege_database.gd` (4 Trận vây hãm Boss daily: Bầy Zombie, Titan Mecha, Mẹ Trứng, Quái Phóng Xạ)
- [x] Mở rộng `scripts/data/achievement_database.gd` (35+ Thành tựu in-game với phần thưởng Vàng & Pha lê)

---

# ═══════════════════════════════════════════════════════════════
# PHASE 4: STEAMWORKS, MOBILE BUILD & POLISH (READY FOR DEPLOY)
# ═══════════════════════════════════════════════════════════════

## 4.1 Tích Hợp Steamworks & DRM Launch
- [x] Tích hợp GodotSteam plugin: DRM Launch Enforcement (`Steam.restartAppIfNecessary`)
- [x] Đồng bộ Steam Achievements & Steam Cloud Save cho phiên bản PC Steam

## 4.2 Xuất Bản Nền Tảng Di Động (Android & iOS)
- [x] Cấu hình Export Presets Android (Target SDK API 34, OpenGL ES 3.0)
- [x] Cấu hình Export Presets iOS & Tối ưu Touch Targets tối thiểu 44x44dp
- [x] Kiểm tra tương thích giao diện Portrait Mobile & Landscape PC

## 4.3 Kiểm Trụ & Nghiệm Thu
- [x] Chạy bộ test tự động `run_tests.gd` vượt qua 100% test cases
- [x] Đồng bộ 100% mã nguồn, tài liệu 19 mô-đun và scenes lên GitHub repository
