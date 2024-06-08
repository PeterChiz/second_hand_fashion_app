import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
  });

  /// Hàm trợ giúp trả về một đối tượng BrandModel rỗng
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  /// Chuyển đổi model thành cấu trúc Json để lưu dữ liệu vào Firebase
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
    };
  }

  /// Ánh xạ dữ liệu từ cấu trúc Json thành đối tượng BrandModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
    );
  }

  /// Ánh xạ từ dữ liệu snapshot từ Firebase thành đối tượng BrandModel
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
