import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/styles/shadows.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_rounded_image.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_price_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_title_text.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/product_detail.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../icons/shf_circular_icon.dart';
import '../../texts/shf_brand_title_text_with_verified_icon.dart';

class SHFProductCardVertical extends StatelessWidget {
  const SHFProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);

    ///Container with side paddings, color, edges. radius and shadow.
    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailScreen()),
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
              padding: const EdgeInsets.all(SHFSizes.sm),
              backgroundColor: dark ? SHFColors.dark : SHFColors.light,
              child: Stack(
                children: [
                  ///Thumbnail Image
                  const SHFRoundedImage(
                    imageURL: SHFImages.productImage1,
                    applyImageRadius: true,
                  ),

                  ///Sale Tag
                  Positioned(
                    top: 12,
                    child: SHFRoundedContainer(
                        radius: SHFSizes.sm,
                        backgroundColor: SHFColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: SHFSizes.sm, vertical: SHFSizes.xs),
                        child: Text(
                          '25%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: SHFColors.black),
                        )),
                  ),

                  ///Favourite Icon Button
                  const Positioned(
                      top: 0,
                      right: 0,
                      child: SHFCircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: SHFSizes.spaceBtwItems / 2,
            ),

            ///Details
            const Padding(
              padding: EdgeInsets.only(left: SHFSizes.sm),
              child: Column(
                children: [
                   SHFProductTitleText(
                    title: 'Laptop asus 1',
                    smallSize: true,
                  ),
                   SizedBox(
                    height: SHFSizes.spaceBtwItems / 2,
                  ),
                  SHFBrandTitleWithVerifiedIcon(title: 'Nike',),
                ],
              ),
            ),
            //Thêm Spacer() vào đây để giữ nguyên chiều cao của mỗi Box trong trường hợp 1 hoặc 2 dòng Heading
            const Spacer(),

            ///Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Price
                const Padding(
                  padding: EdgeInsets.only(left: SHFSizes.sm),
                  child: SHFProductPriceText(price: '35.0'),
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

