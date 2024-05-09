import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_rounded_image.dart';
import 'package:second_hand_fashion_app/common/widgets/products/favourite_icon/favorites_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/widgets/add_to_cart_button.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/widgets/product_card_pricing_widget.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/widgets/product_sale_tag.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_product_title_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_brand_title_text_with_verified_icon.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../features/shop/controllers/product/poduct_controller.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';

class SHFProductCardHorizontal extends StatelessWidget {
  const SHFProductCardHorizontal({super.key, required this.product, this.isNetworkImage=true});

  final ProductModel product;
  final bool isNetworkImage;


  @override
  Widget build(BuildContext context) {
    final isDark = SHFHelperFunctions.isDarkMode(context);
    final salePercentage = ProductController.instance.calculateSalePercentage(product.price, product.salePrice);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),

      /// Container with side paddings, color, edges, radius and shadow.
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SHFSizes.productImageRadius),
          color: SHFHelperFunctions.isDarkMode(context) ? SHFColors.darkerGrey : SHFColors.lightContainer,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail
            SHFRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(SHFSizes.sm),
              backgroundColor: isDark ? SHFColors.dark : SHFColors.light,
              child: Stack(
                children: [
                  /// -- Thumbnail Image
                  SHFRoundedImage(width: 120, height: 120, imageUrl: product.thumbnail, isNetworkImage: isNetworkImage),

                  /// -- Sale Tag
                  if (salePercentage != null) ProductSaleTagWidget(salePercentage: salePercentage),

                  /// -- Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SHFFavoritesIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwItems / 2),

            /// -- Details, Add to Cart, & Pricing
            Container(
              padding: const EdgeInsets.only(left: SHFSizes.sm),
              width: 172,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Details
                  Padding(
                    padding: const EdgeInsets.only(top: SHFSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SHFProductTitleText(
                          title: product.title,
                          smallSize: true,
                          maxLines: 2,
                        ),
                        const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                        SHFBrandTitleWithVerifiedIcon(title: product.brand!.name, brandTextSize: TextSizes.small),
                      ],
                    ),
                  ),

                  /// Price & Add to cart button
                  /// Use Spacer() to utilize all the space and set the price and cart button at the bottom.
                  /// This usually happens when Product title is in single line or 2 lines (Max)
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Pricing
                      PricingWidget(product: product),

                      /// Add to cart
                      ProductCardAddToCartButton(product: product),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );  }
}
