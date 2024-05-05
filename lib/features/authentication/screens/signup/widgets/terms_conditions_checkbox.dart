import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/authentication/controllers/signup/signup_controller.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SHFTermAndConditionCheckBox extends StatelessWidget {
  const SHFTermAndConditionCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Row(
      children: [
        /// CHECKBOX => Wrap in a Sized box to remove extra padding
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
                () => Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = value!),
          ),
        ),
        const SizedBox(width: SHFSizes.md),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '${SHFTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                  text: SHFTexts.privacyPolicy,
                  recognizer: TapGestureRecognizer()..onTap = () => SHFDeviceUtils.launchWebsiteUrl('https://hoasecondhandshop.com/'),
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: SHFHelperFunctions.isDarkMode(context) ? SHFColors.white : SHFColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: SHFHelperFunctions.isDarkMode(context) ? SHFColors.white : SHFColors.primary,
                  ),
                ),
                TextSpan(text: ' ${SHFTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                  text: SHFTexts.termsOfUse,
                  recognizer: TapGestureRecognizer()..onTap = () => SHFDeviceUtils.launchWebsiteUrl('https://hoasecondhandshop.com/'),
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: SHFHelperFunctions.isDarkMode(context) ? SHFColors.white : SHFColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: SHFHelperFunctions.isDarkMode(context) ? SHFColors.white : SHFColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
