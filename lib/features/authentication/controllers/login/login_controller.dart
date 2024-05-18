import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/user_controller.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';

/// Biến điều khiển cho việc đăng nhập.
class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Các biến
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// -- Đăng nhập bằng Email và Mật khẩu
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Bắt đầu tải
      SHFFullScreenLoader.openLoadingDialog('Đang đăng nhập', SHFImages.docerAnimation);

      // kiểm tra kết nối
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        SHFLoaders.customToast(message: 'Không có kết nối internet');
        return;
      }

      // Xác thực biểu mẫu
      if (!loginFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Lưu dữ liệu nếu Chọn Remember Me
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Đăng nhập người dùng bằng Xác thực Email & Mật khẩu
      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Gán dữ liệu người dùng cho RxUser của UserController để sử dụng trong ứng dụng
      await userController.fetchUserRecord();

      // Gỡ bỏ tải
      SHFFullScreenLoader.stopLoading();

      // Chuyển hướng
      await AuthenticationRepository.instance.screenRedirect(userCredentials.user);
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

  /// Xác thực Đăng nhập Google
  Future<void> googleSignIn() async {
    try {
      // Bắt đầu tải
      SHFFullScreenLoader.openLoadingDialog('Đang đăng nhập', SHFImages.docerAnimation);

      // Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Xác thực Google
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // Lưu dữ liệu người dùng đã xác thực trong Firebase Firestore
      await userController.saveUserRecord(userCredentials: userCredentials);

      // Gỡ bỏ tải
      SHFFullScreenLoader.stopLoading();

      // Chuyển hướng
      await AuthenticationRepository.instance.screenRedirect(userCredentials?.user);
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

}
