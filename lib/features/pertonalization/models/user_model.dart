import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_hand_fashion_app/utils/formatters/formatter.dart';

///Model class representing user data
class UserModel {
  //Giữ những giá trị cuối cùng mà bạn không muốn cập nhật
  final String id;
  String lastName;
  String firstName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  ///Hàm tạo cho UserModel
  UserModel({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });


  ///Helper function to get the full name
  String get fullName => '$lastName $firstName';

  ///Helper function to format phone number
  String get formattedPhoneNo => SHFFormatter.formatPhoneNumber(phoneNumber);

  ///Static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  ///Static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String firstName = nameParts[0].toLowerCase();

    String camelCaseUsername = "$lastName$firstName";
    String usernameWithPrefix = "ctw_$camelCaseUsername"; //add ctw_ Prefix
    return usernameWithPrefix;
  }

  ///Static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      lastName: '',
      firstName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  ///Chuyển đổi mô hình sang cấu trúc JSON để lưu trữ dữ liệu trong Firebase
  Map<String, dynamic> toJson() {
    return {
      'LastName': lastName,
      'FirstName': firstName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  ///Factory method để tạo UserModel từ Firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          lastName: data['LastName'] ?? '',
          firstName: data['FirstName'] ?? '',
          userName: data['UserName'] ?? '',
          email: data['Email'] ?? '',
          phoneNumber: data['PhoneNumber'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '');
    }else{
      return UserModel.empty();
    }
  }
}
