import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class SHFCouponCode extends StatelessWidget {
  const SHFCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SHFRoundedContainer(
      showBorder: true,
      backgroundColor: isDark ? SHFColors.dark : SHFColors.white,
      padding: const EdgeInsets.only(
          top: SHFSizes.sm,
          bottom: SHFSizes.sm,
          right: SHFSizes.sm,
          left: SHFSizes.md),
      child: Row(
        children: [
          /// TextField
          Flexible(
              child: TextFormField(
                expands: false,
                decoration: const InputDecoration(
                  hintText: 'Mã khuyến mãi',
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
                    foregroundColor: isDark
                        ? SHFColors.white.withOpacity(0.5)
                        : SHFColors.dark.withOpacity(0.5),
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    side: BorderSide(
                        color: Colors.grey.withOpacity(0.1)),
                  ),
                  child: const Text('Chấp nhận')))
        ],
      ),
    );
  }
}
