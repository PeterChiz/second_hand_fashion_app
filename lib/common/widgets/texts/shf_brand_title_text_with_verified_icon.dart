import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_brand_title_text.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';

import '../../../utils/constants/sizes.dart';

class SHFBrandTitleWithVerifiedIcon extends StatelessWidget {
  const SHFBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines =1 ,
    this.textColor,
    this.iconColor = SHFColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TexSHFSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TexSHFSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child:SHFBrandTitleText(
              title: title,
              color: textColor,
              maxLines: maxLines,
              textAlign: textAlign,
              brandTextSize: brandTextSize,
            )
        ),
        const SizedBox(width: SHFSizes.xs),
        Icon(Iconsax.verify5, color: iconColor, size: SHFSizes.iconXs),
      ],
    );
  }
}
