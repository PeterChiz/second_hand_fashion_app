import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/signup/verify_email.dart';
import 'package:second_hand_fashion_app/features/pertonalization/models/user_model.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/helpers/network_manager.dart';
import 'package:second_hand_fashion_app/utils/popups/full_screen_loader.dart';
import '../../../pertonalization/controllers/user_controller.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs; // Observable for hiding/showing password
  final privacyPolicy = true.obs; // Observable for privacy policy acceptance
  final email = TextEditingController(); // Controller for email input
  final lastName = TextEditingController(); // Controller for last name input
  final username = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final firstName = TextEditingController(); // Controller for first name input
  final phoneNumber = TextEditingController(); // Controller for phone number input

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form key for form validation


  ///SIGNUP
  void signup() async {
    try {
      //Start Loading
      SHFFullScreenLoader.openLoadingDialog(
          'Đang xử lý thông tin của bạn', SHFImages.docerAnimation);

      //Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Remove Loader
        SHFFullScreenLoader.stopLoading();
        return;
      }

      //Form xác thực
      if (!signupFormKey.currentState!.validate()) {
        //Remove Loader
        SHFFullScreenLoader.stopLoading();
        return;
      }

      //Privacy Policy Check
      if (!privacyPolicy.value) {
        SHFLoaders.warningSnackBar(
            title: 'Chấp nhận Chính sách quyền riêng tư',
            message:
                'Để tạo tài khoản, bạn phải đọc và chấp nhận Chính sách quyền riêng tư & Điều khoản sử dụng');
        return;
      }

      //Đăng ký người dùng trong Xác thực Firebase & Lưu dữ liệu người dùng trong Firebase
      await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Lưu dữ liệu người dùng Xác thực trong Firebase Firestore
      final newUser = UserModel(
        id: AuthenticationRepository.instance.getUserID,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      await UserController.instance.saveUserRecord(user: newUser);

      //Remove Loader
      SHFFullScreenLoader.stopLoading();

      //Hiển thị thông báo thành công
      SHFLoaders.successSnackBar(title: 'Chúc mừng', message: 'Tài khoản của bạn đã được tạo! Xác minh email để tiếp tục.');
      //Move to Verify Email Screen
      Get.to(() => const VerifyEmailScreen());
    } catch (e) {
      //Remove Loader
      SHFFullScreenLoader.stopLoading();

      //Hiển thị lỗi cho người dùng
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    }
  }
}
