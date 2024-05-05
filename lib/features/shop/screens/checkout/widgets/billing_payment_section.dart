import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../controllers/product/checkout_controller.dart';

class SHFBillingPaymentSection extends StatelessWidget {
  const SHFBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        SHFSectionHeading(title: 'Phương thức thanh toán', buttonTitle: 'Thay đổi', onPressed: () => controller.selectPaymentMethod(context)),
        const SizedBox(height: SHFSizes.spaceBtwItems /2),
        Obx(
          ()=> Row(
            children: [
              SHFRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? SHFColors.light : SHFColors.white,
                padding: const EdgeInsets.all(SHFSizes.sm),
                child:  Image(image: AssetImage(controller.selectedPaymentMethod.value.image), fit: BoxFit.contain),
              ),
              const SizedBox(height: SHFSizes.spaceBtwItems /2),
              Text(controller.selectedPaymentMethod.value.name.capitalize.toString(), style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        )
      ],
    );
  }
}
