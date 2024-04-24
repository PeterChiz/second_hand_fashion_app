import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class SHFVerticalProductShimmer extends StatelessWidget {
  const SHFVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SHFGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Image
                  SHFShimmerEffect(width: 180, height: 180),
                  SizedBox(height: SHFSizes.spaceBtwItems,),

                  ///Text
                  SHFShimmerEffect(width: 160, height: 15),
                  SizedBox(height: SHFSizes.spaceBtwItems /2,),
                  SHFShimmerEffect(width: 110, height: 15),
                ],
              ),
            ));
  }
}
