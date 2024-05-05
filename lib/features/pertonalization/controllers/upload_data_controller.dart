
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../data/repositories/banners/banner_repository.dart';
import '../../../data/repositories/brands/brand_repository.dart';
import '../../../data/repositories/categories/category_repository.dart';
import '../../../data/repositories/product/product_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loader.dart';
import '../../shop/controllers/brand_controller.dart';
import '../../shop/controllers/category_controller.dart';
import '../../shop/controllers/dummy_data.dart';
import '../../shop/controllers/product/banner_controller.dart';
import '../../shop/controllers/product/poduct_controller.dart';

class UploadDataController extends GetxController {
  static UploadDataController get instance => Get.find();

  Future<void> uploadCategories() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      SHFFullScreenLoader.openLoadingDialog('Sit Tight! Your CATEGORIES are uploading...', SHFImages.cloudUploadingAnimation);

      final controller = Get.put(CategoryRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadDummyData(SHFDummyData.categories);

      // Re-fetch latest Categories
      await CategoryController.instance.fetchCategories();

      SHFLoaders.successSnackBar(title: 'Congratulations', message: 'All Categories Uploaded Successfully.');
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      SHFFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadProductCategories() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      SHFFullScreenLoader.openLoadingDialog(
        'Sit Tight! Your PRODUCT CATEGORIES relationship is uploading...',
        SHFImages.cloudUploadingAnimation,
      );

      final controller = Get.put(CategoryRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadProductCategoryDummyData(SHFDummyData.productCategories);

      SHFLoaders.successSnackBar(title: 'Congratulations', message: 'All Categories Uploaded Successfully.');
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      SHFFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadBrands() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      SHFFullScreenLoader.openLoadingDialog('Sit Tight! Your BRANDS are uploading...', SHFImages.cloudUploadingAnimation);

      final controller = Get.put(BrandRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadDummyData(SHFDummyData.brands);

      // Re-fetch latest Brands
      final brandController = Get.put(BrandController());
      await brandController.getFeaturedBrands();

      SHFLoaders.successSnackBar(title: 'Congratulations', message: 'All Brands Uploaded Successfully.');
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      SHFFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadBrandCategory() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      SHFFullScreenLoader.openLoadingDialog(
        'Sit Tight! Your BRANDS & CATEGORIES relationship is uploading...',
        SHFImages.cloudUploadingAnimation,
      );

      final controller = Get.put(BrandRepository());

      // Upload All Categories and replace the Parent IDs in Firebase Console
      await controller.uploadBrandCategoryDummyData(SHFDummyData.brandCategory);

      SHFLoaders.successSnackBar(title: 'Congratulations', message: 'All Brands Uploaded Successfully.');
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      SHFFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadProducts() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      SHFFullScreenLoader.openLoadingDialog(
        'Sit Tight! Your Products are uploading. It may take a while...',
        SHFImages.cloudUploadingAnimation,
      );

      final controller = Get.put(ProductRepository());

      // Upload All Products and replace the Parent IDs in Firebase Console
      await controller.uploadDummyData(SHFDummyData.products);

      // Re-fetch latest Featured Products
      ProductController.instance.fetchFeaturedProducts();

      SHFLoaders.successSnackBar(title: 'Congratulations', message: 'All Products Uploaded Successfully.');
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      SHFFullScreenLoader.stopLoading();
    }
  }

  Future<void> uploadBanners() async {
    try {
      // The following line will enable the Android and iOS wakelock.
      WakelockPlus.enable();

      SHFFullScreenLoader.openLoadingDialog('Sit Tight! Your Banners are uploading. It may take a while...', SHFImages.cloudUploadingAnimation);

      final controller = Get.put(BannerRepository());

      // Upload All Products and replace the Parent IDs in Firebase Console
      await controller.uploadBannersDummyData(SHFDummyData.banners);

      // Re-fetch latest Banners
      final bannerController = Get.put(BannerController());
      await bannerController.fetchBanners();

      SHFLoaders.successSnackBar(title: 'Congratulations', message: 'All Products Uploaded Successfully.');
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // The next line disables the wakelock again.
      WakelockPlus.disable();
      SHFFullScreenLoader.stopLoading();
    }
  }
}
