import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/helpers/network_manager.dart';
import 'package:second_hand_fashion_app/utils/popups/full_screen_loader.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  ///Gửi Email đặt lại mật khẩu
  sendPasswordResetEmail() async{
    try{
      //Start Loading
      SHFFullScreenLoader.openLoadingDialog('Đang xử lý yêu cầu của bạn', SHFImages.docerAnimation);
      //Check ket noi internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        SHFFullScreenLoader.stopLoading();
        return;
      }
      //Form Validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        SHFFullScreenLoader.stopLoading();
        return;
      }
      //Gửi email để đặt lại mật khẩu
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());
      //Xóa Loader
      SHFFullScreenLoader.stopLoading();
      //Show man hinh xac nhan
      SHFLoaders.successSnackBar(title: 'Email đã gửi', message: 'Liên kết email được gửi để Đặt lại mật khẩu của bạn'.tr);
      //Chuyen hunog nguoi dung
      Get.to(()=>ResetPasswordScreen(email: email.text.trim()));
    }catch(e){
      //Remove Loader
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async{
    try{
      //Start Loading
      SHFFullScreenLoader.openLoadingDialog('Đang xử lý yêu cầu của bạn', SHFImages.docerAnimation);

      //Check ket noi internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {SHFFullScreenLoader.stopLoading(); return;}

      await AuthenticationRepository.instance.sendPasswordResetEmail(email.trim());

      //Remove Loader
      SHFFullScreenLoader.stopLoading();

      //Show Success Screen
      SHFLoaders.successSnackBar(title: 'Email đã gửi', message: 'Liên kết email được gửi để Đặt lại mật khẩu của bạn'.tr);

    }catch(e){
      //Remove Loader
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}