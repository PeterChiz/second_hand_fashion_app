import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/common/widgets/success_screen/success_screen.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/text_strings.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    /// Send Email Whenever Verify Screen appears & Set Timer for auto redirect.
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      SHFLoaders.successSnackBar(
          title: 'Đã gửi email',
          message: 'Vui lòng kiểm tra hộp thư đến và xác minh email của bạn.');
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

  ///Hẹn giờ tự động chuyển hướng trên Xác minh Email
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              image: SHFImages.successfullyRegisterAnimation,
              title: SHFTexts.yourAccountCreatedTitle,
              subTitle: SHFTexts.yourAccountCreatedSubTitle,
              onPressed: () => AuthenticationRepository.instance
                  .screenRedirect(FirebaseAuth.instance.currentUser),
            ),
          );
        }
      },
    );
  }

  ///Kiểm tra thủ công nếu email đã được xác minh
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: SHFImages.successfullyRegisterAnimation,
          title: SHFTexts.yourAccountCreatedTitle,
          subTitle: SHFTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance
              .screenRedirect(FirebaseAuth.instance.currentUser),
        ),
      );
    }
  }
}
