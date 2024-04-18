import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/user/user_repository.dart';
import 'package:second_hand_fashion_app/features/pertonalization/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  ///Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final nameParts =
        UserModel.nameParts(userCredential.user!.displayName ?? '');
        final username =
        UserModel.generateUsername(userCredential.user!.displayName ?? '');

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
    } catch (e) {
      SHFLoaders.warningSnackBar(title: 'Data not saved', message:'Đã xảy ra lỗi khi lưu thông tin của bạn. Bạn có thể lưu lại dữ liệu trong Hồ sơ của mình');
    }
  }
}
