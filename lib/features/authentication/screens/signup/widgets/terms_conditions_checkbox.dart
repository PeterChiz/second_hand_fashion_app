import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';


class SHFTermAndConditionCheckBox extends StatelessWidget {
  const SHFTermAndConditionCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(width: SHFSizes.spaceBtwItems),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '${SHFTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: SHFTexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? SHFColors.white : SHFColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor:
                  dark ? SHFColors.white : SHFColors.primary,
                )),
            TextSpan(
                text: '${SHFTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: SHFTexts.termOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? SHFColors.white : SHFColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor:
                  dark ? SHFColors.white : SHFColors.primary,
                )),
          ]),
        ),
      ],
    );
  }
}
