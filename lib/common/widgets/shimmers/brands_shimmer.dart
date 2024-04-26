import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';

class SHFBrandsShimmer extends StatelessWidget {
  const SHFBrandsShimmer({super.key, this.itemCount =4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SHFGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SHFShimmerEffect(width: 300, height: 800),
      mainAxisExtent: 80,
    );
  }
}
