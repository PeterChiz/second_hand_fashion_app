import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/pricing_calculator.dart';

/// Widget hiển thị phần tổng thanh toán bao gồm tiền hàng, phí vận chuyển, thuế và tổng cộng.
class SHFBillingAmountSection extends StatelessWidget {
  const SHFBillingAmountSection({super.key, required this.subTotal, required this.addressCity});

  final double subTotal;
  final String addressCity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Tiền hàng (tạm tính)
        Row(
          children: [
            Expanded(
                child: Text(
                  'Tiền hàng (tạm tính)',
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Text(
              '${subTotal.toStringAsFixed(0)}đ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems / 2),

        ///Phí vận chuyển
        Row(
          children: [
            Expanded(
                child: Text(
                  'Phí vận chuyển',
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Text(
              '${SHFPricingCalculator.calculateShippingCost(subTotal, addressCity)}đ',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems / 2),

        ///Thuế (VAT)
        Row(
          children: [
            Expanded(
                child: Text(
                  'Thuế (VAT 10%)',
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Text(
              '${SHFPricingCalculator.calculateTax(subTotal)}đ',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(
          height: SHFSizes.spaceBtwItems / 2,
        ),

        ///Tổng cộng
        Row(
          children: [
            Expanded(
                child: Text(
                  'Tổng cộng',
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            Text(
              '${SHFPricingCalculator.calculateTotalPrice(subTotal, addressCity)}đ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        )
      ],
    );
  }
}
