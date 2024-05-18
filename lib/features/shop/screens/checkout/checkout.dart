import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/features/pertonalization/models/address_model.dart';
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
import '../../../pertonalization/controllers/address_controller.dart';
import '../../controllers/product/orderController.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final AddressModel addressModel =
        AddressController.instance.selectedAddress.value;
    final totalAmount =
    SHFPricingCalculator.calculateTotalPrice(subTotal, addressModel.city);
    final dark = SHFHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const SHFAppBar(title: Text('Thanh toán'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// -- Các mặt hàng trong giỏ hàng
              const SHFCartItems(showAddRemoveButtons: false),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              /// -- Phần thanh toán
              SHFRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(SHFSizes.md),
                backgroundColor: dark ? SHFColors.black : SHFColors.white,
                child: Column(
                  children: [
                    /// Giá sản phẩm
                    SHFBillingAmountSection(
                      subTotal: subTotal,
                      addressCity: addressModel.city,
                    ),
                    const SizedBox(height: SHFSizes.spaceBtwItems),

                    /// Đường phân cách
                    const Divider(),
                    const SizedBox(height: SHFSizes.spaceBtwItems),

                    /// Phương thức thanh toán
                    const SHFBillingPaymentSection(),
                    const SizedBox(height: SHFSizes.spaceBtwSections),

                    /// Địa chỉ
                    const SHFBillingAddressSection(),
                  ],
                ),
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),
            ],
          ),
        ),
      ),

      /// -- Nút Thanh toán
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SHFSizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: subTotal > 0
                ? () => orderController.processOrder(totalAmount)
                : () => SHFLoaders.warningSnackBar(
                title: 'Giỏ hàng trống', message: 'Tiếp tục mua sắm nào!'),
            child: Text('Thanh toán ${totalAmount.toStringAsFixed(0)}đ'),
          ),
        ),
      ),
    );
  }
}
