import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_circular_image.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../texts/shf_brand_title_text.dart';

/// A widget that displays an image with text below it in a vertical arrangement.
class SHFVerticalImageAndText extends StatelessWidget {
  /// Constructor for [SHFVerticalImageAndText].
  const SHFVerticalImageAndText({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.textColor = SHFColors.white,
  });

  /// The image asset path or URL.
  final String image;

  /// The text to be displayed below the image.
  final String title;

  /// The color of the text.
  final Color textColor;

  /// Flag indicating whether the image is loaded from the network.
  final bool isNetworkImage;

  /// The background color of the widget.
  final Color? backgroundColor;

  /// Callback function when the widget is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: SHFSizes.spaceBtwItems),
        child: Column(
          children: [
            ///Circular Icon
            Flexible(
              child: SHFCircularImage(
                image: image,
                fit: BoxFit.fitWidth,
                padding: SHFSizes.sm * 1.4,
                isNetworkImage: isNetworkImage,
                backgroundColor: backgroundColor,
                overlayColor: SHFHelperFunctions.isDarkMode(context)
                    ? SHFColors.light
                    : SHFColors.dark,
              ),
            ),

            ///Text
            const SizedBox(height: SHFSizes.spaceBtwItems / 2),
            SizedBox(width: 55, child: SHFBrandTitleText(title: title, color: textColor)),
          ],
        ),
      ),
    );
  }
}
