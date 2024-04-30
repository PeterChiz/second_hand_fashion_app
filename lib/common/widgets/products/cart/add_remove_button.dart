import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/shf_circular_icon.dart';

class SHFProductQualityWithAddRemoveButton extends StatelessWidget {
  const SHFProductQualityWithAddRemoveButton({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SHFCircularIcon(
            icon: Iconsax.minus,
            width: 32,
            height: 32,
            size: SHFSizes.md,
            color: SHFHelperFunctions.isDarkMode(context)
                ? SHFColors.white
                : SHFColors.black,
            backgroundColor: SHFHelperFunctions.isDarkMode(context)
                ? SHFColors.darkerGrey
                : SHFColors.light,
            onPressed: remove,
        ),
        const SizedBox(width: SHFSizes.spaceBtwItems),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(width: SHFSizes.spaceBtwItems),
        SHFCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: SHFSizes.md,
          color: SHFColors.white,
          backgroundColor: SHFColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
