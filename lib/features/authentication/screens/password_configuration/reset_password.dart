import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/login/login.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/constants/text_strings.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      /// Thanhs ứng dụng để quay lại HOẶC đóng tất cả các màn hình và điều hướng đến Màn hình Đăng nhập
      appBar: SHFAppBar(
        actions: [
          IconButton(
              onPressed: () => Get.offAll(const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              /// Hình ảnh
              Image(
                image: const AssetImage(SHFImages.deliveredEmailIllustration),
                width: SHFHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              /// Email, Tiêu đề & Phụ đề
              Text(email, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: SHFSizes.spaceBtwItems,),
              Text(SHFTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: SHFSizes.spaceBtwItems,),
              Text(SHFTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: SHFSizes.spaceBtwSections,),

              /// Nút
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.offAll(() => const LoginScreen()),
                      child: const Text(SHFTexts.done))),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () =>
                          controller.resendPasswordResetEmail(email),
                      child: const Text(SHFTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
