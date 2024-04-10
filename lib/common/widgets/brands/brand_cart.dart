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
    super.key, required this.showBorder, this.onTap,
  });
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      ///Container Design
      child: SHFRoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(SHFSizes.sm),
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
            // [Expanded] & Colum [MainAxisSize.min] rất quan trọng
            // dùng để giữ phần tử ở giữa theo chiều dọc và cũng để giữ văn bản bên trong các ranh giới
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
