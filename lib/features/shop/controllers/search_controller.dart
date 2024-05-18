import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/repositories/product/product_repository.dart';
import '../models/product_model.dart';

class SHFSearchController extends GetxController {
  static SHFSearchController get instance => Get.find();

  RxList<ProductModel> searchResults = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  RxString lastSearchQuery = ''.obs;

  void searchProducts(String query) async {
    lastSearchQuery.value = query;
    isLoading.value = true;

    try {
      final results = await ProductRepository.instance.searchProducts(query);

      // Lọc kết quả dựa trên truy vấn tìm kiếm
      final filteredResults = results.where((item) {
        return item.title.toLowerCase().contains(query.toLowerCase()) ||
            item.brand!.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      // Cập nhật searchResults với kết quả đã được lọc
      searchResults.assignAll(filteredResults);
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi tìm nạp dữ liệu: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
