import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/user_controller.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../pertonalization/screens/profile/profile.dart';

class SHFHomeAppBar extends StatelessWidget {
  const SHFHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return SHFAppBar(
      title: GestureDetector(
        onTap: () => Get.to(() => const ProfileScreen()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(SHFTexts.homeAppbarTitle,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: SHFColors.grey)),
            Obx(
                  () {
                // Check if user Profile is still loading
                if (userController.profileLoading.value) {
                  // Display a shimmer loader while user profile is being loaded
                  return const SHFShimmerEffect(width: 80, height: 15);
                } else {
                  // Check if there are no record found
                  if (userController.user.value.id.isEmpty) {
                    // Display a message when no data is found
                    return Text(
                      'Tên của bạn',
                      style: Theme.of(context).textTheme.headlineSmall!.apply(color: SHFColors.white),
                    );
                  } else {
                    // Display User Name
                    return Text(
                      userController.user.value.fullName,
                      style: Theme.of(context).textTheme.headlineSmall!.apply(color: SHFColors.white),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
      actions: const [SHFCartCounterIcon(iconColor: SHFColors.white, counterBgColor: SHFColors.black, counterTextColor: SHFColors.white)],
    );
  }
}
