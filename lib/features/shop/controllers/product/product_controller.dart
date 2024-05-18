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

  /// -- Khởi tạo Sản phẩm từ backend của bạn
  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  /// Lấy Sản phẩm sử dụng Stream để bất kỳ thay đổi nào cũng có thể có hiệu lực ngay lập tức.
  void fetchFeaturedProducts() async {
    try {
      // Hiển thị loader trong khi tải Sản phẩm
      isLoading.value = true;

      // Lấy Sản phẩm
      final products = await productRepository.getFeaturedProducts();

      // Gán Sản phẩm
      featuredProducts.assignAll(products);
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Lấy giá Sản phẩm hoặc dải giá cho các biến thể.
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // Nếu không có biến thể tồn tại, trả về giá đơn giản hoặc giá giảm giá
    if (product.productType == ProductType.single.toString() || product.productVariations!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price).toString();
    } else {
      // Tính toán giá nhỏ nhất và lớn nhất trong các biến thể
      for (var variation in product.productVariations!) {
        // Xác định giá cần xem xét (giá giảm giá nếu có, nếu không, giá thường)
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Cập nhật giá nhỏ nhất và lớn nhất
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // Nếu giá nhỏ nhất và lớn nhất giống nhau, trả về một giá duy nhất
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        // Ngược lại, trả về một dải giá
        return '$smallestPrice\đ - $largestPrice';
      }
    }
  }

  /// -- Tính toán Phần trăm Giảm giá
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// -- Kiểm tra Trạng thái Kho hàng của Sản phẩm
  String getProductStockStatus(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      return product.stock > 0 ? 'Còn hàng' : 'Hết hàng';
    } else {
      final stock = product.productVariations?.fold(0, (previousValue, element) => previousValue + element.stock);
      return stock != null && stock > 0 ? 'Còn hàng' : 'Hết hàng';
    }
  }
}
