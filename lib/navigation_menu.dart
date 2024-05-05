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
    final darkMode = SHFHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          animationDuration: const Duration(seconds: 3),
          selectedIndex: controller.selectedMenu.value,
          onDestinationSelected: (index) => controller.selectedMenu.value = index,
          backgroundColor: darkMode ? SHFColors.black : SHFColors.white,
          indicatorColor: darkMode ? SHFColors.white.withOpacity(0.1) : SHFColors.black.withOpacity(0.1),

          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedMenu.value]),//lấy giá trị màu vào
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  final Rx<int> selectedMenu = 0.obs;

  final screens = [const HomeScreen(),const StoreScreen(),const FavouriteScreen(),const SettingsScreen()];
}

