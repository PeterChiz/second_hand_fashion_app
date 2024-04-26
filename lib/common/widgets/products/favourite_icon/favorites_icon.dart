import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/icons/shf_circular_icon.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/favorites_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';

class SHFFavoritesIcon extends StatelessWidget {
  const SHFFavoritesIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Obx(() => SHFCircularIcon(
      icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
      color: controller.isFavorite(productId) ? SHFColors.error : null,
      onPressed: () => controller.toggleFavoriteProduct(productId),
    ));
  }
}
