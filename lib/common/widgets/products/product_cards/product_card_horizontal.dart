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

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';

/// Một Card sản phẩm ngang của SHF.
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

      /// Container với khoảng cách padding bên cạnh, màu sắc, cạnh, bán kính và bóng.
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
            /// Hình thu nhỏ
            SHFRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(SHFSizes.sm),
              backgroundColor: isDark ? SHFColors.dark : SHFColors.light,
              child: Stack(
                children: [
                  /// -- Hình ảnh thu nhỏ
                  SHFRoundedImage(width: 120, height: 120, imageUrl: product.thumbnail, isNetworkImage: isNetworkImage),

                  /// -- Nhãn giảm giá
                  if (salePercentage != null) ProductSaleTagWidget(salePercentage: salePercentage),

                  /// -- Nút biểu tượng yêu thích
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SHFFavoritesIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SHFSizes.spaceBtwItems / 2),

            /// -- Chi tiết, Thêm vào giỏ hàng, & Định giá
            Container(
              padding: const EdgeInsets.only(left: SHFSizes.sm),
              width: 172,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Chi tiết
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

                  /// Giá & nút thêm vào giỏ hàng
                  /// Sử dụng Spacer() để tận dụng hết không gian và đặt giá và nút giỏ hàng ở dưới cùng.
                  /// Điều này thường xảy ra khi tiêu đề sản phẩm ở một hoặc hai dòng (Tối đa)
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Định giá
                      PricingWidget(product: product),

                      /// Thêm vào giỏ hàng
                      ProductCardAddToCartButton(product: product),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
