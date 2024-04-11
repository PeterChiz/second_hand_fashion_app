import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/address/add_new_address.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/address/widgets/single_address.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: SHFColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(
          Iconsax.add,
          color: SHFColors.white,
        ),
      ),
      appBar: SHFAppBar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: const SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              SHFSingAddress(selectedAddress: true),
              SHFSingAddress(selectedAddress: false),

            ],
          ),
        ),
      ),
    );
  }
}
