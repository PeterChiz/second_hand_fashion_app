import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  ///Variable
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL');
    password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    super.onInit();
  }

  ///Email & Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      //Start Loading
      SHFFullScreenLoader.openLoadingDialog(
          'Đang đăng nhập', SHFImages.docerAnimation);

      //Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      //Form xác thực
      if (!loginFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      //Luu du lieu neu chon Remember Me
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //dang nhap nguoi dung bang xac thuc email va mat khau
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Remove Loader
      SHFFullScreenLoader.stopLoading();

      //Chuyen huong nguoi dung
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }
}
