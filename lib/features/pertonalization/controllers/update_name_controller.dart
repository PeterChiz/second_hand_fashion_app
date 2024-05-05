
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/user_controller.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/profile.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';

///Controller quản lý chức năng liên quan đến người dùng
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  ///Fetch user record
  Future<void> initializeNames() async{
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      //Start Loading
      SHFFullScreenLoader.openLoadingDialog(
          'Chúng tôi đang cập nhật thông tin của bạn', SHFImages.docerAnimation);

      //Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //Remove Loader
        SHFFullScreenLoader.stopLoading();
        return;
      }
      
      //Form validation
      if(!updateUserNameFormKey.currentState!.validate()){
        SHFFullScreenLoader.stopLoading();
        return;
      }
      
      //Cập nhật họ và tên của người dùng trong Firebase Firestore
      Map<String, dynamic> name = {'Họ và tên lót': lastName.text.trim(), 'Tên': firstName.text.trim()};
      await userRepository.updateSingleField(name);
      
      //Update the Rx User value
      userController.user.value.lastName = lastName.text.trim();
      userController.user.value.firstName = firstName.text.trim();
      
      //Remove Loader
      SHFFullScreenLoader.stopLoading();
      
      //Show Success Message
      SHFLoaders.successSnackBar(title: 'Chúc mừng', message: 'Tên của bạn đã được cập nhật.');

      //Move to previous screen
      Get.off(()=>const ProfileScreen());
    } catch (e) {
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(title: 'Có lỗi', message: e.toString());
    }
  }
}
