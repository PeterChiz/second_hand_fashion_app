import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class SHFCartItems extends StatelessWidget {
  const SHFCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
          shrinkWrap: true,
          itemCount: cartController.cartItems.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: SHFSizes.spaceBtwSections),
          itemBuilder: (_, index) => Obx(() {
                final item = cartController.cartItems[index];
                return Column(
                  children: [
                    ///Cart item
                    SHFCartItem(cartItem: item),
                    if (showAddRemoveButtons)
                      const SizedBox(height: SHFSizes.spaceBtwItems),

                    ///Add, Remove Button Row with total Price
                    if (showAddRemoveButtons)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ///Extra Space
                              const SizedBox(width: 70),

                              ///Add, Remove Buttons
                              SHFProductQualityWithAddRemoveButton(
                                quantity: item.quantity,
                                add: () => cartController.addOneToCart(item),
                                remove: () =>
                                    cartController.removeOneFromCart(item),
                              )
                            ],
                          ),

                          ///Product total price
                          SHFProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                        ],
                      ),
                  ],
                );
              })),
    );
  }
}
