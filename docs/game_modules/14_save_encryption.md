# Mô-đun 14: Mã Hóa Save Data & Bảo Mật Anti-Cheat

## 1. Thuật Toán FNV-1a Checksum + XOR Cipher
Save file lưu tại `user://deadfrontier_save.dat` được bảo vệ bằng 2 lớp:
1. **FNV-1a Hash**: Tính toán checksum 32-bit của chuỗi JSON save data.
2. **XOR Cipher (Key 0x7B)**: Mã hóa byte-by-byte sang chuỗi Hex.

## 2. Phát Hiện Chỉnh Sửa File (Anti-Tamper)
Khi nạp save game, `SaveManager` sẽ giải mã chuỗi Hex, tính lại hash FNV-1a và so sánh với checksum lưu trữ. Nếu checksum không khớp, game sẽ phát tín hiệu `save_corrupted` và tự động khôi phục save an toàn.
