import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/styles/shadows.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_rounded_image.dart';
import 'package:second_hand_fashion_app/common/widgets/products/favourite_icon/favorites_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/widgets/add_to_cart_button.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/widgets/product_card_pricing_widget.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/widgets/product_sale_tag.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_product_title_text.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/poduct_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/product_detail.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../texts/shf_brand_title_text_with_verified_icon.dart';

class SHFProductCardVertical extends StatelessWidget {
  const SHFProductCardVertical(
      {super.key, required this.product, this.isNetworkImage = true});

  final ProductModel product;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final dark = SHFHelperFunctions.isDarkMode(context);
    final salePercentage = productController.calculateSalePercentage(
        product.price, product.salePrice);

    ///Container với side paddings, color, edges, radius and shadow.
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),

      /// Container with side paddings, color, edges, radius and shadow.
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [SHFShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(SHFSizes.productImageRadius),
          color: dark ? SHFColors.darkGrey : SHFColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail, Wishlist Button, Discount Tag
            SHFRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(SHFSizes.sm),
              backgroundColor: dark ? SHFColors.dark : SHFColors.light,
              child: Stack(
                children: [
                  ///Thumbnail Image
                  Center(
                    child: SHFRoundedImage(
                      applyImageRadius: true,
                      isNetworkImage: isNetworkImage,
                      imageUrl: product.thumbnail,
                    ),
                  ),

                  /// -- Sale Tag
                  if (salePercentage != null) ProductSaleTagWidget(salePercentage: salePercentage),

                  ///Favourite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SHFFavoritesIcon(
                      productId: product.id,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: SHFSizes.spaceBtwItems / 2,
            ),

            ///Details
            Padding(
              padding: const EdgeInsets.only(left: SHFSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SHFProductTitleText(title: product.title, smallSize: true),
                  const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                  SHFBrandTitleWithVerifiedIcon(title: product.brand!.name, brandTextSize: TexSHFSizes.small),
                ],
              ),
            ),
            //Thêm Spacer() vào đây để giữ nguyên chiều cao của mỗi Box trong trường hợp 1 hoặc 2 dòng Heading
            /// Price & Add to cart button
            /// Use Spacer() to utilize all the space and set the price and cart button at the bottom.
            /// This usually happens when Product title is in single line or 2 lines (Max)
            const Spacer(),

            ///Price Row
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
    );
  }
}
