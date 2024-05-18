import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/icons/shf_circular_icon.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/favorites_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';

class SHFFavoritesIcon extends StatelessWidget {
  /// Widget biểu tượng tùy chỉnh xử lý logic của riêng mình để thêm hoặc xóa sản phẩm khỏi danh sách yêu thích.
  /// Bạn chỉ cần gọi widget này trong thiết kế của bạn và truyền vào một id sản phẩm.
  ///
  /// Nó sẽ tự động thực hiện logic được xác định trong widget này.
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

