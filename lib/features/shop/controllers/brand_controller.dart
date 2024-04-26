import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/brand_repository.dart';
import 'package:second_hand_fashion_app/data/repositories/product/product_repository.dart';
import 'package:second_hand_fashion_app/features/shop/models/brand_model.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  ///Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      //Show loader while loading Brands
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Stop loading
      isLoading.value = false;
    }
  }

  ///Get Brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }


  ///Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
