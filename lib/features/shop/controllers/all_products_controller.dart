import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/product/product_repository.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final products = await repository.fetchProductsByQuery(query);

      return products;
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    switch (sortOption) {
      case 'Tên':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Giá cao đến thấp':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Giá thấp đến cao':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Mới nhất':
        products.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      case 'Giảm giá':
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      default:
          //Default sorting option: Name
        products.sort((a,b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products){
    //Assign product to the 'Products' list
    this.products.assignAll(products);
    sortProducts('Name');
    }
}
