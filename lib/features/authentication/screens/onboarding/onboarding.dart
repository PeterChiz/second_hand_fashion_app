import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/onboarding/widgets/onboarding_skip_button.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

// giao diện lúc mới vào app
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller quản lý logic và trạng thái onboarding.
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          /// Các trang cuộn ngang
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: SHFImages.onBoardingImage1,
                title: SHFTexts.onBoardingTitle1,
                subTitle: SHFTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: SHFImages.onBoardingImage2,
                title: SHFTexts.onBoardingTitle2,
                subTitle: SHFTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: SHFImages.onBoardingImage3,
                title: SHFTexts.onBoardingTitle3,
                subTitle: SHFTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          /// Nút bỏ qua
          const SHFOnBoardingSkipButton(),
          /// Điều hướng bằng dấu chấm SmoothPageIndicator
          const SHFOnBoardingDotNavigation(),
          /// Nút tiếp theo hình tròn
          const SHFOnboardingNextButton(),
        ],
      ),
    );
  }
}
