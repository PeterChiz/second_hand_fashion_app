import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/icons/shf_circular_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/animation_loader.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/favorites_controller.dart';
import 'package:second_hand_fashion_app/features/shop/screens/home/home.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;
    return Scaffold(
      appBar: SHFAppBar(
        title: Text(
          'Danh sách yêu thích',
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
        actions: [
          SHFCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),

          ///Products Grid
          child: Obx(
            () => FutureBuilder(
                future: controller.favoriteProducts(),
                builder: (context, snapshot) {
                  ///Nothing Found Widget
                  final emptyWidget = SHFAnimationLoaderWidget(
                    text: 'Rất tiếc! Danh sách yêu thích không trống',
                    animation: SHFImages.pencilAnimation,
                    showAction: true,
                    actionText: 'Thêm một vài thứ vào',
                    onActionPressed: () => Get.off(() => const NavigationMenu()),);

                  const loader = SHFVerticalProductShimmer(itemCount: 6,);
                  final widget = SHFCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: emptyWidget);
                  if (widget != null) return widget;

                  final products = snapshot.data!;

                  return SHFGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) =>
                        SHFProductCardVertical(
                          product: products[index],
                        ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
