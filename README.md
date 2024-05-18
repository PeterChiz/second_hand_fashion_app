# second_hand_fashion_app
## Getting Started

Điều kiện để chạy app:
SDK version không quá lỗi thời tầm 3.0.5 trở lên 

Cách chay hết pubspec:
-Click vào terminal trên Android Studio => gõ "flutter pub get"

Định cấu hình Firebase:
-Tạo một dự án Firebase mới trên Firebase Console.
-Theo dõi hướng dẫn trong tài liệu Firebase để thiết lập Firebase trong dự án Flutter của bạn.
-Chạy ứng dụng của bạn trên second_hand_fashion_app: Để khởi chạy ứng dụng Flutter, hãy sử dụng lệnh sau: "flutter run"
Kích hoạt dịch vụ Firebase Trong Firebase Console, chọn dự án của bạn. Sau đó, làm theo các bước sau để kích hoạt các dịch vụ cần thiết:

Xác thực:
Nhấp vào “Authentication” trong thanh bên trái.
Điều hướng đến tab “Sign-in method”.
Kích hoạt các phương thức xác thực bạn muốn (ví dụ: Google, Facebook, Email/Password).
Firestore (Database):
Nhấp vào “Firestore” trong thanh bên trái.
Nhấp vào “Create Database” và chọn vị trí.
Chọn “Start in test mode” cho mục đích phát triển.
Storage:
Nhấp vào “Storage” trong thanh bên trái.
Nhấp vào “Get Started.”
Thực hiện theo hướng dẫn cài đặt.
Bước 5: Tạo SHA1 và SHA256 fingerprints Đi đến thư mục dự án trong Terminal và chạy lệnh sau tương ứng với hệ điều hành của bạn:

Mac:
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

Windows:
keytool -list -v -keystore "\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

Linux:
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

Bước 6: Thêm SHA1 và SHA256 Fingerprints vào Firebase Console Điều hướng đến Cài đặt dự án (Biểu tượng bánh răng phía trước Tổng quan dự án) > Tab Chung > Ứng dụng của bạn. Chọn ứng dụng của bạn và điều hướng đến nút “Thêm fingerprints”. Thêm cả SHA-1 và SHA-256 fingerprints.

Cấu hình IOS

Bước 1: Lấy Reversed_Client_ID:
Điều hướng đến thư mục gốc của dự án > IOS > Runner > GoogleServices_Info.plist
Tìm mục “Reversed_Client_ID”
Sao chép “Reversed_Client_ID”
Bước 2: Thay thế Reversed_Client_ID trong Info.plist
Quay lại ios > Runner > Info.plist
Tìm phần “Google Sign-in & Facebook Sign-in” trong Info.plist
Thay thế “Reversed_Client_ID” bằng giá trị đã lấy được từ GoogleServices_Info.plist.
