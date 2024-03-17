import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class SHFSocialButtons extends StatelessWidget {
  const SHFSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: SHFColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: SHFSizes.iconMd,
              height: SHFSizes.iconMd,
              image: AssetImage(SHFImages.google),
            ),
          ),
        ),
        const SizedBox(width: SHFSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: SHFColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: SHFSizes.iconMd,
              height: SHFSizes.iconMd,
              image: AssetImage(SHFImages.facebook),
            ),
          ),
        ),
      ],
    );
  }
}
