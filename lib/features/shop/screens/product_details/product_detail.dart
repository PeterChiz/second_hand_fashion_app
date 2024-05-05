import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/common/widgets/products/cart/button_add_to_cart_widget.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/widgets/rating_share_widget.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../checkout/checkout.dart';
import '../product_reviews/product_reviews.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1 - Product Image Slider
            SHFProducSHFImageslider(product: product),

            /// 2 - Product Details
            Container(
              padding: const EdgeInsets.only(right: SHFSizes.defaultSpace, left: SHFSizes.defaultSpace, bottom: SHFSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// - Rating & Share
                  const SHFRatingAndShare(),

                  /// - Price, Title, Stock, & Brand
                  SHFProductMetaData(product: product),
                  const SizedBox(height: SHFSizes.spaceBtwSections / 2),

                  /// -- Attributes
                  // If Product has no variations do not show attributes as well.
                  if (product.productVariations != null && product.productVariations!.isNotEmpty) SHFProductAttributes(product: product),
                  if (product.productVariations != null && product.productVariations!.isNotEmpty) const SizedBox(height: SHFSizes.spaceBtwSections),

                  /// -- Checkout Button
                  SizedBox(
                    width: SHFDeviceUtils.getScreenWidth(context),
                    child: ElevatedButton(child: const Text('Thanh toán'), onPressed: () => Get.to(() => const CheckoutScreen())),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  /// - Description
                  const SHFSectionHeading(title: 'Mô tả', showActionButton: false),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  // Read more package
                  ReadMoreText(
                    product.description!,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Chi tiết',
                    trimExpandedText: ' Thu nhỏ',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  /// - Reviews
                  const Divider(),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SHFSectionHeading(title: 'Reviews (199)', showActionButton: false),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                        onPressed: () => Get.to(() => const ProductReviewsScreen(), fullscreenDialog: true),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SHFBottomAddToCart(product: product),
    );
  }
}

