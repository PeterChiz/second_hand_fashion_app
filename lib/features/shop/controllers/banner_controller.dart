import 'dart:ffi';

import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/models/banner_model.dart';

import '../../../common/widgets/loaders/loader.dart';
import '../../../data/repositories/banners/banner_repository.dart';

class BannerController extends GetxController{

  ///Variables
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  ///Cap nhat cac dots dieu huong page
  void updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }

  ///Fetch Banners
  Future<void> fetchBanners() async {
    try {
      //Hiển thị loader trong khi tải danh mục
      isLoading.value = true;

      //Tim banner
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      //Assign Banner
      this.banners.assignAll(banners);

    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      //Remove Loader
      isLoading.value = false;
    }
  }
}