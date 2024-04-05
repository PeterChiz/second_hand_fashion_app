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
    this.padding =
        const EdgeInsets.symmetric(horizontal: SHFSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
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
                color: dark ? SHFColors.darkGrey : SHFColors.grey,
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
