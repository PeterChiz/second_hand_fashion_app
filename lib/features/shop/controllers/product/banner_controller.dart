
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/models/banner_model.dart';

import '../../../../utils/popups/loader.dart';
import '../../../../data/repositories/banners/banner_repository.dart';

class BannerController extends GetxController{

  ///Variables
  final bannersLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  ///Cap nhat cac dots dieu huong page
  void updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }

  ///Fetch Banners
  Future<void> fetchBanners() async {
    try {
      // Start Loading
      bannersLoading.value = true;

      // Fetch Banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      // Assign banners
      this.banners.assignAll(banners);
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    } finally {
      bannersLoading.value = false;
    }
  }
}