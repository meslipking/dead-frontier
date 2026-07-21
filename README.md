# ☠️ Dead Frontier: Mecha & Monsters

> **Idle RPG hậu tận thế** — Xây dựng tiền đồn, thu phục quái vật đột biến, chế tạo robot chiến đấu và sinh tồn trong thế giới zombie!

---

## 🎮 Gameplay

Dead Frontier: Mecha & Monsters là game idle RPG kết hợp 3 trụ cột gameplay:

### 🧟 Zombie Outpost — Quản lý Tiền đồn
Xây dựng và nâng cấp căn cứ với 8 phòng chức năng. Tuyển mộ người sống sót, trang bị vũ khí và phòng thủ trước làn sóng zombie.

### 🐉 Monster Ranch — Thu phục Quái vật
Bắt quái vật đột biến trong vùng hoang. Nuôi dưỡng, tiến hóa qua 5 giai đoạn và lai tạo giống mới. Mỗi quái có nguyên tố và kỹ năng riêng.

### 🤖 Mecha Factory — Chế tạo Robot
Thu thập phế liệu → chế tạo bộ phận → lắp ráp robot chiến đấu. Tùy biến từ Head, Torso, Arms, Legs với hàng trăm tổ hợp khác nhau.

---

## ✨ Tính năng chính

- 👤 **6 lớp nhân vật** — Trinh sát, Y tá, Kỹ sư, Xạ thủ, Đấu sĩ, Thủ lĩnh
- 🐾 **10+ loài quái vật** với 5 nguyên tố (Lửa/Băng/Độc/Điện/Bóng tối)
- 🤖 **Hệ thống Mecha** — Lắp ráp từ 20+ bộ phận, tùy biến vô hạn
- 🌍 **7 vùng hoang** để thám hiểm idle
- ⚔️ **4 trận vây hãm daily** với boss độc đáo
- 🏗️ **8 phòng tiền đồn** nâng cấp được
- 📦 **Hệ thống trang bị** 6 cấp hiếm (Common → Mythic)
- 🔨 **Chế tạo** vũ khí và trang bị từ nguyên liệu
- 💤 **Idle/AFK** — Game chạy ngầm, mở lại nhận thưởng
- 🔄 **Prestige** — Reset để nhận bonus vĩnh viễn
- 🏆 **50+ thành tựu**
- 🌐 **Song ngữ** Tiếng Việt / English

---

## 🎨 Art Style

- **SNES-era 16-bit pixel art** (32x32 / 64x64 sprites)
- Dark post-apocalyptic palette
- Glassmorphism UI panels
- Smooth animations & VFX particles

---

## 🖥️ Nền tảng

| Nền tảng | Trạng thái |
|----------|-----------|
| **Steam** (Windows/macOS/Linux) | 🔨 Đang phát triển |
| **Android** (Google Play) | 🔨 Đang phát triển |
| **iOS** (App Store) | 🔨 Đang phát triển |

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Engine** | Godot 4.4+ |
| **Ngôn ngữ** | GDScript (chính) + C# (hệ thống nặng) |
| **Rendering** | Godot 2D Engine (Vulkan/OpenGL) |
| **Steam** | GodotSteam Plugin |
| **Mobile** | Godot Native Export |
| **Save** | FileAccess + FNV-1a Encryption |

---

## 📁 Project Structure

```
DeadFrontier/
├── scenes/          # Godot scenes (.tscn)
│   ├── main/        # Main menu, loading
│   ├── outpost/     # 8 phòng tiền đồn
│   ├── squad/       # Quản lý đội hình
│   ├── wastelands/  # Vùng hoang & chiến đấu
│   ├── sieges/      # Trận vây hãm daily
│   └── shared/      # Components dùng chung
├── scripts/         # GDScript files
│   ├── core/        # Game engine singletons
│   ├── combat/      # Hệ thống chiến đấu
│   ├── data/        # Databases (survivors, monsters, items...)
│   ├── systems/     # Game systems (inventory, crafting, progression...)
│   ├── ui/          # UI controllers
│   └── utils/       # Helpers, PRNG, encryption, i18n
├── resources/       # Godot Resources (.tres)
├── assets/          # Pixel art, audio, fonts
├── locale/          # Localization (vi.csv, en.csv)
├── addons/          # GodotSteam plugin
├── docs/            # 19 module documentation files
├── builds/          # Export outputs
└── steam_assets/    # Steam store images
```

---

## 🚀 Phát triển

### Yêu cầu
- [Godot 4.4+](https://godotengine.org/download) (Standard Edition)
- Android SDK (cho mobile build)
- Steamworks SDK (cho Steam build)

### Chạy từ source
1. Clone repository
2. Mở Godot Editor → Import project → chọn thư mục `DeadFrontier`
3. Nhấn ▶️ Play

### Build
```
Export → Windows Desktop → DeadFrontier.exe
Export → Android → DeadFrontier.apk
Export → iOS → DeadFrontier.ipa
```

---

## 📋 Roadmap

- [x] 📐 Game Design Document
- [x] 🏗️ Project Structure
- [ ] 🔨 Phase 1 — Foundation & MVP (Navigation, Idle Loop, Save)
- [ ] ⚔️ Phase 2 — Core Combat & Systems (Combat, Items, Monsters)
- [ ] 🚀 Phase 3 — Advanced Features (Mecha, Evolution, Sieges, Prestige)
- [ ] ✨ Phase 4 — Polish & Distribution (Steam, Android, iOS, Audio, QA)

---

## 📝 License

All Rights Reserved © Dead Frontier Studio 2026
