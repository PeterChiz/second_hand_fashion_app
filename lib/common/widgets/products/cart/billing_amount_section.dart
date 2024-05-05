import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/pricing_calculator.dart';

class SHFBillingAmountSection extends StatelessWidget {
  const SHFBillingAmountSection({super.key, required this.subTotal});

  final double subTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///SubTotal
        Row(
          children: [
            Expanded(
                child: Text(
              'Tiền hàng (tạm tính)',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '\$${subTotal.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems / 2),

        ///Shipping Fee
        Row(
          children: [
            Expanded(
                child: Text(
              'Phí vận chuyển',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '\$${SHFPricingCalculator.calculateShippingCost(subTotal, '79')}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems / 2),

        ///Tax Fee
        Row(
          children: [
            Expanded(
                child: Text(
              'Thuế (VAT)',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '\$${SHFPricingCalculator.calculateTax(subTotal, '79')}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(
          height: SHFSizes.spaceBtwItems / 2,
        ),

        ///Order Total
        Row(
          children: [
            Expanded(
                child: Text(
              'Tổng cộng',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '\$${SHFPricingCalculator.calculateTotalPrice(subTotal, '79').toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        )
      ],
    );
  }
}
