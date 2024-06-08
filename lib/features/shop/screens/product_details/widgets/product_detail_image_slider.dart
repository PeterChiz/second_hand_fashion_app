import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';

import '../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../common/widgets/products/favourite_icon/favorites_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/images_controller.dart';
import '../../../models/product_model.dart';

class SHFProductImageSlider extends StatelessWidget {
  const SHFProductImageSlider({super.key, required this.product, this.isNetworkImage = true});

  final ProductModel product;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final controller = ImagesController.instance;
    final isDark = SHFHelperFunctions.isDarkMode(context);
    final images = controller.getAllProductImages(product);
    return SHFCurvedEdgesWidget(
      child: Container(
        color: isDark ? SHFColors.darkerGrey : SHFColors.light,
        child: Stack(
          children: [
            /// Ảnh đầu
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(SHFSizes.defaultSpace * 2),
                child: Center(
                  child: Obx(
                        () {
                      final image =
                      controller.selectedProductImage.value.isEmpty ? product.thumbnail : controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: isNetworkImage
                            ? CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress, color: SHFColors.primary),
                          errorWidget: (_, __, ___) => const Icon(Icons.error),
                        )
                            : Image(image: AssetImage(image)),
                      );
                    },
                  ),
                ),
              ),
            ),

            /// Ảnh lướt
            Positioned(
              right: 0,
              bottom: 30,
              left: SHFSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(width: SHFSizes.spaceBtwItems),
                  itemBuilder: (_, index) {
                    return Obx(
                          () {
                        final imageSelected = controller.selectedProductImage.value == images[index];
                        return SHFRoundedImage(
                          isNetworkImage: isNetworkImage,
                          width: 80,
                          fit: BoxFit.contain,
                          imageUrl: images[index],
                          padding: const EdgeInsets.all(SHFSizes.sm),
                          backgroundColor: isDark ? SHFColors.dark : SHFColors.white,
                          onPressed: () => controller.selectedProductImage.value = images[index],
                          border: Border.all(color: imageSelected ? SHFColors.primary : Colors.transparent),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            /// Appbar Icons
            SHFAppBar(showBackArrow: true, actions: [SHFFavoritesIcon(productId: product.id)]),
          ],
        ),
      ),
    );
  }
}
