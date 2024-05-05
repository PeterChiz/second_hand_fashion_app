import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/products/favourite_icon/favorites_icon.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/images_controller.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_model.dart';

class SHFProducSHFImageslider extends StatelessWidget {
  const SHFProducSHFImageslider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProducSHFImages(product);
    return SHFCurvedEdgeWidget(
      child: Container(
        color: dark ? SHFColors.darkerGrey : SHFColors.light,
        child: Stack(
          children: [
            ///Main Large Image
            SizedBox(
                height: 400,
                child: Padding(
                  padding:
                      const EdgeInsets.all(SHFSizes.productImageRadius * 2),
                  child: Center(child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: SHFColors.primary,
                        ),
                      ),
                    );
                  })),
                )),

            ///Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: SHFSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: SHFSizes.spaceBtwItems),
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return SHFRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      padding: const EdgeInsets.all(SHFSizes.sm),
                      backgroundColor: dark ? SHFColors.dark : SHFColors.white,
                      border: Border.all(
                          color: imageSelected
                              ? SHFColors.primary
                              : Colors.transparent),
                      imageUrl: images[index],
                    );
                  }),
                ),
              ),
            ),

            ///Appbar Icons
            SHFAppBar(
              showBackArrow: true,
              actions: [
                SHFFavoritesIcon(
                  productId: product.id,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
