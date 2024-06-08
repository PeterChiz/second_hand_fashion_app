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
  final hidePassword = true.obs; // Observable để ẩn/hiện mật khẩu
  final privacyPolicy = false.obs; // Observable cho việc chấp nhận chính sách bảo mật
  final email = TextEditingController(); // Controller cho input email
  final lastName = TextEditingController(); // Controller cho input họ
  final username = TextEditingController(); // Controller cho input tên người dùng
  final password = TextEditingController(); // Controller cho input mật khẩu
  final firstName = TextEditingController(); // Controller cho input tên
  final phoneNumber = TextEditingController(); // Controller cho input số điện thoại

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Khóa form cho việc kiểm tra form


  ///SIGNUP
  void signup() async {
    // Kiểm tra privacyPolicy.value trước
    if (!privacyPolicy.value) {
      SHFLoaders.warningSnackBar(
        title: 'Chấp nhận Chính sách quyền riêng tư',
        message: 'Để tạo tài khoản, bạn phải đọc và chấp nhận Chính sách quyền riêng tư & Điều khoản sử dụng',
      );
      return;
    }
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

      // //Privacy Policy Check
      // if (!privacyPolicy.value) {
      //   SHFLoaders.warningSnackBar(
      //       title: 'Chấp nhận Chính sách quyền riêng tư',
      //       message:
      //           'Để tạo tài khoản, bạn phải đọc và chấp nhận Chính sách quyền riêng tư & Điều khoản sử dụng');
      //   return;
      // }

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
      //Di chuyển đến Verify Email Screen
      Get.to(() => const VerifyEmailScreen());
    } catch (e) {
      //Remove Loader
      SHFFullScreenLoader.stopLoading();

      //Hiển thị lỗi cho người dùng
      SHFLoaders.errorSnackBar(title: 'Có lỗi!', message: e.toString());
    }
  }
}
