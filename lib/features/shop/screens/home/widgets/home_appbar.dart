import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/user_controller.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class SHFHomeAppBar extends StatelessWidget {
  const SHFHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return SHFAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(SHFTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: SHFColors.grey)),
          Obx(() {
            if(controller.profileLoading.value){
              //Hiển thị trình tải ánh sáng lung linh trong khi hồ sơ người dùng đang được tải
              return const SHFShimmerEffect(width: 80, height: 15);
            }else{
              return Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: SHFColors.white));
            }
          },
          )
        ],
      ),
      actions: [
        SHFCartCounterIcon(onPressed: () {},iconColor: SHFColors.white, ),
      ],
    );
  }
}
