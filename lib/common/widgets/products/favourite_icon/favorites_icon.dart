import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/icons/shf_circular_icon.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/favorites_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';

class SHFFavoritesIcon extends StatelessWidget {
  /// A custom Icon widget which handles its own logic to add or remove products from the Wishlist.
  /// You just have to call this widget on your design and pass a product id.
  ///
  /// It will auto do the logic defined in this widget.
  const SHFFavoritesIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Obx(() => SHFCircularIcon(
      icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
      color: controller.isFavourite(productId) ? SHFColors.error : null,
      onPressed: () => controller.toggleFavoriteProduct(productId),
    ));
  }
}
