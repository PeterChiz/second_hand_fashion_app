import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';

import '../../../../data/repositories/product/product_repository.dart';

class ProductController extends GetxController{
  static ProductController get instance => Get.find();

  ///Variable
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

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

  Future<List<ProductModel>> fetchAllFeaturedProducts() async{
    try{
      //Fetch Products
      final products = await productRepository.getFeaturedProducts();
      return products;
    }catch(e){
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
      return [];
    }
  }

  ///Nhận giá sản phẩm hoặc khoảng giá cho các biến thể
  String getProductPrice(ProductModel product){
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    //neu khong co variation, return simple price hoac sale price
    if (product.productType == ProductType.single.toString() || product.productVariations!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price).toString();
    } else {
      //tinh gia tri nho nhat va gia tri lon nhat trong so cac variations
      for (var variation in product.productVariations!) {
        //xac dinh muc gia dung (gia sale neu co, khong thi lay gia binh thuong)
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        //cap nhat gia nho nhat va lon nhat
        if(priceToConsider < smallestPrice){
          smallestPrice = priceToConsider;
        }

        if(priceToConsider > largestPrice){
          largestPrice = priceToConsider;
        }
      }

      //neu gia nha nhat va lon nhat bang nhau, tra ve gia duy nhat
      if(smallestPrice.isEqual(largestPrice)){
        return largestPrice.toString();
      }else{
        //Nếu không,trả về một phạm vi giá
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  ///Tính phần trăm chiết khấu
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  ///Kiểm tra tình trạng tồn kho sản phẩm
  String getProductStockStatus(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      return product.stock > 0 ? 'Còn hàng' : 'Hết hàng';
    } else {
      final stock = product.productVariations?.fold(0, (previousValue, element) => previousValue + element.stock);
      return stock != null && stock > 0 ? 'Còn hàng' : 'Hết hàng';
    }
  }
}