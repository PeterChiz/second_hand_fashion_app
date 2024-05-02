import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/address_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class SHFBillingAddressSection extends StatelessWidget {
  const SHFBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SHFSectionHeading(
            title: 'Địa chỉ vận chuyển',
            buttonTitle: 'Thay đổi',
            onPressed: () => addressController.selectNewAddressPopup(context)),
        addressController.selectedAddress.value.id.isNotEmpty
            ? Column(
                children: [
                  Text('Bùi Thiện Chí',
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: SHFSizes.spaceBtwItems),
                      Text('0773872129',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_history,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: SHFSizes.spaceBtwItems),
                      Text('Thôn Phước Lợi, xã Phước Đồng',
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true),
                    ],
                  ),
                ],
              )
            : Text('Chọn địa chỉ', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
