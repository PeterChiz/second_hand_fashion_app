import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/address_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      appBar: const SHFAppBar(
        showBackArrow: true,
        title: Text('Thêm địa chỉ mới'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Form(
            key:  controller.addressFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller.name,
                validator: (value) => SHFValidator.validationEmptyText('Tên', value),
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Tên'),
              ),
              const SizedBox(
                height: SHFSizes.spaceBtwInputFields,
              ),
              TextFormField(
                controller: controller.phoneNumber,
                validator: SHFValidator.validatePhoneNumber,
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Số điện thoại'),
              ),
              const SizedBox(
                height: SHFSizes.spaceBtwInputFields,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.street,
                      validator: (value) => SHFValidator.validationEmptyText('Địa chỉ', value),
                      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Địa chỉ',),
                    ),
                  ),
                  const SizedBox(
                    width: SHFSizes.spaceBtwInputFields,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.postalCode,
                      validator: (value) => SHFValidator.validationEmptyText('Mã bưu điện', value),
                      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Mã bưu điện',),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: SHFSizes.spaceBtwInputFields,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.city,
                      validator: (value) => SHFValidator.validationEmptyText('Thành phố', value ),
                      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'Thành phố',),
                      expands: false,
                    ),
                  ),
                  const SizedBox(
                    width: SHFSizes.spaceBtwInputFields,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.state,
                      validator: (value) => SHFValidator.validationEmptyText('Tình trạng', value),
                      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'Tình trạng',),
                      expands: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwInputFields,),
              TextFormField(
                controller: controller.country,
                validator: (value) => SHFValidator.validationEmptyText('Quốc gia', value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.global),
                  labelText: 'Quốc gia',
                ),
              ),
              const SizedBox(height: SHFSizes.spaceBtwInputFields,),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.addNewAddress(), child: const Text('Lưu'),),)
            ],
          )),
        ),
      ),
    );
  }
}
