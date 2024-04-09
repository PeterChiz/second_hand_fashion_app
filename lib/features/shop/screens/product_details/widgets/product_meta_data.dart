import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_circular_image.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_price_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_title_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_brand_title_text_with_verified_icon.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SHFProductMetaData extends StatelessWidget {
  const SHFProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = SHFHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Price & Sale Price
        Row(
          children: [
            ///Sale tag
            SHFRoundedContainer(
                radius: SHFSizes.sm,
                backgroundColor: SHFColors.secondary.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                    horizontal: SHFSizes.sm, vertical: SHFSizes.xs),
                child: Text(
                  '25%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: SHFColors.black),
                )),
            ///Price
            Text('\$250', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
            const SizedBox(width: SHFSizes.spaceBtwItems,),
            const SHFProductPriceText(price: '175', isLarge: true),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems / 1.5,),
        ///Title
        const SHFProductTitleText(title: 'Green Nike Sports Shirt'),
        const SizedBox(height: SHFSizes.spaceBtwItems / 1.5),
        ///Stack Status
        Row(
          children: [
            const SHFProductTitleText(title: 'Status'),
            const SizedBox(width: SHFSizes.spaceBtwItems,),
            Text('In Stock',style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems / 1.5),

        ///Brand
        Row(
          children: [
            SHFCircularImage(image: SHFImages.cosmeticsIcon,
            width: 32,
              height: 32,
              overlayColor: darkMode ? SHFColors.white : SHFColors.black,
            ),
            const SHFBrandTitleWithVerifiedIcon(title: 'Icon', brandTextSize: TextSizes.medium,),

          ],
        )

      ],
    );
  }
}
