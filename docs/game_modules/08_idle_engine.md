# Mô-đun 08: Động Cơ Thám Hiểm Idle & Giả Lập Offline

## 1. Cơ Chế Thám Hiểm Theo Nhịp (Tick System)
- Động cơ chạy timer 1 giây/lần khi ứng dụng hoạt động (Online Mode).
- Mỗi nhịp tick, tổng sức mạnh đội hình (Team Power) sẽ tích lũy điểm thám hiểm cho Vùng hoang tương ứng.
- Khi điểm thám hiểm đạt mốc Sector (100 điểm), sector được dọn dẹp và phần thưởng loot được tạo tự động.

## 2. Giả Lập Vắng Mặt (Offline Simulation)
- Khi người chơi mở lại game, ứng dụng tính khoảng thời gian vắng mặt: `Offline_Seconds = Now - Last_Online_Timestamp`.
- Tối đa giả lập: **8 giờ vắng mặt**.
- Thuật toán **Mulberry32 Seeded PRNG** chạy giả lập kết quả thám hiểm deterministic (đảm bảo chống gian lận chỉnh giờ thiết bị).
