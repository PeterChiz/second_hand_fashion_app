import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class SHFHorizontalProductShimmer extends StatelessWidget {
  const SHFHorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: SHFSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            const SizedBox(width: SHFSizes.spaceBtwItems),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///Image
            SHFShimmerEffect(width: 120, height: 120),
            SizedBox(width: SHFSizes.spaceBtwItems),

            ///Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: SHFSizes.spaceBtwItems / 2),
                SHFShimmerEffect(width: 160, height: 15),
                SizedBox(height: SHFSizes.spaceBtwItems / 2),
                SHFShimmerEffect(width: 110, height: 15),
                SizedBox(height: SHFSizes.spaceBtwItems / 2),
                SHFShimmerEffect(width: 80, height: 15),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
