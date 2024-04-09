import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/icons/shf_circular_icon.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

class SHFBottomAddToCart extends StatelessWidget {
  const SHFBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Container(

      padding: const EdgeInsets.symmetric(
          horizontal: SHFSizes.defaultSpace,
          vertical: SHFSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? SHFColors.darkerGrey : SHFColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(SHFSizes.cardRadiusLg),
            topRight: Radius.circular(SHFSizes.cardRadiusLg),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SHFCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: SHFColors.darkGrey,
                width: 40,
                height: 40,
                color: SHFColors.white,
              ),
              const SizedBox(
                width: SHFSizes.spaceBtwItems,
              ),
              Text(
                '1',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                width: SHFSizes.spaceBtwItems,
              ),
              const SHFCircularIcon(
                icon: Iconsax.add,
                backgroundColor: SHFColors.black,
                width: 40,
                height: 40,
                color: SHFColors.white,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(SHFSizes.md),
                backgroundColor: SHFColors.black,
                side: const BorderSide(color: SHFColors.black)),
            child: const Text('Add to Cart'),
          )
        ],
      ),
    );
  }
}
