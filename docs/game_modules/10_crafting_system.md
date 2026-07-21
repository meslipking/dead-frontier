# Mô-đun 10: Hệ Thống Chế Tạo Tại Xưởng Máy (Workshop)

## 1. Quy Trình Chế Tạo Item
1. Người chơi chọn công thức từ danh sách đã mở khóa.
2. Hệ thống kiểm tra số dư Vàng và số lượng nguyên liệu trong Kho chứa.
3. Khấu trừ chi phí Vàng và tiêu thụ nguyên liệu tương ứng.
4. Tung xúc xắc kiểm tra tỷ lệ thành công:
   `Success_Rate = Base_Rate + (Workshop_Level - 1) * 0.02`
5. Nếu thành công: Tạo vật phẩm mới và thêm vào Kho chứa.

## 2. Danh Sách Nguyên Liệu Cơ Bản
- **Phế liệu sắt**: Rớt ở Vùng hoang 1 & 3, dùng chế vũ khí sắt.
- **Mạch điện hỏng**: Rớt ở Vùng hoang 2 & 3, dùng chế linh kiện điện tử.
- **Dung dịch độc**: Rớt từ quái cống ngầm, dùng nuôi quái hoặc chế giáp Hazmat.
- **Hợp kim lạnh**: Rớt tại nhà máy bỏ hoang, dùng cho khung Mecha.
- **Lõi năng lượng**: Rớt tại các vùng độ khó cao, nạp điện cho Mecha.
