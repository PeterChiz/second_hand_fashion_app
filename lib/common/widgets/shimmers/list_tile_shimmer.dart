import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class SHFListTileShimmer extends StatelessWidget {
  const SHFListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            SHFShimmerEffect(width: 50, height: 50, radius: 50,),
            SizedBox(width: SHFSizes.spaceBtwItems,),
            Column(
              children: [
                SHFShimmerEffect(width: 100, height: 15),
                SizedBox(height: SHFSizes.spaceBtwItems /2,),
                SHFShimmerEffect(width: 80, height: 12),
              ],
            )
          ],
        )
      ],

    );
  }
}
