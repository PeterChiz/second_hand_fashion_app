import 'dart:convert';

import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/product/product_repository.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/local_storage/storage_utility.dart';

class FavoritesController extends GetxController{
  static FavoritesController get instance => Get.find();

  ///Variable
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    initFavorites();
    super.onInit();
  }



  //Method to initialize favourites by reading from storage
  Future<void> initFavorites() async{
    final json = SHFLocalStorage.instance().readData('favorites');
    if(json != null){
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String productId){
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId){
    if(!favorites.containsKey(productId)){
      favorites[productId] = true;
      saveFavoritesToStorage();
      SHFLoaders.customToast(message: 'Sản phẩm đã được thêm vào Yêu thích');
    }else{
      SHFLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      SHFLoaders.customToast(message: 'Sản phẩm đã được xóa khỏi Yêu thích');
    }
  }

  void saveFavoritesToStorage(){
    final encodeFavorites = json.encode(favorites);
    SHFLocalStorage.instance().saveData('favorites', encodeFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async{
    return await ProductRepository.instance.getFavoriteProducts(favorites.keys.toList());
  }
}