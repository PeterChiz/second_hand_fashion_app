import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';
import 'package:second_hand_fashion_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:second_hand_fashion_app/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:second_hand_fashion_app/common/widgets/products/cart/billing_amount_section.dart';
import 'package:second_hand_fashion_app/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';
import 'package:second_hand_fashion_app/utils/helpers/pricing_calculator.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../controllers/product/orderController.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = SHFPricingCalculator.calculateTotalPrice(subTotal, 'US');
    final dark = SHFHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: SHFAppBar(
        showBackArrow: true,
        title: Text('Đánh giá đơn hàng',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///Item in Cart
              const SHFCartItems(showAddRemoveButtons: false),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              ///Coupon TextField
              const SHFCouponCode(),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              ///Billing Section
              SHFRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(SHFSizes.md),
                backgroundColor: dark ? SHFColors.black : SHFColors.white,
                child:  Column(
                  children: <Widget>[
                    ///Pricing
                    SHFBillingAmountSection(subTotal: subTotal),
                    const SizedBox(height: SHFSizes.spaceBtwItems),

                    ///Driver
                    const Divider(),
                    const SizedBox(height: SHFSizes.spaceBtwItems),

                    ///Payment Method
                    const SHFBillingPaymentSection(),
                    const SizedBox(height: SHFSizes.spaceBtwItems),

                    ///Address
                    const SHFBillingAddressSection(),
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
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: subTotal > 0
                  ? () => orderController.processOrder(totalAmount)
                  : () =>  SHFLoaders.warningSnackBar(title: 'Giỏ hàng trống', message: 'Thêm mặt hàng vào giỏ hàng để tiếp tục.'),
              child: Text(
                  'Thanh toán \$${totalAmount.toStringAsFixed(2)}')),
        ),
      ),
    );
  }
}
