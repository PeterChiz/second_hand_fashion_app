import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class SHFCouponCode extends StatelessWidget {
  const SHFCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return SHFRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? SHFColors.dark : SHFColors.white,
      padding: const EdgeInsets.only(
          top: SHFSizes.sm,
          bottom: SHFSizes.sm,
          right: SHFSizes.sm,
          left: SHFSizes.sm),
      child: Row(
        children: [
          Flexible(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Have a promo code? Enter here',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              )),

          ///Button
          SizedBox(
              width: 80,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: dark
                        ? SHFColors.white.withOpacity(0.5)
                        : SHFColors.dark.withOpacity(0.5),
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    side: BorderSide(
                        color: Colors.grey.withOpacity(0.1)),
                  ),
                  child: const Text('Apply')))
        ],
      ),
    );
  }
}
