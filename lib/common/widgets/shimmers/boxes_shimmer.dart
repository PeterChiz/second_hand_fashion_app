import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class SHFBoxesShimmer extends StatelessWidget {
  const SHFBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: SHFShimmerEffect(width: 150, height: 100)),
            SizedBox(width: SHFSizes.spaceBtwItems,),
            Expanded(child: SHFShimmerEffect(width: 150, height: 100)),
            SizedBox(width: SHFSizes.spaceBtwItems,),
            Expanded(child: SHFShimmerEffect(width: 150, height: 100)),
          ],
        )
      ],
    );
  }
}
