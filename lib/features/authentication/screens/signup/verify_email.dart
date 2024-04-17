import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/login/login.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/constants/text_strings.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      /// The close icon in the app bar is used to log out the user and redirect them to the login screen.
      /// This approach is taken to handle scenarios where the user enters the registration process,
      /// and the data is stored. Upon reopening the app, it checks if the email is verified.
      /// If not verified, the app always navigates to the verification screen.
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        //Phần đệm để tạo không gian mặc định bằng nhau ở tất cả các cạnh trong tất cả màn hình.
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(
                image: const AssetImage(SHFImages.deliveredEmailIllustration),
                width: SHFHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              ///Title & SubTitle
              Text(
                SHFTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: SHFSizes.spaceBtwItems,
              ),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: SHFSizes.spaceBtwItems,
              ),
              Text(
                SHFTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: SHFSizes.spaceBtwSections,
              ),

              ///Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.checkEmailVerificationStatus(),
                      child: const Text(SHFTexts.shfContinue))),
              const SizedBox(
                height: SHFSizes.spaceBtwItems,
              ),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.sendEmailVerification(),
                      child: const Text(SHFTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
