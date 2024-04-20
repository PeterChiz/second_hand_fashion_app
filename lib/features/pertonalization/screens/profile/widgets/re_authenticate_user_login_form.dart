import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/user_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/constants/text_strings.dart';
import 'package:second_hand_fashion_app/utils/validators/validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: SHFValidator.validateEmail,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: SHFTexts.email),
                ),
                const SizedBox(
                  height: SHFSizes.spaceBtwInputFields,
                ),

                ///Password
                Obx(() => TextFormField(
                      obscureText: controller.hidePassword.value,
                      controller: controller.verifyPassword,
                      validator: (value) =>
                          SHFValidator.validationEmptyText('Password', value),
                      decoration: InputDecoration(
                          labelText: SHFTexts.password,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                                !controller.hidePassword.value,
                            icon: const Icon(Iconsax.eye_slash),
                          )),
                    )),
                const SizedBox(
                  height: SHFSizes.spaceBtwSections,
                ),

                ///Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.reAuthenticateEmailAndPasswordUser(),
                      child: const Text('Verify')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
