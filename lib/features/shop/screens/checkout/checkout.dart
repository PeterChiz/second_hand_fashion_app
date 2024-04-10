import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/products/cart/cart_item.dart';
import 'package:second_hand_fashion_app/common/widgets/success_screen/success_screen.dart';
import 'package:second_hand_fashion_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:second_hand_fashion_app/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:second_hand_fashion_app/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:second_hand_fashion_app/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: SHFAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              ///Item in Cart
              const SHFCartItems(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: SHFSizes.spaceBtwSections,
              ),

              ///Coupon TextField
              SHFCouponCode(),
              const SizedBox(
                height: SHFSizes.spaceBtwSections,
              ),

              ///Billing Section
              SHFRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(SHFSizes.md),
                backgroundColor: dark ? SHFColors.black : SHFColors.white,
                child: const Column(
                  children: [
                    ///Pricing
                    SHFBillingAmountSection(),
                    SizedBox(
                      height: SHFSizes.spaceBtwItems,
                    ),

                    ///Driver
                    Divider(),
                    SizedBox(
                      height: SHFSizes.spaceBtwItems,
                    ),

                    ///Payment Method
                    SHFBillingPaymentSection(),
                    SizedBox(
                      height: SHFSizes.spaceBtwItems,
                    ),

                    ///Address
                    SHFBillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      ///Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SHFSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(
                  () => SuccessScreen(
                    image: SHFImages.successfulPaymentIcon,
                    title: 'Payment Success!',
                    subTitle: 'Your item will be shipped soon',
                    onPressed: () => Get.offAll(() => const NavigationMenu()),
                  ),
                ),
            child: const Text('Checkout \$256.0')),
      ),
    );
  }
}
