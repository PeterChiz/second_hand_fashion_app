import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SHFFirebaseStorageService extends GetxController {
  static SHFFirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  ///Tải nội dung cục bộ lên từ IDE
  ///Return a Uint8list chứa dữ liệu hình ảnh
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      //xu ly loi ngoai luong
      throw 'Lỗi tải dữ liệu hình ảnh: $e';
    }
  }

  ///Tải hình ảnh lên bằng Dữ liệu hình ảnh trên Cloud Firebase Storage
  ///Trả về download URL của hình ảnh đã tải lên
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      //xu ly loi ngoai luong
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Đã xảy ra lỗi! Vui lòng thử lại';
      }
    }
  }

  ///Tải hình ảnh lên firebase storage trên cloud
  ///Trả về download URL của hình ảnh đã tải lên
  Future<String> uploadImageFile(String path, XFile image)async{
    try{
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch(e){
      //xu ly loi ngoai luong
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Đã xảy ra lỗi! Vui lòng thử lại';
      }
    }
  }
}
