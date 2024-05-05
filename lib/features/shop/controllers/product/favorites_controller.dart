import 'dart:convert';

import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/product/product_repository.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/local_storage/storage_utility.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  /// Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize by fetching the list of already added favorites
    initFavorites();
  }

  // Method to initialize favorites by reading from storage
  Future<void> initFavorites() async {
    final json = SHFLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  /// Method to check if a product is selected (favorite)
  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  /// Add Product to Favourites
  void toggleFavoriteProduct(String productId) {
    // If favorites do not have this product, Add. Else Toggle
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      SHFLoaders.customToast(message: 'Sản phẩm đã được thêm vào Yêu thích');
    } else {
      SHFLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      SHFLoaders.customToast(message: 'Sản phẩm đã được xóa khỏi Yêu thích');
    }
  }

  // Save the updated favorites to storage
  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    SHFLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  /// Method to get the list of favorite products
  Future<List<ProductModel>> favoriteProducts() {
    return ProductRepository.instance.getFavouriteProducts(favorites.keys.toList());
  }
}
