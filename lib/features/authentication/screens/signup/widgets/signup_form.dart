import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:second_hand_fashion_app/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class SHFSignupForm extends StatelessWidget {
  const SHFSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          ///First and Last name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      SHFValidator.validationEmptyText('Họ và tên lót', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: SHFTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      SHFValidator.validationEmptyText('Tên', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: SHFTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: SHFSizes.spaceBtwInputFields,
              ),
            ],
          ),
          const SizedBox(height: SHFSizes.spaceBtwInputFields),

          /// username
          TextFormField(
            validator: (value) =>
                SHFValidator.validationEmptyText('Tên tài khoản', value),
            controller: controller.userName,
            expands: false,
            decoration: const InputDecoration(
                labelText: SHFTexts.userName,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: SHFSizes.spaceBtwInputFields),

          ///email
          TextFormField(
            validator: (value) => SHFValidator.validateEmail(value),
            controller: controller.email,
            decoration: const InputDecoration(
                labelText: SHFTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: SHFSizes.spaceBtwInputFields),

          ///phone number
          TextFormField(
            validator: (value) => SHFValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
                labelText: SHFTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: SHFSizes.spaceBtwInputFields),

          ///password
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
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
              ),
            ),
          ),
          ),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          ///term & conditions checkbox
          const SHFTermAndConditionCheckBox(),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          ///sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(SHFTexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}
