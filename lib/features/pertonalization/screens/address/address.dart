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

import '../../../../common/widgets/loaders/circular_loader.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
      appBar: SHFAppBar(
        showBackArrow: true,
        title: Text(
          'Địa chỉ',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(SHFSizes.defaultSpace),
        child: Obx(
          () => FutureBuilder(
              //Sử dụng phím để kích hoạt làm mới
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {
                /// Helper Function: Handle Loader, No Record, OR ERROR Message
                final response =
                    SHFCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot);
                if (response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => SHFSingAddress(
                    address: snapshot.data![index],
                    onTap: () async {
                      Get.defaultDialog(
                        title: '',
                        onWillPop: () async {return false;},
                        barrierDismissible: false,
                        backgroundColor: Colors.transparent,
                        content: const SHFCircularLoader(),
                      );
                      await controller.selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              }),
        ),
      ),
      ///nut them dia chi moi
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
