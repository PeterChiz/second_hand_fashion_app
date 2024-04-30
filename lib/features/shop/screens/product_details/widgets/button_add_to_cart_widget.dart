import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/icons/shf_circular_icon.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

class SHFBottomAddToCart extends StatelessWidget {
  const SHFBottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: SHFSizes.defaultSpace,
          vertical: SHFSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? SHFColors.darkerGrey : SHFColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(SHFSizes.cardRadiusLg),
            topRight: Radius.circular(SHFSizes.cardRadiusLg),
          )),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SHFCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: SHFColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: SHFColors.white,
                  onPressed: () => controller.productQuantityInCart.value < 1
                      ? null
                      : controller.productQuantityInCart.value -= 1,
                ),
                const SizedBox(width: SHFSizes.spaceBtwItems),
                Text(controller.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(width: SHFSizes.spaceBtwItems),
                SHFCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: SHFColors.black,
                  width: 40,
                  height: 40,
                  color: SHFColors.white,
                  onPressed: () => controller.productQuantityInCart += 1,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(SHFSizes.md),
                  backgroundColor: SHFColors.black,
                  side: const BorderSide(color: SHFColors.black)),
              child: const Text('Thêm vào giỏ hàng'),
            )
          ],
        ),
      ),
    );
  }
}
