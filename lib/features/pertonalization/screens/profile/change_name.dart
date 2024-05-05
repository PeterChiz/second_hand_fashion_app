import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/constants/text_strings.dart';
import 'package:second_hand_fashion_app/utils/validators/validation.dart';

import '../../controllers/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      ///Custom Appbar
      appBar: SHFAppBar(
        showBackArrow: true,
        title: Text(
          'Thay đổi tên',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(SHFSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Headings
            Text(
              'Sử dụng tên thật để dễ dàng xác minh.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: SHFSizes.spaceBtwSections,
            ),

            ///Text field and Button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => SHFValidator.validationEmptyText(
                        'Họ và tên lót', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: SHFTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                  const SizedBox(
                    height: SHFSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => SHFValidator.validationEmptyText(
                        'Tên', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: SHFTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: SHFSizes.spaceBtwSections,
            ),

            ///Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text('Lưu'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
