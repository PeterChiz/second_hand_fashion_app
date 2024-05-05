import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/address_controller.dart';
import 'package:second_hand_fashion_app/features/pertonalization/models/address_model.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

class SHFSingAddress extends StatelessWidget {
  const SHFSingAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final isAddressSelected = selectedAddressId == address.id;
        return GestureDetector(
          onTap: onTap,
          child: SHFRoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(SHFSizes.md),
            width: double.infinity,
            backgroundColor: isAddressSelected
                ? SHFColors.primary.withOpacity(0.5)
                : Colors.transparent,
            borderColor: isAddressSelected
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
                    isAddressSelected
                        ? Iconsax.tick_circle1
                        : Iconsax.tick_circle1,
                    color: isAddressSelected
                        ? SHFColors.primary
                        : dark
                            ? SHFColors.darkerGrey
                            : SHFColors.grey,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: SHFSizes.sm / 2),
                    Text(address.formattedPhoneNo,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: SHFSizes.sm / 2),
                    Text(address.toString(), softWrap: true),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
