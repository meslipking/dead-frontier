# Mô-đun 01: Khởi Tạo Project Godot 4 & Cấu Trúc Thư Mục

## 1. Tổng quan
Mô-đun 01 quy định kiến trúc dự án, môi trường thực thi, cấu hình Godot Engine 4.4+ và quy trình xuất bản đa nền tảng (Steam PC Windows/macOS/Linux, Android APK và iOS IPA).

## 2. Thông số Kỹ thuật Engine
- **Engine**: Godot Engine 4.4+ (Standard Edition)
- **Render Backend**: GL Compatibility (OpenGL ES 3.0 / WebGL 2.0) đảm bảo tương thích 100% trên thiết bị di động tầm trung và PC
- **Độ phân giải chuẩn**: 360 x 640 (Dọc - Portrait Mode Mobile)
- **Stretch Mode**: `canvas_items`
- **Aspect Ratio**: `expand` (tự động mở rộng giao diện responsive trên màn hình PC 16:9 / 21:9)

## 3. Kiến trúc Singletons (Autoloads)
Dự án sử dụng 5 Autoload singletons khởi tạo ngay khi ứng dụng boot:
1. `Constants` (`scripts/core/constants.gd`): Từ điển dữ liệu toàn cục, Enums nguyên tố, cấp hiếm, phòng, vật phẩm.
2. `EventBus` (`scripts/core/event_bus.gd`): Trạm phát tín hiệu (Signals) cho giao tiếp decoupled giữa các mô-đun.
3. `GameManager` (`scripts/core/game_manager.gd`): Quản lý State chính, routing Tab và 4 loại tiền tệ.
4. `SaveManager` (`scripts/core/save_manager.gd`): Quản lý lưu/tải dữ liệu mã hóa chống hack FNV-1a + XOR.
5. `IdleEngine` (`scripts/core/idle_engine.gd`): Động cơ đếm nhịp Idle và giả lập vắng mặt Offline.

## 4. Phân chia Cấu trúc Thư mục Modular
```
DeadFrontier/
├── project.godot               # File cấu hình gốc Godot
├── scenes/                     # Giao diện Scene (.tscn)
│   ├── main/                   # Main root & loading
│   ├── outpost/                # 8 phòng tiền đồn
│   ├── squad/                  # Quản lý đội hình
│   ├── wastelands/             # Vùng hoang & chiến đấu
│   ├── sieges/                 # Trận vây hãm Boss
│   └── shared/                 # Component dùng chung (Cards, Nav)
├── scripts/                    # Mã nguồn GDScript
│   ├── core/                   # Autoload Singletons
│   ├── combat/                 # Động cơ chiến đấu
│   ├── data/                   # Databases
│   ├── systems/                # Hệ thống game
│   ├── ui/                     # Controllers UI
│   └── utils/                  # Utility helpers
├── resources/                  # Godot Resources (.tres)
├── assets/                     # Pixel art, audio, fonts
└── locale/                     # Đa ngôn ngữ (vi.csv, en.csv)
```
