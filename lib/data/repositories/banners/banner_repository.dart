import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/models/banner_model.dart';
import 'package:second_hand_fashion_app/utils/exceptions/format_exceptions.dart';
import 'package:path/path.dart' as path;
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/cloud_storage/firebase_storage_service.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  ///Đặt tất cả những thứ khác liên quan đến User hiện tại
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db.collection('Banners').where('Active', isEqualTo: true).limit(3).get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  ///Upload Banners to the Cloud Firebase
  Future<void> uploadBannersDummyData(List<BannerModel> banners) async {
    try {
      // Upload all the Categories along with their Images
      final storage = Get.put(SHFFirebaseStorageService());
      // Loop through each category
      for (var entry in banners) {
        // Get ImageData link from the local assets
        final thumbnail = await storage.getImageDataFromAssets(entry.imageUrl);

        // Upload Image and Get its URL
        final url = await storage.uploadImageData('Banners', thumbnail, path.basename(entry.imageUrl));

        // Assign URL to Brand.image attribute
        entry.imageUrl = url;

        // Store Category in Firestore
        await _db.collection("Banners").doc().set(entry.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

}
