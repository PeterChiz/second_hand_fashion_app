import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';

import '../../../../data/repositories/product/product_repository.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  /// -- Initialize Products from your backend
  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  /// Fetch Products using Stream so, any change can immediately take effect.
  void fetchFeaturedProducts() async {
    try {
      // Show loader while loading Products
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getFeaturedProducts();

      // Assign Products
      featuredProducts.assignAll(products);
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get the product price or price range for variations.
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variations exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString() || product.productVariations!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price).toString();
    } else {
      // Calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        // Determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // If smallest and largest prices are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        // Otherwise, return a price range
        return '$smallestPrice - $largestPrice\đ';
      }
    }
  }

  /// -- Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// -- Check Product Stock Status
  String getProductStockStatus(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      return product.stock > 0 ? 'Còn hàng' : 'Hết hàng';
    } else {
      final stock = product.productVariations?.fold(0, (previousValue, element) => previousValue + element.stock);
      return stock != null && stock > 0 ? 'Còn hàng' : 'Hết hàng';
    }
  }
}
