# Mô-đun 07: Động Cơ Chiến Đấu Turn-Based 4v4

## 1. Quy Trình Trận Đấu
1. Nạp thanh hành động Action Bar dựa trên chỉ số Tốc độ (SPD).
2. Unit có thanh hành động đầy 100% trước sẽ giành lượt tấn công.
3. AI chọn mục tiêu tấn công dựa trên chiến thuật (Nhắm mục tiêu máu thấp nhất hoặc đe dọa cao nhất).

## 2. Vòng Tròn Khắc Chế Nguyên Tố (1.5x Damage Bonus)
```
🔥 Lửa ──────> ❄️ Băng ──────> ☣️ Độc
  ▲                                │
  │                                ▼
⚡ Điện <────── 🔮 Bóng Tối <──────┘
```
- Khi tấn công mục tiêu hệ bị khắc chế, sát thương tăng **1.5 lần (+50%)**.

## 3. Công Thức Sát Thương (Damage Formula)
- **Né tránh (Dodge)**: Tỷ lệ né = `clamp((Defender_SPD - Attacker_SPD) * 0.01, 0, 0.30)`.
- **Chí mạng (Crit)**: Tỷ lệ crit = `clamp(0.05 + Luck * 0.005, 0.05, 0.50)`. Sát thương crit = `1.5x`.
- **Sát thương thực nhận**: `Final_DMG = max((ATK * Variance - DEF * 0.4), 1) * Crit_Mult * Element_Mult`.
