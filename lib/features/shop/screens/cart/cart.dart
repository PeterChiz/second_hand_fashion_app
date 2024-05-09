import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/animation_loader.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';
import 'package:second_hand_fashion_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:second_hand_fashion_app/features/shop/screens/checkout/checkout.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final cartItems = controller.cartItems;
    return Scaffold(
      /// -- AppBar
      appBar: SHFAppBar(showBackArrow: true, title: Text('Giỏ hàng', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(() {
        /// Khong tim thay mat hang nao
        final emptyWidget = SHFAnimationLoaderWidget(
          text: 'Bạn chưa thêm gì vào giỏ hàng',
          animation: SHFImages.cartAnimation,
          showAction: true,
          actionText: 'Mua sắm thôi nào!',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        /// Cart Items
        return cartItems.isEmpty
            ? emptyWidget
            : const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SHFSizes.defaultSpace),

            /// -- nhung item trong gio hang
            child: SHFCartItems(),
          ),
        );
      }),

      /// -- Checkout Button
      bottomNavigationBar: Obx(
            () {
          return cartItems.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.all(SHFSizes.defaultSpace),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(() => Text('Thanh toán ${controller.totalCartPrice.value}')),
              ),
            ),
          )
              : const SizedBox();
        },
      ),
    );
  }
}

