import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';
import '../../shop/models/cart_model.dart';
import 'address_model.dart';

/// Lớp mô hình đại diện cho dữ liệu người dùng.
class UserModel {
  // Giữ những giá trị final mà bạn không muốn cập nhật
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  final CartModel? cart;
  final List<AddressModel>? addresses;

  /// Constructor cho UserModel.
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.cart,
    this.addresses,
  });

  /// Hàm trợ giúp để lấy tên đầy đủ.
  String get fullName => '$lastName $firstName';

  /// Hàm trợ giúp để định dạng số điện thoại.
  String get formattedPhoneNo => SHFFormatter.formatPhoneNumber(phoneNumber);

  /// Hàm tĩnh để tách tên đầy đủ thành họ và tên.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Hàm tĩnh để tạo tên người dùng từ tên đầy đủ.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String firstName = nameParts[0].toLowerCase();

    String camelCaseUsername = "$lastName$firstName"; // Kết hợp họ và tên
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Thêm tiền tố "cwt_"
    return usernameWithPrefix;
  }

  /// Hàm tĩnh để tạo một mô hình người dùng trống.
  static UserModel empty() => UserModel(id: '', firstName: '', lastName: '', username: '', email: '', phoneNumber: '', profilePicture: '');

  /// Chuyển đổi mô hình thành cấu trúc JSON để lưu trữ dữ liệu trong Firebase.
  Map<String, dynamic> toJson() {
    return {
      'LastName': lastName,
      'FirstName': firstName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  /// Phương thức factory để tạo một UserModel từ một snapshot tài liệu Firebase.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        lastName: data['LastName'] ?? '',
        firstName: data['FirstName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
