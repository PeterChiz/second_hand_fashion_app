import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/pertonalization/models/user_model.dart';

import '../../../../utils/exceptions/firebase_exception.dart';
import '../../../../utils/exceptions/format_exceptions.dart';
import '../../../../utils/exceptions/platform_exceptions.dart';

///Lớp kho lưu trữ cho hoạt động liên quan đến người dùng
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Function lưu dữ liệu người dùng vào Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    }  on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Function lấy thông tin người dùng dựa trên ID người dùng.
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    }  on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function cập nhật dữ liệu người dùng trong Firestore.
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db.collection('Users').doc(updateUser.id).update(updateUser.toJson());
    }  on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Cập nhật bất kỳ trường nào trong Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection('Users').doc(AuthenticationRepository.instance.authUser.uid).update(json);
    }  on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Chức năng xóa dữ liệu người dùng khỏi Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    }  on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///upload any image
  Future<String> uploadImage(String path, XFile image) async{
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;

    }on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SHFFormatException();
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }

  }
}
