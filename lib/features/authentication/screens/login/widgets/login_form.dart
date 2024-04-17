import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/authentication/controllers/login/login_controller.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:second_hand_fashion_app/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../signup/signup.dart';

class SHFLoginForm extends StatelessWidget {
  const SHFLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    //Biễu mẫu đăng nhập lớp riêng biệt chứa mọi thứ liên quan đến biểu mẫu đăng nhập và tiêu đề đăng nhập chứa văn bản
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: SHFSizes.spaceBtwSections),
        child: Column(
          children: [
            ///Email
            TextFormField(
              controller: controller.email,
              validator: (value) => SHFValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: SHFTexts.email,
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields),

            ///Password
            Obx(
              () => TextFormField(
                validator: (value) => SHFValidator.validatePassword(value),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: SHFTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields / 2),

            ///Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember me
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                    const Text(SHFTexts.rememberMe),
                  ],
                ),

                ///Forger Password
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text(SHFTexts.forgetPassword)),
              ],
            ),
            const SizedBox(height: SHFSizes.spaceBtwSections),

            ///Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.emailAndPasswordSignIn(),
                    child: const Text(SHFTexts.signIn))),
            const SizedBox(height: SHFSizes.spaceBtwItems),

            ///Create account button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    child: const Text(SHFTexts.createAccount))),
            const SizedBox(height: SHFSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
