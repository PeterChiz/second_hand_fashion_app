import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_price_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_title_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/variation_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());

    return Obx(
      () => Column(
        children: [
          ///Selected Attribute Pricing & Description
          ///Display variation price and stock when some variation is selected
          if (controller.selectedVariation.value.id.isNotEmpty)
            SHFRoundedContainer(
              padding: const EdgeInsets.all(SHFSizes.md),
              backgroundColor: dark ? SHFColors.darkGrey : SHFColors.grey,
              child: Column(
                children: [
                  ///Title, Price, Status
                  Row(
                    children: [
                      const SHFSectionHeading(
                        title: 'Validation',
                        showActionButton: false,
                      ),
                      const SizedBox(
                        width: SHFSizes.spaceBtwItems,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SHFProductTitleText(
                                title: 'Price: ',
                                smallSize: true,
                              ),

                              ///Actual Price
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '\$${controller.selectedVariation.value.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              const SizedBox(
                                width: SHFSizes.spaceBtwItems,
                              ),

                              ///Sale Price
                              SHFProductPriceText(
                                  price: controller.getVariationPrice()),
                            ],
                          ),

                          ///Stack
                          Row(
                            children: [
                              const SHFProductTitleText(
                                title: 'Tình trạng: ',
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),

                  ///Variation Description
                   SHFProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(
            height: SHFSizes.spaceBtwItems,
          ),

          ///Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SHFSectionHeading(
                            title: attribute.name ?? '',
                            showActionButton: false),
                        const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                        Obx(
                          () => Wrap(
                              spacing: 8,
                              children: attribute.values!.map((attributeValue) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.name] ==
                                    attributeValue;
                                final available = controller
                                    .getAttributesAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!)
                                    .contains(attributeValue);
                                return SHFChoiceChip(
                                    text: attributeValue,
                                    selected: isSelected,
                                    onSelected: available
                                        ? (selected) {
                                            if (selected && available) {
                                              controller.onAttributeSelected(
                                                  product,
                                                  attribute.name ?? '',
                                                  attributeValue);
                                            }
                                          }
                                        : null);
                              }).toList()),
                        )
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
