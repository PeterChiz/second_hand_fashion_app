import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';


class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SHFSizes.defaultSpace),
      child: Column(
        children: [
          // Hiển thị hình ảnh onboarding
          Image(
              width: SHFHelperFunctions.screenWidth() * 0.8,
              height: SHFHelperFunctions.screenHeight() * 0.6,
              image: AssetImage(image)),
          // Hiển thị tiêu đề onboarding
          Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
          const SizedBox(height: SHFSizes.spaceBtwItems),
          // Hiển thị phụ đề onboarding
          Text(subTitle, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
