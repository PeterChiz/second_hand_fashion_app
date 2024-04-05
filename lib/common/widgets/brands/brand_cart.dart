import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/shf_circular_image.dart';
import '../texts/shf_brand_title_text_with_verified_icon.dart';

class SHFBrandCard extends StatelessWidget {
  const SHFBrandCard({
    super.key, required this.showBorder,
  });
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SHFRoundedContainer(
        padding: const EdgeInsets.all(SHFSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [

            ///Icon
            Flexible(

              child: SHFCircularImage(
                isNetworkImage: false,
                image: SHFImages.clothIcon,
                backgroundColor: Colors.transparent,
                overlayColor:
                SHFHelperFunctions.isDarkMode(context)
                    ? SHFColors.white
                    : SHFColors.black,
              ),
            ),
            const SizedBox(
              height: SHFSizes.spaceBtwItems / 2,
            ),

            ///Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const SHFBrandTitleWithVerifiedIcon(
                    title: 'Nike',
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '256 product',
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
