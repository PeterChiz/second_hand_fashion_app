import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:second_hand_fashion_app/features/shop/screens/checkout/checkout.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SHFAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(SHFSizes.defaultSpace),

        ///Item in Cart
        child: SHFCartItems(),
      ),

      ///Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SHFSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(()=> const CheckoutScreen()), child: const Text('Checkout \$256.0')),
      ),
    );
  }
}
