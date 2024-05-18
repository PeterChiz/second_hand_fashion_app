import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/product_model.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

/// Kho dữ liệu cho việc quản lý dữ liệu và các thao tác liên quan đến sản phẩm.
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firestore instance để tương tác với cơ sở dữ liệu.
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- CÁC HÀM ---------------------------------*/

  /// Nhận sản phẩm nổi bật có giới hạn.
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có lỗi gì đó, vui lòng thử lại!';
    }
  }

  /// Nhận tất cả sản phẩm nổi bật sử dụng Stream.
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    final snapshot = await _db
        .collection('Products')
        .where('IsFeatured', isEqualTo: true)
        .get();
    return snapshot.docs
        .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
        .toList();
  }

  /// Nhận sản phẩm dựa trên Thương hiệu
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có lỗi gì đó, vui lòng thử lại!';
    }
  }

  /// Nhận sản phẩm yêu thích dựa trên danh sách ID sản phẩm.
  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có lỗi gì đó, vui lòng thử lại!';
    }
  }

  /// Lấy sản phẩm cho một danh mục cụ thể.
  /// Nếu giới hạn là -1, lấy tất cả sản phẩm cho danh mục; nếu không, giới hạn kết quả dựa trên giới hạn đã cung cấp.
  /// Trả về danh sách các đối tượng [ProductModel].
  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      // Truy vấn để nhận tất cả tài liệu nơi productId khớp với categoryId đã cung cấp
      // & Lấy có giới hạn hoặc không giới hạn dựa trên limit
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      // Trích xuất productIds từ các tài liệu
      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      // Truy vấn để nhận tất cả tài liệu nơi brandId nằm trong danh sách brandIds, FieldPath.documentId để truy vấn tài liệu trong Collection
      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      // Trích xuất tên thương hiệu hoặc các dữ liệu liên quan khác từ các tài liệu
      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có lỗi gì đó, vui lòng thử lại!';
    }
  }

  /// Lấy sản phẩm cho một thương hiệu cụ thể.
  /// Nếu giới hạn là -1, lấy tất cả sản phẩm cho thương hiệu; nếu không, giới hạn kết quả dựa trên giới hạn đã cung cấp.
  /// Trả về danh sách các đối tượng [ProductModel].
  Future<List<ProductModel>> getProductsForBrand(
      String brandId, int limit) async {
    try {
      // Truy vấn để nhận tất cả tài liệu nơi productId khớp với categoryId đã cung cấp & Lấy có giới hạn hoặc không giới hạn dựa trên limit
      QuerySnapshot<Map<String, dynamic>> querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      // Lập bản đồ sản phẩm
      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có lỗi gì đó, vui lòng thử lại!';
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      // Tham chiếu đến 'products' collection trong Firestore
      CollectionReference productsCollection =
          FirebaseFirestore.instance.collection('Products');

      // Bắt đầu với một truy vấn cơ bản để tìm kiếm các sản phẩm nơi tên chứa truy vấn
      Query queryRef = productsCollection;

      // Thực hiện truy vấn
      QuerySnapshot querySnapshot = await queryRef.get();

      // Lọc kết quả dựa trên truy vấn tìm kiếm
      final filteredResults = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList()
          .where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase()) ||
            product.brand!.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      return filteredResults;
    } on FirebaseException catch (e) {
      throw SHFFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SHFPlatformException(e.code).message;
    } catch (e) {
      throw 'Có lỗi gì đó, vui lòng thử lại!';
    }
  }
}
