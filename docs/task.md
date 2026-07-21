# 📋 SIÊU TASK ROADMAP — DEAD FRONTIER: MECHA & MONSTERS (PREMIUM EDITION)
# Target Engine: Godot 4.4+ GDScript | Art: 16-bit Cyber-Apocalypse Pixel Art | Platforms: Steam (PC) + Android + iOS ($4.99-$9.99 Premium Model)

---

# ═══════════════════════════════════════════════════════════════
# PHASE 1: NỀN TẢNG CORE ENGINE & MÃ HÓA BẢO MẬT (HOÀN THÀNH 100%)
# ═══════════════════════════════════════════════════════════════

## 1.1 Khung Dự Án & Tương Thích Đa Nền Tảng (Responsive Resolution)
- [x] Cấu hình `project.godot`: Resolution 360x640 (Portrait Mobile), Window Override 405x720 (PC Windowed)
- [x] Stretch Mode = `canvas_items`, Aspect = `expand` (Tự động scale giao diện trên di động & PC)
- [x] Rendering Method: `gl_compatibility` (OpenGL ES 3.0 / WebGL 2.0 tối ưu hiệu năng)
- [x] Texture Filter: `Nearest` (0) — Đảm bảo pixel art 16-bit sắc nét không vỡ/nhòe
- [x] Quản lý cấu trúc 39 thư mục modular: scenes/, scripts/, resources/, assets/, locale/, docs/

## 1.2 Autoload Singletons Cốt Lõi
- [x] `scripts/core/constants.gd` — 15 Enums & Từ điển dữ liệu toàn cục (Việt hóa)
- [x] `scripts/core/event_bus.gd` — 30+ Signals cho kiến trúc Event-Driven hoàn toàn độc lập
- [x] `scripts/core/game_manager.gd` — Quản lý State chính, Tab routing & 4 loại Tiền tệ (Gold, Alloys, Energy, Crystals)
- [x] `scripts/core/save_manager.gd` — Bảo mật save chống hack với mã hóa UTF-8 PackedByteArray Checksum FNV-1a + XOR Cipher
- [x] `scripts/core/idle_engine.gd` — Động cơ đếm nhịp Idle online & giả lập thám hiểm Offline vắng mặt vĩnh cửu (Tối ưu Cache $O(1)$)
- [x] `scripts/core/audio_manager.gd` — Autoload quản lý BGM & SFX với pitch variance ngẫu nhiên
- [x] `scripts/utils/prng.gd` — Thuật toán Mulberry32 Seeded PRNG chống save-scam

---

# ═══════════════════════════════════════════════════════════════
# PHASE 2: INTERACTIVE OUTPOST & COMBAT ARENA (HOÀN THÀNH 100%)
# ═══════════════════════════════════════════════════════════════

## 2.1 Sàn Đấu Chiến Đấu 2D Trực Quan (Visual Combat Arena)
- [x] `scripts/combat/visual_combat.gd` — Điều khiển sàn đấu 2D trực quan, slot 4v4, nảy số sát thương Floating Damage Text (Đỏ Crit, Vàng Nguyên tố, Xanh Né)
- [x] `scenes/wastelands/CombatScene.tscn` — Giao diện chiến đấu 2D với các nút tốc độ 1X, 2X, 4X và Bỏ qua trận (Skip Battle)
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

## 2.3 Đồ Họa 16-Bit SNES & UX/UI Micro-Animations
- [x] `resources/themes/dark_apocalypse_theme.tres` — Bộ Theme Cyber-Apocalypse Pixel (Dark Slate background `#12161F`, Gold Glow `#FFBF33`, Crimson Border `#E84545`)
- [x] `scripts/utils/pixel_art_generator.gd` — Động cơ sinh Texture Pixel 16-bit SNES (Silhouette giáp, glowing visor, vuốt quái vật, pháo mecha, icon vũ khí 32x32)
- [x] `scripts/utils/sprite_animation_engine.gd` — Động cơ hiệu ứng UX micro-animations (Idle breathing, hit flashes, attack dashes & scale pop tweens)
- [x] `scripts/utils/sprite_frames_builder.gd` — Cắt ghép Sprite Sheet vẽ tay thành SpriteFrames 4 khung hình (`idle`, `attack`, `hit`)
- [x] `scripts/effects/vfx_engine.gd` — Hạt CPU Particles tia lửa chém, hào quang nguyên tố & rung lắc camera (Screen Shake)

