import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_hand_fashion_app/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name; // Tên
  final String phoneNumber; // Số điện thoại
  final String street; // Đường
  final String city; // Thành phố
  final DateTime? dateTime; // Thời gian
  bool selectedAddress; // Địa chỉ đã chọn

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => SHFFormatter.formatPhoneNumber(phoneNumber); // Nhận số điện thoại đã định dạng

  static AddressModel empty() => AddressModel(id: '', name: '', phoneNumber: '', street: '', city: ''); // Tạo một địa chỉ rỗng

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'DateTime' : DateTime.now(),
      'SelectedAddress' : selectedAddress,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      name: data['Name'] as String,
      phoneNumber: data['PhoneNumber'] as String,
      street: data['Street'] as String,
      city: data['City'] as String,
      selectedAddress: data['SelectedAddress'] as bool,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  // Constructor factory để tạo một AddressModel từ một DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['SelectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return '$street, $city';
  }
}
