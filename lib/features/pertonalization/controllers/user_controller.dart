import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/user/user_repository.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/login/login.dart';
import 'package:second_hand_fashion_app/features/pertonalization/models/user_model.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/constants/text_strings.dart';
import 'package:second_hand_fashion_app/utils/helpers/network_manager.dart';
import 'package:second_hand_fashion_app/utils/popups/full_screen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();

  // final verifyRepository = Get.put(UserRepository());
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  ///Tìm nạp hồ sơ người dùng
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

  ///Lưu bản ghi người dùng từ bất kỳ nguồn đăng ký nào
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      //Trước tiên, hãy cập nhật người dùng Rx, sau đó kiểm tra xem dữ
      // liệu người dùng đã được lưu trữ chưa. nếu không lưu trữ dữ liệu mới
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          //chuyển đổi tên thành họ và tên
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredential.user!.displayName ?? '');

          //Map data
          final user = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            userName: username,
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
          );
          //Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      SHFLoaders.warningSnackBar(
          title: 'Dữ liệu chưa được lưu',
          message:
              'Đã xảy ra lỗi khi lưu thông tin của bạn. Bạn có thể lưu lại dữ liệu trong Hồ sơ của mình');
    }
  }

  ///Delete Account Warning
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

  ///Delete user Account
  void deleteUserAccount() async {
    try {
      SHFFullScreenLoader.openLoadingDialog('Xử lý', SHFImages.docerAnimation);

      ///Người dùng xác thực lại lần đầu
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //Re Verify Auth Email
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
      SHFLoaders.warningSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  ///Xác thực lại trước khi xóa
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      SHFFullScreenLoader.openLoadingDialog(
          'Đang xử lý', SHFImages.docerAnimation);

      //Kiểm tra kết nối internet
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
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      SHFFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.warningSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  ///upload profile image
  uploadUserProfilePicture() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512,maxWidth: 512);
      if(image != null){
        imageUploading.value = true;
        //upload image
        final imageUrl =  await userRepository.uploadImage('Users/Images/Profile', image);

        //Update user Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        SHFLoaders.successSnackBar(title: 'Chúc mừng', message: 'Ảnh đại diện của bạn đã được cập nhật thành công');
      }
    }catch(e){
      SHFLoaders.errorSnackBar(title: 'Oh snap', message: 'Có gì đó bị lỗi $e');
    }finally{
      imageUploading.value = false;
    }
  }
}
