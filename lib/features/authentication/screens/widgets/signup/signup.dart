import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/login_signup/form_driver.dart';
import 'package:second_hand_fashion_app/common/widgets/login_signup/social_buttons.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/constants/text_strings.dart';

import '../signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(SHFTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                height: SHFSizes.spaceBtwSections,
              ),

              ///form
              const SHFSignupForm(),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              ///driver
              SHFFormDivider(dividerText: SHFTexts.orSignUpWith.capitalize!),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              ///social button
              const SHFSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}

