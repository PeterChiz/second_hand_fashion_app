import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/pricing_calculator.dart';

class SHFBillingAmountSection extends StatelessWidget {
  const SHFBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        ///SubTotal
        Row(
          children: [
            Expanded(child: Text('Tiền hàng (tạm tính)', style: Theme.of(context).textTheme.bodyMedium,)),
            Text('\$$subTotal', style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems /2,),

        ///Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí vận chuyển', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${SHFPricingCalculator.calculateShippingCost(subTotal, '79')}', style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems /2,),

        ///Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Thuế (VAT)', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${SHFPricingCalculator.calculateTax(subTotal, '79')}', style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems /2,),

        ///Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng cộng', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\$${SHFPricingCalculator.calculateTotalPrice(subTotal, '79')}', style: Theme.of(context).textTheme.titleMedium,),
          ],
        )
      ],
    );
  }
}
