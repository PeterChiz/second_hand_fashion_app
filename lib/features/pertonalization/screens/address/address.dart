import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/address_controller.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/address/add_new_address.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/address/widgets/single_address.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    return Scaffold(
      appBar: SHFAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                //Sử dụng phím để kích hoạt làm mới
                key: Key(controller.refreshData.value.toString()),
                future: controller.getAllUserAddresses(),
                builder: (context, snapshot) {
                  final response =
                      SHFCloudHelperFunctions.checkMultiRecordState(
                          snapshot: snapshot);
                  if (response != null) return response;

                  final addresses = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: addresses.length,
                    itemBuilder: (_, index) => SHFSingAddress(
                      address: addresses[index],
                      onTap: () => controller.selectAddress(addresses[index]),
                    ),
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SHFColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(
          Iconsax.add,
          color: SHFColors.white,
        ),
      ),
    );
  }
}
