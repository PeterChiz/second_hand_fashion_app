
import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_price_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_title_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ///Selected Attribute Pricing & Description
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
                    children: [
                      Row(
                        children: [
                          const SHFProductTitleText(
                            title: 'Price: ',
                            smallSize: true,
                          ),

                          ///Actual Price
                          Text(
                            '\$25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: SHFSizes.spaceBtwItems,
                          ),

                          ///Sale Price
                          const SHFProductPriceText(price: '20'),
                        ],
                      ),

                      ///Stack
                      Row(
                        children: [
                          const SHFProductTitleText(
                            title: 'Stock: ',
                            smallSize: true,
                          ),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),

              ///Variation Description
              const SHFProductTitleText(
                title:
                    'This is the description of the Product and it can go up to max 4 lines. ',
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
          children: [
            const SHFSectionHeading(title: 'Colors'),
            const SizedBox(height: SHFSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                SHFChoiceChip(text: 'Green', selected: false, onSelected: (value){}, ),
                SHFChoiceChip(text: 'Yellow', selected: false, onSelected: (value){} ),
                SHFChoiceChip(text: 'Red', selected: true, onSelected: (value){}),
                //....                 SHFChoiceChip(text: 'Red', selected: true, onSelected: (value){}),
              ],
            )
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SHFSectionHeading(title: 'Size'),
            const SizedBox(height: SHFSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                SHFChoiceChip(text: 'EU 34', selected: true ,onSelected: (value){}),
                SHFChoiceChip(text: 'EU 36', selected: false,onSelected: (value){} ),
                SHFChoiceChip(text: 'EU 38', selected: false,onSelected: (value){}),
                //more                 SHFChoiceChip(text: 'EU 36', selected: false,onSelected: (value){} ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

