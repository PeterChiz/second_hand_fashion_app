import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/login_signup/form_driver.dart';
import 'package:second_hand_fashion_app/common/widgets/login_signup/social_buttons.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/constants/text_strings.dart';

import '../../../../common/widgets/appbar/appbar.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SHFAppBar(showBackArrow: true),
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

              ///Form
              const SHFSignupForm(),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              ///Driver
              SHFFormDivider(dividerText: SHFTexts.orSignUpWith.capitalize!),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              ///Social button
              const SHFSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}

