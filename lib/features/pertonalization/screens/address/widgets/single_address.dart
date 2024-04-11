import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

class SHFSingAddress extends StatelessWidget {
  const SHFSingAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return SHFRoundedContainer(
      padding: const EdgeInsets.all(SHFSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress
          ? SHFColors.primary.withOpacity(0.6)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? SHFColors.darkerGrey
              : SHFColors.grey,
      margin: const EdgeInsets.only(bottom: SHFSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle5 : null,
              color: selectedAddress
                  ? dark
                      ? SHFColors.light
                      : SHFColors.dark
                  : null,
            ),
          ),
          Column(
            children: [
              Text(
                'Bùi Thiện Chí',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: SHFSizes.sm / 2,
              ),
              const Text(
                '0773872129',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: SHFSizes.sm / 2,
              ),
              const Text(
                'Thôn Phước Lợi, xã Phước Đồng, Thành Phố Nha Trang, Tỉnh Khánh Hòa',
                softWrap: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
