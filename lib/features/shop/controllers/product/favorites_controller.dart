import 'dart:convert';

import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/product/product_repository.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/local_storage/storage_utility.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  /// Biến
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Khởi tạo bằng cách lấy danh sách yêu thích đã được thêm trước đó
    initFavorites();
  }

  // Phương thức để khởi tạo danh sách yêu thích bằng cách đọc từ bộ nhớ
  Future<void> initFavorites() async {
    final json = SHFLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  /// Phương thức để kiểm tra xem một sản phẩm có được chọn (yêu thích) hay không
  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  /// Thêm Sản phẩm vào danh sách Yêu thích
  void toggleFavoriteProduct(String productId) {
    // Nếu danh sách yêu thích không chứa sản phẩm này, thêm. Ngược lại, chuyển đổi
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

  // Lưu danh sách yêu thích đã cập nhật vào bộ nhớ
  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    SHFLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  /// Phương thức để lấy danh sách sản phẩm yêu thích
  Future<List<ProductModel>> favoriteProducts() {
    return ProductRepository.instance.getFavouriteProducts(favorites.keys.toList());
  }
}
