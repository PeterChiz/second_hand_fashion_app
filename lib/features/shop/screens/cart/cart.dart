import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/icons/shf_circular_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_rounded_image.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_price_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_title_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_brand_title_text_with_verified_icon.dart';
import 'package:second_hand_fashion_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:second_hand_fashion_app/features/shop/screens/checkout/checkout.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';

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
