import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';
import 'package:second_hand_fashion_app/features/shop/screens/cart/cart.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

/// Custom widget for the cart counter icon
class SHFCartCounterIcon extends StatelessWidget {
  const SHFCartCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    // Get an instance of the CartController
    final controller = Get.put(CartController());

    // Check if the app is in dark mode
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        // IconButton for navigating to the CartScreen
        IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: Icon(Iconsax.shopping_bag, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
            width: SHFSizes.fontSizeLg,
            height: SHFSizes.fontSizeLg,
            decoration: BoxDecoration(
              color:
                  counterBgColor ?? (dark ? SHFColors.white : SHFColors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () => Text(controller.noOfCartItems.value.toString(),
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: counterTextColor ??
                            (dark ? SHFColors.black : SHFColors.white),
                        fontSizeFactor: 0.8)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
