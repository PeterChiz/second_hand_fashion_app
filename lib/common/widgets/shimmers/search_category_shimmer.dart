import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';

import '../../../utils/constants/sizes.dart';

class SHFSearchCategoryShimmer extends StatelessWidget {
  const SHFSearchCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: SHFSizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              SHFShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: SHFSizes.spaceBtwItems / 2),

              /// Text
              SHFShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
