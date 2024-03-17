import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/onboarding_controller.dart';
import '../widgets/onboarding_dot_navigation.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
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
          //
          const OnBoardingSkip(),
          //
          const OnBoardingDotNavigation(),
          //
          const OnboardingNextButton(),
        ],
      ),
    );
  }
}


