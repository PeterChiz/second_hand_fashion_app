
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/animation_loader.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

///Lop utility dung de quan ly hop thoai tai toan man hinh
class SHFFullScreenLoader{
  ///Mo hop thoai tai man hinh voi van ban va hoat anh nhat dinh
  ///Method nay khong tra ve
  ///
  /// Thong so:
  /// text: Van ban se duoc hien thi trong hop thoai tai
  /// animation: hoat anh se duoc show

  static void openLoadingDialog(String text, String animation){
    showDialog(
        context: Get.overlayContext!, //Su dung Get.overlayContext cho overlay dialogs
        barrierDismissible: false, //Khong the loai bo hop thoai bang cach nhan vao ben trong hop thoai
        builder: (_) => PopScope(
          canPop: false, //vo hieu hoa popping bang nut quay lai
            child: Container(
              color: SHFHelperFunctions.isDarkMode(Get.context!) ? SHFColors.dark : SHFColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250,),
                  SHFAnimationLoaderWidget(text: text, animation: animation),
                ],
              ),
        ))
    );
  }
  ///Dừng hộp thoại tải hiện đang mở
  ///Method nay khong tra ve bat cu gi

  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop(); //Đóng hộp thoại bằng Navigator
  }
}

