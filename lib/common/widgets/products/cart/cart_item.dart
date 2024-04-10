import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/shf_rounded_image.dart';
import '../../texts/product_title_text.dart';
import '../../texts/shf_brand_title_text_with_verified_icon.dart';

class SHFCartItem extends StatelessWidget {
  const SHFCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///Image
        SHFRoundedImage(
          imageURL: SHFImages.productImage1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(SHFSizes.sm),
          backgroundColor:
          SHFHelperFunctions.isDarkMode(context)
              ? SHFColors.darkerGrey
              : SHFColors.light,
        ),
        const SizedBox(
          width: SHFSizes.spaceBtwItems,
        ),

        ///Title, Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SHFBrandTitleWithVerifiedIcon(title: 'Asus'),
              const Flexible(
                child: SHFProductTitleText(
                  title: 'DELL PRECISION 7770 I7 12850HX RAM 32GB SSD 512GB RTX A3000 12GB 17 INCH ĐỒ HỌA GIÁ RẺ',
                  maxLines: 1,
                ),
              ),

              ///Attributes
              Text.rich(TextSpan(children: [
                TextSpan(text: 'Color', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: 'Black', style: Theme.of(context).textTheme.labelLarge),
                TextSpan(text: 'Size', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(text: '8GB', style: Theme.of(context).textTheme.titleLarge),
              ]))
            ],
          ),
        )
      ],
    );
  }
}
