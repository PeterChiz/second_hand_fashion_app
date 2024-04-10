import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:second_hand_fashion_app/common/widgets/list_tiles/setting_menu_tile.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/address/address.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/profile.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            SHFPrimaryHeaderContainer(
              child: Column(
                children: [
                  SHFAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: SHFColors.white),
                    ),
                  ),

                  ///User Profile Card
                  SHFUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen()),),
                  const SizedBox(
                    height: SHFSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),

            ///Body
            Padding(
              padding:  const EdgeInsets.all(SHFSizes.defaultSpace),
              child: Column(
                children: [
                  ///Account Setting
                   const SHFSectionHeading(
                    title: 'Account Setting',
                    showActionButton: false,
                  ),
                   const SizedBox(
                    height: SHFSizes.spaceBtwItems,
                  ),

                    SHFSettingMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Address',
                    subTitle: 'Set shopping delivery address',
                     onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                   const SHFSettingMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                  ),
                   const SHFSettingMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Order',
                    subTitle: 'In-progress and Completed Orders',
                  ),
                   const SHFSettingMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                  ),
                   const SHFSettingMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subTitle: 'List of all the discount coupons',
                  ),
                   const SHFSettingMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notification',
                    subTitle: 'Set any kind of notification message',
                  ),
                   const SHFSettingMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Primary',
                    subTitle: 'Manage data usage and connected accounts',
                  ),

                  ///AppSetting
                   const SizedBox(
                    height: SHFSizes.spaceBtwSections,
                  ),
                   const SHFSectionHeading(
                    title: 'Account Setting',
                    showActionButton: false,
                  ),
                   const SizedBox(
                    height: SHFSizes.spaceBtwItems,
                  ),
                   const SHFSettingMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subTitle: 'Up load data to your Cloud Firebase'),
                  SHFSettingMenuTile(
                    icon: Iconsax.document_upload,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  SHFSettingMenuTile(
                    icon: Iconsax.location,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  SHFSettingMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  ///Logout Button
                  const SizedBox(
                    height: SHFSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: (){}, child: const Text('Logout'),),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections * 2.5,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
