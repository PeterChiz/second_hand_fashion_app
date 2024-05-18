import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/styles/shadows.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_rounded_image.dart';
import 'package:second_hand_fashion_app/common/widgets/products/favourite_icon/favorites_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/widgets/add_to_cart_button.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/widgets/product_card_pricing_widget.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/widgets/product_sale_tag.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/shf_product_title_text.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/product_controller.dart';
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
    final salePercentage = productController.calculateSalePercentage(
        product.price, product.salePrice);
    final dark = SHFHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),

      /// Container có các lề bên, màu sắc, viền, bo góc và bóng.
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [SHFShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(SHFSizes.productImageRadius),
          color: dark ? SHFColors.darkerGrey : SHFColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Hình ảnh nhỏ, Nút Yêu thích, Thẻ Giảm giá
            SHFRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(SHFSizes.sm),
              backgroundColor: dark ? SHFColors.dark : SHFColors.light,
              child: Stack(
                children: [
                  /// -- Hình ảnh nhỏ
                  Center(
                      child: SHFRoundedImage(
                          imageUrl: product.thumbnail,
                          applyImageRadius: true,
                          isNetworkImage: isNetworkImage)),

                  /// -- Thẻ Giảm giá
                  if (salePercentage != null)
                    ProductSaleTagWidget(salePercentage: salePercentage),

                  /// -- Nút biểu tượng Yêu thích
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SHFFavoritesIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwItems / 2),

            /// -- Chi tiết
            Padding(
              padding: const EdgeInsets.only(left: SHFSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SHFProductTitleText(title: product.title, smallSize: true),
                  const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                  SHFBrandTitleWithVerifiedIcon(
                      title: product.brand!.name,
                      brandTextSize: TextSizes.small),
                ],
              ),
            ),

            /// Giá & Nút Thêm vào giỏ hàng
            /// Sử dụng Spacer() để tận dụng toàn bộ không gian và đặt giá và nút giỏ hàng ở phía dưới.
            /// Điều này thường xảy ra khi Tiêu đề Sản phẩm chỉ có một dòng hoặc 2 dòng (Tối đa)
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Giá cả
                PricingWidget(product: product),

                /// Thêm vào giỏ hàng
                ProductCardAddToCartButton(product: product),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
