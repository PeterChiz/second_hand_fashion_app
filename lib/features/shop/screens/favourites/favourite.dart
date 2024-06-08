import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/features/shop/screens/home/home.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/icons/shf_circular_icon.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/product/favorites_controller.dart';
import '../store/store.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // Chặn việc nhấn nút quay lại và chuyển hướng đến Màn hình chính
      onPopInvoked: (value) async => Get.offAll(const NavigationMenu()),
      child: Scaffold(
        appBar: SHFAppBar(
          title: Text('Danh sách yêu thích', style: Theme.of(context).textTheme.headlineMedium),
          actions: [SHFCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(() => const StoreScreen()))],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SHFSizes.defaultSpace),
            child: Column(
              children: [
                const SizedBox(height: SHFSizes.productImageSize),
                /// Products Grid
                Obx(() {
                  return FutureBuilder(
                    future: FavoritesController.instance.favoriteProducts(),
                    builder: (_, snapshot) {
                      /// Khong tim thay widget
                      final emptyWidget = SHFAnimationLoaderWidget(
                        text: 'Rất tiết, danh sách yêu thích trống...',
                        animation: SHFImages.productsAnimation,
                        showAction: true,
                        actionText: 'Thêm sản phẩm yêu thích',
                        onActionPressed: () => Get.off(() => const HomeScreen()),
                      );
                      const loader = SHFVerticalProductShimmer(itemCount: 6);
                      final widget = SHFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
                      if (widget != null) return widget;

                      final products = snapshot.data!;
                      return SHFGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) => SHFProductCardVertical(product: products[index]),
                      );
                    },
                  );
                }),
                SizedBox(height: SHFDeviceUtils.getBottomNavigationBarHeight() + SHFSizes.defaultSpace),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
