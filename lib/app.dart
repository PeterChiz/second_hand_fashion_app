import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/theme/theme.dart';

import 'features/authentication/screens/onboarding/onboarding.dart';

/// Sử dụng Class này để thiết lập themes cho ứng dụng và chọn theme dựa trên cài đặt hệ thống
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: SHFAppTheme.lightTheme,
      darkTheme: SHFAppTheme.darkTheme,

      /// Hiển thị CircularProgressIndicator trong khi đợi xử lý, đặt trên nền màu chủ đạo của ứng dụng
      home: const Scaffold(backgroundColor: SHFColors.primary, body: Center(child: CircularProgressIndicator(color: Colors.white,),),),
    );
  }
}
