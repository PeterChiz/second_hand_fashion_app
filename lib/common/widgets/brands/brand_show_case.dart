import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/models/brand_model.dart';
import 'package:second_hand_fashion_app/features/shop/screens/brand/brand_products.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_cart.dart';

class SHFBrandShowcase extends StatelessWidget {
  const SHFBrandShowcase({
    super.key,
    required this.images,
    required this.brand,
  });

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: SHFRoundedContainer(
        showBorder: true,
        borderColor: SHFColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(SHFSizes.md),
        margin: const EdgeInsets.only(bottom: SHFSizes.spaceBtwItems),
        child: Column(
          children: [
            ///Brand voi so luong product
            SHFBrandCard(showBorder: false, brand: brand),
            const SizedBox(
              height: SHFSizes.spaceBtwItems,
            ),

            ///3 anh top brand
            Row(
                children: images
                    .map((image) => brandTopProductImageWidget(image, context))
                    .toList())
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: SHFRoundedContainer(
          height: 100,
          padding: const EdgeInsets.all(SHFSizes.md),
          margin: const EdgeInsets.only(right: SHFSizes.sm),
          backgroundColor: SHFHelperFunctions.isDarkMode(context)
              ? SHFColors.darkerGrey
              : SHFColors.light,
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const SHFShimmerEffect(width: 100, height: 100),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )),
    );
  }
}
