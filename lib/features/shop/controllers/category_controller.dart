import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/product/product_repository.dart';
import 'package:second_hand_fashion_app/features/shop/models/category_model.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';

import '../../../data/repositories/categories/category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final _categoryRepository = Get.put(CategoryRepository());

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// -- Tải dữ liệu danh mục
  Future<void> fetchCategories() async {
    try {
      // Hiển thị loader trong khi tải danh mục
      isLoading.value = true;

      // Lấy danh mục từ nguồn dữ liệu (Firestore)
      final fetchedCategories = await _categoryRepository.getAllCategories();

      // Cập nhật danh sách các danh mục
      allCategories.assignAll(fetchedCategories);

      // Lọc ra các danh mục nổi bật
      featuredCategories.assignAll(allCategories.where((category) => (category.isFeatured) && category.parentId.isEmpty).take(8).toList());

    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  /// -- Tải dữ liệu danh mục con đã chọn
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    // Lấy tất cả các danh mục con có ParentId = categoryId;
    try {
      final subCategories = await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
      return [];
    }
  }

  /// Lấy Sản phẩm của Danh mục hoặc Danh mục con.
  /// Nếu muốn lấy tất cả các sản phẩm trong danh mục này, ĐẶT [limit] thành -1
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = -1}) async {
    final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
    return products;
  }
}
