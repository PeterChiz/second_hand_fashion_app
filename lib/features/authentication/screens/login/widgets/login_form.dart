import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/widgets/signup/signup.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
class SHFLoginForm extends StatelessWidget {
  const SHFLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: SHFSizes.spaceBtwSections),
        child: Column(
          children: [
            ///
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: SHFTexts.email,
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields),

            ///
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: SHFTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwInputFields / 2),

            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(SHFTexts.rememberMe),
                  ],
                ),

                ///
                TextButton(
                    onPressed: () {},
                    child: const Text(SHFTexts.forgetPassword)),
              ],
            ),
            const SizedBox(height: SHFSizes.spaceBtwSections),

            ///Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
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
