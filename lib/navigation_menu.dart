import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/settings/settings.dart';
import 'package:second_hand_fashion_app/features/shop/screens/home/home.dart';
import 'package:second_hand_fashion_app/features/shop/screens/store/store.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import 'features/shop/screens/favourites/favourite.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          animationDuration: const Duration(seconds: 3),
          selectedIndex: controller.selectedMenu.value,
          backgroundColor: SHFHelperFunctions.isDarkMode(context) ? SHFColors.black : Colors.white,
          indicatorColor: SHFHelperFunctions.isDarkMode(context) ? SHFColors.white.withOpacity(0.1) : SHFColors.black.withOpacity(0.1),
          onDestinationSelected: (index) => controller.selectedMenu.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Nhà'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Cửa hàng'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Yêu thích'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Trang cá nhân'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedMenu.value]),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  final Rx<int> selectedMenu = 0.obs;

  final screens = [const HomeScreen(),const StoreScreen(),const FavouriteScreen(),const SettingsScreen()];
}

