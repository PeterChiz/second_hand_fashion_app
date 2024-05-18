import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/constants/text_strings.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      /// Thanh ứng dụng sẽ đóng màn hình và sau đó chuyển hướng đến Màn hình Đăng nhập
      /// Lý do: lưu dữ liệu khi người dùng nhấn nút Đăng ký trên Màn hình trước đó.
      /// Mỗi khi người dùng mở ứng dụng, sẽ kiểm tra xem email đã được xác minh chưa.
      /// Nếu chưa được xác minh, sẽ luôn hiển thị màn hình Xác minh này.
      appBar: SHFAppBar(
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        // Phần đệm để tạo không gian mặc định bằng nhau ở tất cả các cạnh trong tất cả các màn hình.
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

              /// Tiêu đề & Phụ đề
              Text(
                SHFTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              Text(
                SHFTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              /// Nút
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.checkEmailVerificationStatus(),
                      child: const Text(SHFTexts.shfContinue))),
              const SizedBox(
                height: SHFSizes.spaceBtwItems,
              ),

              /// Gửi lại Email
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.sendEmailVerification(),
                      child: const Text(SHFTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
