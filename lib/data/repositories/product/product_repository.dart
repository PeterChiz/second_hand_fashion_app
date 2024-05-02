import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/data/services/cloud_storage/firebase_storage_service.dart';

import '../../../features/shop/models/product_model.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  ///Firebase instance for database interactions
  final _db = FirebaseFirestore.instance;

  ///Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').where(
          'IsFeatured', isEqualTo: true).limit(4).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  ///Get limited featured products
  Future<List<ProductModel>> getAllFeatureProducts() async {
    try {
      final snapshot = await _db.collection('Products').where(
          'IsFeatured', isEqualTo: true).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  ///Get product based on the brand
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs.map((doc) =>
          ProductModel.fromQuerySnapshot(doc)).toList();
      return productList;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  ///
  Future<List<ProductModel>> getFavoriteProducts(List<String> productIds) async {
    try {
      final snapshot = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();
      return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot)).toList();
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  ///
  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1 ? await _db.collection('Products')
          .where('Brand.Id', isEqualTo: brandId)
          .get() : await _db.collection('Products').where(
          'Brand.Id', isEqualTo: brandId).limit(limit).get();
      final products = querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return products;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }

  ///
  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      //Truy vấn để nhận tất cả document trong đó ProductId khớp với CategoryId được cung cấp & Tìm limited hạn hoặc unlimited dựa trên limit
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).limit(limit).get();
      //Trích xuất ID sản phẩm từ document
      List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId'] as String).toList();

      //Truy vấn để lấy tất cả tài liệu có brandId trong danh sách brandIds, FieldPath.documentId để truy vấn document trong Collection
      final productsQuery = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();

      //Trích xuất tên thương hiệu hoặc dữ liệu liên quan khác từ tài liệu
      List<ProductModel> products = productsQuery.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return products;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
  }


  ///Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      //Update all products along with their image
      final storage = Get.put(SHFFirebaseStorageService());

      //Loop Through each product
      for (var product in products) {
        //Get image data link from local assets
        final thumbnail = await storage.getImageDataFromAssets(
            product.thumbnail);

        //Upload image and get its URL
        final url = await storage.uploadImageData(
            'Products/Images', thumbnail, product.thumbnail.toString());

        //Assign URL to product.thumbnail attribute
        product.thumbnail = url;

        //Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];
          for (var image in product.images!) {
            //Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            //Upload image and get its URL
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, image);

            //Assign URL to product.thumbnail attribute
            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        //Upload Variation Images
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            //Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(
                variation.image);

            //upload image and get its URL
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, variation.image);

            //Assign URL to variation.image attribute
            variation.image = url;
          }
        }

        //Store product in Firestore
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}