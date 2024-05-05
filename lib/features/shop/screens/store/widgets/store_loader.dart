import 'package:flutter/material.dart';

import '../../../../../common/widgets/shimmers/boxes_shimmer.dart';
import '../../../../../common/widgets/shimmers/brands_shimmer.dart';
import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../../utils/constants/sizes.dart';

class SHFStoreShimmerLoader extends StatelessWidget {
  const SHFStoreShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(SHFSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(height: SHFSizes.spaceBtwSections),
            // AppBar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SHFShimmerEffect(width: 100, height: 15),
                SHFShimmerEffect(width: 55, height: 55, radius: 55),
              ],
            ),
            SizedBox(height: SHFSizes.spaceBtwSections * 2),
            // Search
            SHFShimmerEffect(width: double.infinity, height: 55),
            SizedBox(height: SHFSizes.spaceBtwSections),

            // Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SHFShimmerEffect(width: 100, height: 15),
                SHFShimmerEffect(width: 80, height: 12),
              ],
            ),
            SizedBox(height: SHFSizes.spaceBtwSections),

            // Brands
            SHFBrandsShimmer(),
            SizedBox(height: SHFSizes.spaceBtwSections * 2),

            // Categories
            Row(
              children: [
                Expanded(child: SHFShimmerEffect(width: 100, height: 15)),
                SizedBox(width: SHFSizes.spaceBtwItems),
                Expanded(child: SHFShimmerEffect(width: 100, height: 15)),
                SizedBox(width: SHFSizes.spaceBtwItems),
                Expanded(child: SHFShimmerEffect(width: 100, height: 15)),
                SizedBox(width: SHFSizes.spaceBtwItems),
                Expanded(child: SHFShimmerEffect(width: 100, height: 15)),
              ],
            ),
            SizedBox(height: SHFSizes.spaceBtwSections),

            // Category Brands
            SHFListTileShimmer(),
            SizedBox(height: SHFSizes.spaceBtwSections),
            SHFBoxesShimmer(),
            SizedBox(height: SHFSizes.spaceBtwSections),

            // Products
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SHFShimmerEffect(width: 100, height: 15),
                SHFShimmerEffect(width: 80, height: 12),
              ]
            ),
            SizedBox(height: SHFSizes.spaceBtwSections),

            SHFVerticalProductShimmer(),
            SizedBox(height: SHFSizes.spaceBtwSections * 3),
          ],
        ),
      ),
    );
  }
}
