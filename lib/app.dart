import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/theme/theme.dart';

import 'features/authentication/screens/onboarding/onboarding.dart';


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
