import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:second_hand_fashion_app/features/shop/models/category_model.dart';

import '../../utils/exceptions/firebase_exception.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  ///Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Get sub categories
  ///Upload categories to the cloud firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async{
    try{
      //Tải lên tất cả các Danh mục cùng với Hình ảnh của chúng
      final storage = Get.put(SHFFirebaseStorageService());

      //Loop through each category
      for(var category in categories){
        //Nhận liên kết ImageData từ nội dung cục bộ
        final file = await storage.getImageDataFromAssets(category.image);

        //Gán URL cho danh mục trong Firestore
        await _db.collection('Categories').doc(category.id).set(category.toJson());
      }
    }on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
