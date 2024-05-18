import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/models/brand_model.dart';

import '../../../features/shop/screens/brand/brand.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_cart.dart';

/// Một widget giới thiệu một thương hiệu với 3 hình ảnh sản phẩm hàng đầu của nó.
class SHFBrandShowcase extends StatelessWidget {
  /// Constructor mặc định cho SHFBrandShowcase.
  ///
  /// Tham số:
  ///- brand: Mô hình thương hiệu để hiển thị.
  ///- images: Danh sách 3 hình ảnh sản phẩm hàng đầu cho thương hiệu.
  const SHFBrandShowcase({super.key, required this.brand, required this.images});

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(BrandScreen(brand: brand)),
      child: SHFRoundedContainer(
        margin: const EdgeInsets.only(bottom: SHFSizes.spaceBtwItems),
        showBorder: true,
        borderColor: SHFColors.darkGrey,
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            /// Thương hiệu với số lượng sản phẩm
            SHFBrandCard(showBorder: false, brand: brand),
            const SizedBox(height: SHFSizes.spaceBtwItems / 2),

            /// Hình ảnh 3 sản phẩm hàng đầu của thương hiệu
            Row(
                children: images
                    .map((e) => brandTopProductImageWidget(e, context))
                    .toList()),
          ],
        ),
      ),
    );
  }

  /// Widget để hiển thị hình ảnh sản phẩm hàng đầu cho thương hiệu.
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
        ),
      ),
    );
  }
}
