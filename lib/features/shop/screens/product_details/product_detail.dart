import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            /// 1 - Trình chiếu ảnh sản phẩm
            SHFProductImageSlider(product: product),

            /// 2 - Chi tiết sản phẩm
            Container(
              padding: const EdgeInsets.only(right: SHFSizes.defaultSpace, left: SHFSizes.defaultSpace, bottom: SHFSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// - Đánh giá & Chia sẻ
                  const SHFRatingAndShare(),

                  /// - Giá, Tiêu đề, Kho hàng, & Thương hiệu
                  SHFProductMetaData(product: product),
                  const SizedBox(height: SHFSizes.spaceBtwSections / 2),

                  /// -- Thuộc tính
                  // Nếu sản phẩm không có biến thể thì cũng không hiển thị thuộc tính.
                  if (product.productVariations != null && product.productVariations!.isNotEmpty) SHFProductAttributes(product: product),
                  if (product.productVariations != null && product.productVariations!.isNotEmpty) const SizedBox(height: SHFSizes.spaceBtwSections),

                  /// -- Nút Thanh toán
                  SizedBox(
                    width: SHFDeviceUtils.getScreenWidth(context),
                    child: ElevatedButton(child: const Text('Thanh toán'), onPressed: () => Get.to(() => const CheckoutScreen())),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  /// - Mô tả
                  const SHFSectionHeading(title: 'Mô tả', showActionButton: false),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  // Gói Read more
                  ReadMoreText(
                    product.description!,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Xem thêm',
                    trimExpandedText: ' Thu gọn',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections),
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

