import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/shop/screens/cart/cart.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';

class SHFCartCounterIcon extends StatelessWidget {
  const SHFCartCounterIcon({
    super.key,
    this.iconColor,
    required this.onPressed, this.counterBgColor, this.counterTextColor,
  });

  final Color? iconColor, counterBgColor, counterTextColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: const Icon(
              Iconsax.shopping_bag,
              color: SHFColors.white,
            )),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: counterBgColor ?? (dark ? SHFColors.white : SHFColors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text('2',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: counterTextColor, fontSizeFactor: 0.8)),
            ),
          ),
        ),
      ],
    );
  }
}
