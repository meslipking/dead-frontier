# Mô-đun 15: Động Cơ Âm Thanh Procedural & Asset Mixer

## 1. Cấu Trúc Audio Channels (Audio Bus)
- **Master Bus**: Tổng quản lý âm lượng.
- **Music Bus**: Nhạc nền BGM (Menu, Vùng hoang, Combat).
- **SFX Bus**: Âm thanh hiệu ứng (Tiếng vung kiếm, bắn súng, nổ, nhặt vàng, level up).

## 2. Quản Lý Âm Lượng
Âm lượng từng kênh được lưu tự động trong `settings` của Save file và áp dụng tức thì qua `AudioServer.set_bus_volume_db()`.
