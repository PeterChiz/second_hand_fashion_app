import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_product_price_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_product_title_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/variation_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../../../../../common/widgets/chips/rounded_choice_chip.dart';

class SHFProductAttributes extends StatelessWidget {
  const SHFProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = VariationController.instance;
    controller.resetSelectedAttributes();
    return Obx(
          () => Column(
        children: [
          /// -- Selected Attribute Pricing & Description
          // Display variation price and stock when some variation is selected.
          if (controller.selectedVariation.value.id.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SHFSectionHeading(title: 'Mặt hàng: ', showActionButton: false),
                    const SizedBox(width: SHFSizes.spaceBtwItems),

                    /// Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Actual Price if sale price not null.
                            const SHFProductTitleText(title: 'Giá : ', smallSize: true),
                            if (controller.selectedVariation.value.salePrice > 0)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: SHFSizes.spaceBtwItems),
                                  Text(
                                    controller.selectedVariation.value.price.toString(),
                                    style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                                  ),
                                  const SizedBox(width: SHFSizes.spaceBtwItems)
                                ],
                              ),
                            // Sale Price if sale price not null Else Simple Price.
                            SHFProductPriceText(
                              price: controller.selectedVariation.value.salePrice > 0
                                  ? controller.selectedVariation.value.salePrice.toString()
                                  : controller.selectedVariation.value.price.toString(),
                            ),
                          ],
                        ),

                        /// Stock
                        Row(
                          children: [
                            const SHFProductTitleText(title: 'Số lượng : ', smallSize: true),
                            Text(controller.selectedVariation.value.stock.toString(), style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                /// Description
                SHFProductTitleText(
                  title: controller.selectedVariation.value.description.toString(),
                  smallSize: true,
                  maxLines: 4,
                ),
              ],
            ),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          /// -- Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
              // attribute = Product Single Attribute [Name: Color, Values: [Green, Blue, Orange]]
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SHFSectionHeading(title: attribute.name ?? '', showActionButton: false),
                const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                Obx(
                      () => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: attribute.values!.map((attributeValue) {
                      // attributeValue = Single Attribute Value [Green]
                      final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                      final available = controller
                          .getAttributesAvailabilityInVariation(product.productVariations!, attribute.name!)
                          .contains(attributeValue);

                      /// Attribute Chip
                      return SHFChoiceChip(
                        text: attributeValue,
                        selected: isSelected,
                        onSelected: available
                            ? (selected) {
                          if (selected && available) {
                            controller.onAttributeSelected(product, attribute.name ?? '', attributeValue);
                          }
                        }
                            : null,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: SHFSizes.spaceBtwItems),
              ],
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
