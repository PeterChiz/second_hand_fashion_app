import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_rounded_image.dart';
import 'package:second_hand_fashion_app/common/widgets/products/favourite_icon/favorites_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_price_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_title_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_brand_title_text_with_verified_icon.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../features/shop/controllers/product/poduct_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';

class SHFProductCardHorizontal extends StatelessWidget {
  const SHFProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final dark = SHFHelperFunctions.isDarkMode(context);
    final salePercentage = controller.calculateDiscountPercentage(product.price, product.salePrice);


    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(SHFSizes.productImageRadius),
        color: dark ? SHFColors.darkerGrey : SHFColors.lightContainer,
      ),
      child: Row(
        children: [
          ///Thumbnail
          SHFRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(SHFSizes.sm),
            backgroundColor: dark ? SHFColors.dark : SHFColors.white,
            child:  Stack(
              children: [
                ///Thumbnail Image
                 SizedBox(
                    width: 120,
                    height: 120,
                    child: SHFRoundedImage(
                      imageURL: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                ),

                ///Sale Tag
                if(salePercentage != null)
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
                    child: SHFFavoritesIcon(productId: product.id),
                )
              ],
            ),
          ),

          ///Details, add to cart, pricing
           SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: SHFSizes.sm, left: SHFSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SHFProductTitleText(title: product.title, smallSize: true,),
                      const SizedBox(height: SHFSizes.spaceBtwItems/2),
                      SHFBrandTitleWithVerifiedIcon(title: product.brand!.name),
                    ],
                  ),

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
          )
        ],
      ),
    );
  }
}
