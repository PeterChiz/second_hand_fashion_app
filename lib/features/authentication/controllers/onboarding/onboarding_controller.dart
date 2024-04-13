import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../screens/login/login.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();
  ///Variable
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  ///Update Current Index when Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  ///Jump to the specific dot selected page
  void dotNavigationClick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  ///Update Current Index and jum to next page
  void nextPage(){
    if(currentPageIndex.value == 2){
      final storage = GetStorage();

      storage.write('IsFirstTime', false);

      Get.offAll(const LoginScreen());
    }else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  ///Update Current Index and jump to the last Page
  void skipPage(){
    currentPageIndex.value =2;
    pageController.jumpToPage(2);
  }
}