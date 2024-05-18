import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/address_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../../../../pertonalization/models/address_model.dart';

class SHFBillingAddressSection extends StatelessWidget {
  const SHFBillingAddressSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hiển thị tiêu đề địa chỉ giao hàng với nút thay đổi.
          SHFSectionHeading(
            title: 'Địa chỉ nhận hàng',
            buttonTitle: 'Thay đổi',
            showActionButton: true,
            onPressed: () => addressController.selectNewAddressPopup(context),
          ),
          // Kiểm tra nếu có địa chỉ được chọn, nếu đúng, hiển thị chi tiết địa chỉ; nếu không, yêu cầu chọn địa chỉ.
          addressController.selectedAddress.value.id.isNotEmpty
              ? _buildAddressDetails(
                  context, addressController.selectedAddress.value)
              : Text('Chọn địa chỉ',
                  style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  /// Xây dựng widget chi tiết địa chỉ.
  Widget _buildAddressDetails(
      BuildContext context, AddressModel selectedAddress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hiển thị tên của địa chỉ được chọn.
        Text(selectedAddress.name,
            style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: SHFSizes.spaceBtwItems / 2),
        Row(
          children: [
            // Hiển thị biểu tượng điện thoại sau đó là số điện thoại được định dạng.
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: SHFSizes.spaceBtwItems),
            Text(selectedAddress.formattedPhoneNo,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems / 2),
        Row(
          children: [
            // Hiển thị biểu tượng địa điểm sau đó là địa chỉ.
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: SHFSizes.spaceBtwItems),
            Expanded(
              child: Text(
                selectedAddress.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