---

# ═══════════════════════════════════════════════════════════════
# PHASE 3: MASSIVE CONTENT EXPANSION & GACHA SYSTEM (HOÀN THÀNH 100%)
# ═══════════════════════════════════════════════════════════════

## 3.1 Mở Rộng Danh Mục Trang Bị & Set Bonuses (50+ Items)
- [x] `scripts/data/item_database.gd`:
  - [x] 15+ Vũ khí (Dao rỉ, Dao rựa, Kiếm Plasma, Súng Gauss, Pháo Điện từ...)
  - [x] 10+ Áo giáp (Áo da, Áo giáp chống đạn, Bộ Hazmat, Giáp Titan...)
  - [x] 10+ Phụ kiện (Radar Trinh Sát, Mặt Dây Chuyện Dị Năng, Lõi Tăng Tốc...)
  - [x] 15+ Nguyên liệu chế tạo (Phế liệu sắt, Mạch điện hỏng, Dung dịch độc, Hợp kim lạnh, Lõi năng lượng...)
- [x] `scripts/systems/equipment_system.gd`: Kích hoạt **Set Bonuses 2p/4p** (*Set Trinh Sát*, *Set Độc Hóa*, *Set Plasma*)

## 3.2 Mở Rộng Quái Vật & Tiến Hóa 5 Cấp (15+ Species)
- [x] `scripts/data/monster_database.gd`: 15+ Loài quái vật trải dài 5 Nguyên tố (Lửa, Băng, Độc, Điện, Bóng Tối)
- [x] `scripts/systems/monster_system.gd`: Tiến hóa 5 giai đoạn (*Baby → Juvenile → Adult → Elder → Apex*) & Lai tạo quái đột biến

## 3.3 Mở Rộng Linh Kiện Mecha (16 Parts)
- [x] `scripts/data/mecha_database.gd`: 16 Linh kiện (4 Đầu, 4 Thân, 4 Tay, 4 Chân)
- [x] `scripts/systems/mecha_system.gd`: Lắp ráp Robot 4 bộ phận, tiêu thụ 5 điểm nhiên liệu & Nạp năng lượng

## 3.4 Công Thức Chế Tạo, Thành Tựu & Bản Ngữ
- [x] `scripts/data/crafting_database.gd` (20+ Công thức chế tạo trang bị & linh kiện)
- [x] `scripts/data/siege_database.gd` (4 Trận vây hãm Boss daily: Bầy Zombie, Titan Mecha, Mẹ Trứng, Quái Phóng Xạ)
- [x] `scripts/data/achievement_database.gd` (35+ Thành tựu in-game với phần thưởng Vàng & Pha lê)
- [x] `locale/vi.csv` & `locale/en.csv` — Bản dịch đa ngôn ngữ Việt - Anh chuẩn xác

---

# ═══════════════════════════════════════════════════════════════
# PHASE 4: STEAMWORKS, MOBILE BUILD & VERIFICATION (HOÀN THÀNH 100%)
# ═══════════════════════════════════════════════════════════════

## 4.1 Tích Hợp Steamworks & DRM Launch
- [x] GodotSteam DRM Enforcement (`Steam.restartAppIfNecessary`)
- [x] Đồng bộ Steam Achievements & Steam Cloud Save

## 4.2 Xuất Bản Nền Tảng Di Động (Android & iOS)
- [x] Export Presets Android (Target SDK API 34, Touch targets >= 44x44dp)
- [x] Export Presets iOS & Safe Area Notch Adjustment

## 4.3 Kiểm Trử Tự Động & Đồng Bộ GitHub
- [x] `scripts/tests/run_tests.gd` — Bộ kiểm tra tự động vượt qua 100% test cases trên 9 hệ thống cốt lõi
- [x] Đồng bộ 100% mã nguồn, tài liệu và scenes lên GitHub repository: https://github.com/meslipking/dead-frontier
