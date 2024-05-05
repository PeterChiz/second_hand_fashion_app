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

  ///Load category data
  Future<void> fetchCategories() async {
    try {
      //Hiển thị loader trong khi tải danh mục
      isLoading.value = true;
      // Tìm nạp các danh mục từ nguồn dữ liệu (Firesore, API, v.v.,...)
      final categories = await _categoryRepository.getAllCategories();
      //Cập nhật danh sách danh mục
      allCategories.assignAll(categories);
      // Lọc các danh mục nổi bật
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///Tải dữ liệu danh mục đã chọn
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    // Fetch all categories where ParentId = categoryId;
    try {
      final subCategories = await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
      return [];
    }
  }

  ///Đặt danh mục trên các sản phẩm Danh mục phụ
  // Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
  //   try{
  //     //Fetch limited (4) products against each subCategory
  //     final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId,limit: limit);
  //     return products;
  //   }catch(e){
  //     SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
  //     return [];
  //   }
  // }
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
    // Fetch limited (4) products against each subCategory;
    final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
    return products;
  }
}
