import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/login/widgets/login_header.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/login_signup/form_driver.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SHFSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Logo, Title and Sub-Title
              const SHFLoginHeader(),

              ///form
              const SHFLoginForm(),

              ///Driver
              SHFFormDivider(dividerText: SHFTexts.orSignInWith.capitalize!),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              ///Footer
              const SHFSocialButtons(),

            ],
          ),
        ),
      ),
    );
  }
}

