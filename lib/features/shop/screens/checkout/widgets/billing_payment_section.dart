import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

class SHFBillingPaymentSection extends StatelessWidget {
  const SHFBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        SHFSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: (){}),
        const SizedBox(height: SHFSizes.spaceBtwItems /2,),
        Row(
          children: [
            SHFRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? SHFColors.light : SHFColors.white,
              padding: const EdgeInsets.all(SHFSizes.sm),
              child: const Image(image: AssetImage(SHFImages.paypal), fit: BoxFit.contain,),
            ),
            const SizedBox(height: SHFSizes.spaceBtwItems /2,),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge,),
          ],
        )
      ],
    );
  }
}
