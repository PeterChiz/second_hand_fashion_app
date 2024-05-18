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
          () {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: cartItems.length,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: SHFSizes.spaceBtwSections),
          itemBuilder: (context, index) {
            return Obx(
                  () {
                final item = cartItems[index];
                return Column(
                  children: [
                    /// -- Các mặt hàng trong giỏ hàng
                    SHFCartItem(item: item),
                    if (showAddRemoveButtons) const SizedBox(height: SHFSizes.spaceBtwItems),

                    /// -- Nút Thêm và Bớt và Tổng giá
                    if (showAddRemoveButtons)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// -- Nút Thêm và Bớt
                          Row(
                            children: [
                              // Sử dụng để thêm không gian bên trái của nút làm hình ảnh.
                              const SizedBox(width: 70),

                              /// Nút Thêm và Bớt
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

                          /// -- Tổng giá sản phẩm
                          SHFProductPriceText(price: (item.price * item.quantity).toStringAsFixed(0)),
                        ],
                      )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
