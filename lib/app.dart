import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/theme/theme.dart';

import 'features/authentication/screens/onboarding/onboarding.dart';

/// Sử dụng Class này để thiết lập themes, liên kết ban đầu, bất kỳ hoạt ảnh nào và được sử dụng bằng Material Widget
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: SHFAppTheme.lightTheme,
      darkTheme: SHFAppTheme.darkTheme,
      home: const OnBoardingScreen(),
    );
  }
}
