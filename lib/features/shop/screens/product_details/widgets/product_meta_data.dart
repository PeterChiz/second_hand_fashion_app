import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_circular_image.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_product_price_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_product_title_text.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_brand_title_text_with_verified_icon.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/poduct_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SHFProductMetaData extends StatelessWidget {
  const SHFProductMetaData({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = ProductController.instance.calculateSalePercentage(product.price, product.salePrice);
    final darkMode = SHFHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// -- Sale Tag
            if (salePercentage != null)
              Row(
                children: [
                  SHFRoundedContainer(
                    backgroundColor: SHFColors.secondary,
                    radius: SHFSizes.sm,
                    padding: const EdgeInsets.symmetric(horizontal: SHFSizes.sm, vertical: SHFSizes.xs),
                    child: Text('$salePercentage%',
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: SHFColors.black)),
                  ),
                  const SizedBox(width: SHFSizes.spaceBtwItems)
                ],
              ),


            // Actual Price if sale price not null.
            if ((product.productVariations == null || product.productVariations!.isEmpty) && product.salePrice> 0.0)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.price.toString(), style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
                  const SizedBox(width: SHFSizes.spaceBtwItems)
                ],
              ),

            // Price, Show sale price as main price if sale exist.
            SHFProductPriceText(price: controller.getProductPrice(product), isLarge: true),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems / 1.5),
        SHFProductTitleText(title: product.title),
        const SizedBox(height: SHFSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            const SHFProductTitleText(title: 'Stock : ', smallSize: true),
            Text(controller.getProductStockStatus(product), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems / 2),

        /// Brand
        Row(
          children: [
            SHFCircularImage(
              width: 32,
              height: 32,
              isNetworkImage: true,
              image: product.brand!.image,
              overlayColor: darkMode ? SHFColors.white : SHFColors.black,
            ),
            SHFBrandTitleWithVerifiedIcon(title: product.brand!.name, brandTextSize: TexSHFSizes.medium),
          ],
        ),
      ],
    );
  }
}
