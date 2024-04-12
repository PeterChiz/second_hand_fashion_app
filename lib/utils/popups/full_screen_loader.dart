
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/animation_loader.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

///A utility class foe managing a full-screen loading dialog
class SHFFullScreenLoader{
  ///Open a full-screen loading dialog with a given text and animation
  ///This method doesn't return anything
  ///
  /// Parameters:
  /// text: The text to br displayed in the loading dialog
  /// animation: the lottie animation to br shown

  static void openLoadingDialog(String text, String animation){
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
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
  ///Stop the currently open loading dialog
  ///This method doesn't return anything

  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop(); //Close the dialog using the Navigator
  }
}

