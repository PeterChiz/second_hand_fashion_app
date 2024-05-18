import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/login/login.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();

  /// Biến
  Rx<int> currentPageIndex = 0.obs;
  final pageController = PageController();

  /// Cập nhật Chỉ số Trang Hiện tại khi Trang Cuộn
  void updatePageIndicator(index) => currentPageIndex.value = index;

  /// Chuyển đến trang cụ thể được chọn bằng dấu chấm.
  void dotNavigationClick(index) {
    currentPageIndex.value == index;
    pageController.jumpToPage(index);
  }

  /// Cập nhật Chỉ số Trang Hiện tại & chuyển đến trang tiếp theo
  void nextPage() {
    // Nếu đây là chỉ số cuối cùng thì chuyển đến Màn hình Đăng nhập.
    // Ở đây có thể xác định LocalStorage để đặt OnBoarding bool isFirstTime = false.
    // Vì vậy, bất cứ khi nào ứng dụng khởi chạy, ứng dụng sẽ kiểm tra nếu isFirstTime = true,
    // hiển thị onBoarding khác hiển thị Đăng nhập hoặc Dashboard.
    if (currentPageIndex.value == 2) {

      final userStorage = GetStorage();
      userStorage.write('isFirstTime', false);

      Get.to(() => const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  /// Cập nhật Chỉ số Trang Hiện tại & chuyển đến Trang cuối cùng
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
