import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/authentication/screens/widgets/terms_conditions_checkbox.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class SHFSignupForm extends StatelessWidget {
  const SHFSignupForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          ///First and Last name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: SHFTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: SHFSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: SHFTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: SHFSizes.spaceBtwInputFields),

          /// username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: SHFTexts.userName,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),

          ///email
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: SHFTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: SHFSizes.spaceBtwInputFields),

          ///phone number
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: SHFTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: SHFSizes.spaceBtwInputFields),

          ///password
          TextFormField(
            expands: true,
            decoration: const InputDecoration(
              labelText: SHFTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: SHFSizes.spaceBtwSections),

          ///term & conditions checkbox
          const SHFTermAndConditionCheckBox(),

          ///sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(SHFTexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}

