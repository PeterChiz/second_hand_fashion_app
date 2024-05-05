import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';

import '../../../../../common/widgets/products/cart/add_remove_cart_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/shf_product_price_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SHFCartItems extends StatelessWidget {
  const SHFCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final cartItems = cartController.cartItems;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartItems.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) =>
            const SizedBox(height: SHFSizes.spaceBtwSections),
        itemBuilder: (context, index) {
          return Obx(
                () {
              final item = cartItems[index];
              return Column(
                children: [
                  /// -- Cart Items
                  SHFCartItem(item: item),
                  if (showAddRemoveButtons) const SizedBox(height: SHFSizes.spaceBtwItems),

                  /// -- Add Remove Buttons and Price Total
                  if (showAddRemoveButtons)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// -- Add Remove Buttons
                        Row(
                          children: [
                            // Use to add space to the left of Buttons as image space.
                            const SizedBox(width: 70),

                            /// Add Remove Buttons
                            SHFProductQuantityWithAddRemoveButton(
                              width: 32,
                              height: 32,
                              iconSize: SHFSizes.md,
                              addBackgroundColor: SHFColors.primary,
                              removeForegroundColor: SHFHelperFunctions.isDarkMode(context) ? SHFColors.white : SHFColors.black,
                              removeBackgroundColor: SHFHelperFunctions.isDarkMode(context) ? SHFColors.darkerGrey : SHFColors.light,
                              quantity: item.quantity,
                              add: () => cartController.addOneToCart(item),
                              remove: () => cartController.removeOneFromCart(item),
                            ),
                          ],
                        ),

                        /// -- Product total price
                        SHFProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                      ],
                    )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
