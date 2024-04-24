import 'package:second_hand_fashion_app/features/shop/models/banner_model.dart';

class BrandModel{
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel(
  {required this.id, required this.name, required this.image, this.isFeatured, this.productsCount});

  ///Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  ///Convert model to Json structure so that you can store data in Firebase
  toJson(){
    return{
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  ///Map Json oriented document snapshot from Firebase to UserModel
  factory BrandModel.fromJson(Map<String, dynamic> document){
    final data = document;
    if(data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? '',
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: data['ProductsCount'] ?? 0,
    );
  }
}