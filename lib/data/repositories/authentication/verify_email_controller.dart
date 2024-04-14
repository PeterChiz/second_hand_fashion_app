

import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/signup/verify_email.dart';

class VerifyEmailController extends GetxController{
  static VerifyEmailController get instance => Get.find();

  ///Send Email Whenever Verify Screen appears & Set Timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    super.onInit();
  }

  ///Send Email Verification link
  sendEmailVerification() async{
    try{
      await AuthenticationRepository.instance.sendEmailVerification();
      SHFLoaders.successSnackBar(title: 'Email Sent', message: 'Please Check your inbox and verify your email.');
    }catch(e){
      SHFLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  ///Timer to automatically redirect on Email Verification
///Manually Check if Email Verified
}