import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/authentication/controllers/login/login_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class SHFSocialButtons extends StatelessWidget {
  const SHFSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Google Button
        Container(
          padding: const EdgeInsets.all(SHFSizes.xs),
          decoration: BoxDecoration(
              border: Border.all(color: SHFColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              width: SHFSizes.iconMd + 4,
              height: SHFSizes.iconMd + 4,
              image: AssetImage(SHFImages.google),
            ),
          ),
        ),
      ],
    );
  }
}
