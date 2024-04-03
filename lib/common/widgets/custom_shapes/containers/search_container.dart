import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SHFSearchContainer extends StatelessWidget {
  const SHFSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,

  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    final dark = SHFHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SHFSizes.defaultSpace),
        child: Container(
          width: SHFDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(SHFSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                ? SHFColors.dark
                : SHFColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(SHFSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: SHFColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: SHFColors.darkGrey,
              ),
              const SizedBox(
                width: SHFSizes.spaceBtwItems,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
