import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/login/login.dart';
import 'package:second_hand_fashion_app/features/pertonalization/models/user_model.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/re_authenticate_user_login_form.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/constants/text_strings.dart';
import 'package:second_hand_fashion_app/utils/helpers/network_manager.dart';
import 'package:second_hand_fashion_app/utils/popups/full_screen_loader.dart';

import '../../../common/widgets/loaders/circular_loader.dart';
import '../../../data/repositories/user/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final imageUploading = false.obs;
  final profileLoading = false.obs;
  final profileImageUrl = ''.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController(); // Email xác minh
  final verifyPassword = TextEditingController(); // Mật khẩu xác minh
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>(); // Khóa của biểu mẫu xác minh lại

  /// Khởi tạo dữ liệu người dùng khi màn hình chính xuất hiện
  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  /// Tải dữ liệu hồ sơ người dùng
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Lưu hồ sơ người dùng từ bất kỳ nguồn đăng ký nào
  Future<void> saveUserRecord({UserModel? user, UserCredential? userCredentials}) async {
    try {
      // Cập nhật User Rx trước và sau đó kiểm tra xem dữ liệu người dùng đã được lưu trữ chưa. Nếu chưa, lưu dữ liệu mới
      await fetchUserRecord();

      // Nếu không có bản ghi nào được lưu trữ.
      if (this.user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Chuyển đổi tên thành tên và họ
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final customUsername = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          // Ánh xạ dữ liệu
          final newUser = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "",
            username: customUsername,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Lưu dữ liệu người dùng
          await userRepository.saveUserRecord(newUser);

          // Gán người dùng mới cho RxUser để có thể sử dụng nó trong toàn bộ ứng dụng.
          this.user(newUser);
        } else if (user != null) {
          // Lưu Model khi người dùng đăng ký bằng Email và Mật khẩu
          await userRepository.saveUserRecord(user);

          // Gán người dùng mới cho RxUser để có thể sử dụng nó trong toàn bộ ứng dụng.
          this.user(user);
        }
      }
    } catch (e) {
      SHFLoaders.warningSnackBar(
        title: 'Không thể lưu dữ liệu',
        message: 'Đã xảy ra lỗi khi lưu thông tin của bạn. Bạn có thể lưu lại dữ liệu trong Hồ sơ của mình.',
      );
    }
  }

  /// Cảnh báo xóa tài khoản
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SHFSizes.md),
      title: 'Xóa tài khoản',
      middleText: SHFTexts.warningDeleteAccount,
      confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: SHFSizes.lg),
            child: Text('Xóa'),
          )),
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Hủy bỏ')),
    );
  }

  /// Xóa tài khoản người dùng
  void deleteUserAccount() async {
    try {
      SHFFullScreenLoader.openLoadingDialog('Xử lý', SHFImages.docerAnimation);

      /// Người dùng xác thực lại lần đầu
      final auth = AuthenticationRepository.instance;
      final provider = auth.firebaseUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // Xác minh Email Auth lại
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          SHFFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          SHFFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.warningSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

  /// Xác thực lại trước khi xóa
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      SHFFullScreenLoader.openLoadingDialog(
          'Đang xử lý', SHFImages.docerAnimation);

      // Kiểm tra kết nối internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text
          .trim());
      await AuthenticationRepository.instance.deleteAccount();
      SHFFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.warningSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }

  /// Tải lên hình ảnh hồ sơ
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        // Tải lên hình ảnh
        final uploadedImage = await userRepository.uploadImage('Users/Images/Profile/', image);
        profileImageUrl.value = uploadedImage;

        // Cập nhật bản ghi Hình ảnh người dùng
        Map<String, dynamic> newImage = {'ProfilePicture': uploadedImage};
        await userRepository.updateSingleField(newImage);

        user.value.profilePicture = uploadedImage;
        user.refresh();

        imageUploading.value = false;

        SHFLoaders.successSnackBar(title: 'Chúc mừng', message: 'Ảnh đại diện của bạn đã được cập nhật thành công');
      }
    } catch (e) {
      imageUploading.value = false;
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: 'Có gì đó bị lỗi $e');
    }
  }

  /// Hàm thoát
  logout() {
    try {
      Get.defaultDialog(
        contentPadding: const EdgeInsets.all(SHFSizes.md),
        title: 'Đăng xuất',
        middleText: 'Bạn có chắc muốn đăng xuất không ?',
        confirm: ElevatedButton(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: SHFSizes.lg),
            child: Text('Xác nhận'),
          ),
          onPressed: () async {
            onClose();

            /// Xác nhận hiển thị bất kỳ loader nào cho đến khi người dùng đăng xuất.
            Get.defaultDialog(
              title: '',
              barrierDismissible: false,
              backgroundColor: Colors.transparent,
              content: const SHFCircularLoader(),
            );
            await AuthenticationRepository.instance.logout();
          },
        ),
        cancel: OutlinedButton(
          child: const Text('Hủy'),
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        ),
      );
    } catch (e) {
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
