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
  const SHFSingAddress(
      {super.key, required this.address, required this.onTap,});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    final controller = AddressController.instance;
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: SHFRoundedContainer(
          padding: const EdgeInsets.all(SHFSizes.md),
          width: double.infinity,
          showBorder: true,
          backgroundColor: selectedAddress
              ? SHFColors.primary.withOpacity(0.5)
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const SizedBox(
                    height: SHFSizes.sm / 2,
                  ),
                  Text(
                    address.formattedPhoneNo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: SHFSizes.sm / 2,
                  ),
                   Text(
                    address.toString(), softWrap: true,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    );
  }
}
