import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/brands/brand_repository.dart';
import 'package:second_hand_fashion_app/data/repositories/product/product_repository.dart';
import 'package:second_hand_fashion_app/features/shop/models/brand_model.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// -- Tải Thương hiệu
  Future<void> getFeaturedBrands() async {
    try {
      // Hiển thị loader trong khi tải Thương hiệu
      isLoading.value = true;

      // Lấy Thương hiệu từ nguồn dữ liệu của bạn (Firestore, API, vv.)
      final fetchedCategories = await brandRepository.getAllBrands();

      // Cập nhật danh sách thương hiệu
      allBrands.assignAll(fetchedCategories);

      // Cập nhật danh sách thương hiệu nổi bật
      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4).toList());

    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Lấy Thương hiệu Cho Danh mục
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    final brands = await brandRepository.getBrandsForCategory(categoryId);
    return brands;
  }

  /// Lấy Sản phẩm Cụ thể của Thương hiệu từ nguồn dữ liệu của bạn
  Future<List<ProductModel>> getBrandProducts(String brandId, int limit) async {
    final products = await ProductRepository.instance.getProductsForBrand(brandId, limit);
    return products;
  }
}
