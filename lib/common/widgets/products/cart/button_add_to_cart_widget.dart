import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import 'add_remove_cart_button.dart';

/// Widget hiển thị phần chức năng thêm vào giỏ hàng ở phía dưới.
class SHFBottomAddToCart extends StatelessWidget {
  const SHFBottomAddToCart({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = SHFHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: SHFSizes.defaultSpace, vertical: SHFSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? SHFColors.darkerGrey : SHFColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(SHFSizes.cardRadiusLg),
          topRight: Radius.circular(SHFSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
            () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Các nút biểu tượng Thêm hoặc Xóa sản phẩm khỏi giỏ hàng
            SHFProductQuantityWithAddRemoveButton(
              quantity: controller.productQuantityInCart.value,
              add: () => controller.productQuantityInCart.value += 1,
              // Vô hiệu hóa xóa khi số lượng trong giỏ hàng ít hơn 1
              remove: () => controller.productQuantityInCart.value < 1 ? null : controller.productQuantityInCart.value -= 1,
            ),
            // Nút Thêm vào giỏ hàng
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1 ? null : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(SHFSizes.md),
                backgroundColor: SHFColors.black,
                side: const BorderSide(color: SHFColors.black),
              ),
              child: const Row(
                children: [Icon(Iconsax.shopping_bag), SizedBox(width: SHFSizes.spaceBtwItems / 2), Text('Thêm vào giỏ hàng')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
