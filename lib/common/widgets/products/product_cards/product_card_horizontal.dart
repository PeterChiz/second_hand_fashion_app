import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_rounded_image.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_price_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/product_title_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_brand_title_text_with_verified_icon.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/shf_circular_icon.dart';

class SHFProductCardHorizontal extends StatelessWidget {
  const SHFProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
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
                const SizedBox(
                    width: 120,
                    height: 120,
                    child: SHFRoundedImage(
                      imageURL: SHFImages.productImage1,
                      applyImageRadius: true,
                    ),
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

          ///Details
           SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: SHFSizes.sm, left: SHFSizes.sm),
              child: Column(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SHFProductTitleText(title: 'Laptop Asus No1 Computer', smallSize: true,),
                      SizedBox(height: SHFSizes.spaceBtwItems/2),
                      SHFBrandTitleWithVerifiedIcon(title: 'Asus'),
                    ],
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Pricing
                      const Flexible(child: SHFProductPriceText(price: '256.0 - 30000.0')),

                      ///Add to cart
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
