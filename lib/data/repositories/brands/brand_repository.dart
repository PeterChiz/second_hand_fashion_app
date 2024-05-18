import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/models/brand_model.dart';


class BrandRepository extends GetxController{
  static BrandRepository get instance => Get.find();

  ///Biến
  final _db = FirebaseFirestore.instance;

  ///Nhận tất cả thương hiệu
  Future<List<BrandModel>> getAllBrands() async{
    try {
      final snapshot = await _db.collection('Brands').get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Đã xảy ra lỗi khi nạp Banners';
    }
  }


  ///Nhận thương hiệu theo danh mục
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async{
    try {
      //Truy vấn để nhận tất cả tài liệu nơi categoryId khớp với categoryId đã cung cấp
      QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').where('categoryId', isEqualTo: categoryId).get();

      //Trích xuất thương hiệu từ các tài liệu
      List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();

      //Truy vấn để nhận tất cả tài liệu nơi brandId nằm trong danh sách brandIds, FieldPath.documentId để truy vấn tài liệu trong Collection
      final brandsQuery = await _db.collection('Brands').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      //Trích xuất tên thương hiệu hoặc các dữ liệu liên quan khác từ các tài liệu
      List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;

    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Đã xảy ra lỗi khi nạp Banners';
    }
  }
}
