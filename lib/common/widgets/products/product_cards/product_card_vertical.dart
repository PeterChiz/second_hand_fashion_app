import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/styles/shadows.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_rounded_image.dart';
import 'package:second_hand_fashion_app/common/widgets/products/favourite_icon/favorites_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_price_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_title_text.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/poduct_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/product_detail.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../texts/shf_brand_title_text_with_verified_icon.dart';

class SHFProductCardVertical extends StatelessWidget {
  const SHFProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final dark = SHFHelperFunctions.isDarkMode(context);
    final salePercentage = controller.calculateDiscountPercentage(
        product.price, product.salePrice);

    ///Container với side paddings, color, edges, radius and shadow.
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
            product: product,
          )),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [SHFShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(SHFSizes.productImageRadius),
          color: dark ? SHFColors.darkGrey : SHFColors.white,
        ),
        child: Column(
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
                      imageURL: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  ///Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: SHFRoundedContainer(
                          radius: SHFSizes.sm,
                          backgroundColor: SHFColors.secondary.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: SHFSizes.sm, vertical: SHFSizes.xs),
                          child: Text(
                            '$salePercentage%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: SHFColors.black),
                          )),
                    ),

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
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SHFProductTitleText(
                      title: product.title,
                      smallSize: true,
                    ),
                    const SizedBox(
                      height: SHFSizes.spaceBtwItems / 2,
                    ),
                    SHFBrandTitleWithVerifiedIcon(title: product.brand!.name),
                  ],
                ),
              ),
            ),
            //Thêm Spacer() vào đây để giữ nguyên chiều cao của mỗi Box trong trường hợp 1 hoặc 2 dòng Heading
            const Spacer(),

            ///Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Price
                Flexible(
                  child: Column(
                    children: [
                      if (product.productType ==
                              ProductType.single.toString() &&
                          product.salePrice > 0)
                        const Padding(
                            padding: EdgeInsets.only(left: SHFSizes.sm)),

                      ///Price, Show sale price as main price if sale exist
                      Padding(
                        padding: const EdgeInsets.only(left: SHFSizes.sm),
                        child: SHFProductPriceText(
                            price: controller.getProductPrice(product)),
                      ),
                    ],
                  ),
                ),

                ///Add to Cart Button
                Container(
                  decoration: const BoxDecoration(
                    color: SHFColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(SHFSizes.cardRadiusMd),
                      bottomRight: Radius.circular(SHFSizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                      width: SHFSizes.iconLg * 1.2,
                      height: SHFSizes.iconLg * 1.2,
                      child: Center(
                        child: Icon(
                          Iconsax.add,
                          color: SHFColors.white,
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
