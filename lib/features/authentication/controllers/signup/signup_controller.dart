
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication_repository.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/helpers/network_manager.dart';
import 'package:second_hand_fashion_app/utils/popups/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///Variable
  final hidePassword = true.obs; //Observable for hiding/showing password
  final privacyPolicy = true.obs; //Observable for privacy policy acceptance
  final email = TextEditingController(); //Controller for ... input
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  ///SIGNUP
  Future<void> signup() async{
    try{
      //Start Loading
      SHFFullScreenLoader.openLoadingDialog('We are processing your information...', SHFImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) return;

      //Form Validation
      if(!signupFormKey.currentState!.validate()) return;

      //Privacy Policy Check
      if(!privacyPolicy.value){
        SHFLoaders.warningSnackBar(title: 'Accept Privacy Policy',
          message: 'In order ti create account, you must have to read and accept the Privacy Policy & Terms of Use'
        );
        return;
      }
      //Register user in the Firebase Authentication & Save user data in the Firebase
      //Save Authentication user data in the Firebase Firestore
      //Show Success Message
      //Move to Verify Email Screen

    }catch (e){
      //Show some Generic Error to the user
      SHFLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      //Remove Loader
      SHFFullScreenLoader.stopLoading();
    }
  }
}
