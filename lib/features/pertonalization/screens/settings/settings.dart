import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:second_hand_fashion_app/common/widgets/list_tiles/setting_menu_tile.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/address/address.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/profile.dart';
import 'package:second_hand_fashion_app/features/shop/screens/order/order.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../shop/screens/cart/cart.dart';
import '../../controllers/user_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return PopScope(
      canPop: false,
      // Intercept the back button press and redirect to Home Screen
      onPopInvoked: (value) async => Get.offAll(const NavigationMenu()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ///Header
              SHFPrimaryHeaderContainer(
                child: Column(
                  children: [
                    SHFAppBar(
                      title: Text(
                        'Tài khoản',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: SHFColors.white),
                      ),
                    ),

                    ///User Profile Card
                    SHFUserProfileTile(
                      onPressed: () => Get.to(() => const ProfileScreen()),
                    ),
                    const SizedBox(
                      height: SHFSizes.spaceBtwSections,
                    ),
                  ],
                ),
              ),

              /// -- Profile Body
              Padding(
                padding: const EdgeInsets.all(SHFSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Account Setting
                    const SHFSectionHeading(
                      title: 'Thiết lập tài khoản',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: SHFSizes.spaceBtwItems,
                    ),

                    SHFSettingMenuTile(
                      icon: Iconsax.safe_home,
                      title: 'Địa chỉ',
                      subTitle: 'Địa chỉ nhận hàng',
                      onTap: () => Get.to(() => const UserAddressScreen()),
                    ),
                    SHFSettingMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'Giỏ hàng của tôi',
                      subTitle: 'Thêm, xóa sản phẩm và chuyển sang thanh toán',
                      onTap: () => Get.to(() => const CartScreen()),
                    ),
                    SHFSettingMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'Đơn hàng của tôi',
                      subTitle: 'Đơn hàng đang thực hiện và đã hoàn thành',
                      onTap: () => Get.to(() => const OrderScreen()),
                    ),


                    ///Logout Button
                    const SizedBox(
                      height: SHFSizes.spaceBtwSections,
                    ),
                    SizedBox(
                        width: double.infinity, child: OutlinedButton(onPressed: () => controller.logout(), child: const Text('Logout'))),
                    const SizedBox(height: SHFSizes.spaceBtwSections * 2.5),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
