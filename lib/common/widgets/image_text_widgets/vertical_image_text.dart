import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_circular_image.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class SHFVerticalImageText extends StatelessWidget {
  const SHFVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = SHFColors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: SHFSizes.spaceBtwItems),
        child: Column(
          children: [

            ///Circular Icon
            SHFCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: SHFSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: SHFHelperFunctions.isDarkMode(context) ? SHFColors
                  .light : SHFColors.dark,),

            ///Text
            const SizedBox(
              height: SHFSizes.spaceBtwItems / 2,
            ),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
