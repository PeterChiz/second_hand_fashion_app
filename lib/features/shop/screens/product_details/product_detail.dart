import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/widgets/button_add_to_cart_widget.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:second_hand_fashion_app/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/sizes.dart';
import '../product_reviews/product_reviews.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return  Scaffold(
      bottomNavigationBar: const SHFBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///1. Product Image Slider
            const SHFProductImageSlider(),

            ///2. Product Details
            Padding(
              padding: const EdgeInsets.only(
                  right: SHFSizes.defaultSpace,
                  left: SHFSizes.defaultSpace,
                  bottom: SHFSizes.defaultSpace),
              child: Column(
                children: [
                  ///Rating & Share Button
                  const SHFRatingAndShare(),
                  ///Price, Title, Stack &  Brand
                  const SHFProductMetaData(),
                  ///Attributes
                  const ProductAttributes(),
                  const SizedBox(height: SHFSizes.spaceBtwSections,),
                  ///Checkout Button
                  SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: const Text('Checkout'))),
                  const SizedBox(height: SHFSizes.spaceBtwSections,),
                  ///Description
                  const SHFSectionHeading(title: 'Description',showActionButton: false,),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  const ReadMoreText(
                    'Laptop Asus ROG Strix SCAR III G731G_N-WH100T (Core i7-9750H/ 16GB (8GB x2) DDR4 2666MHz/ 1TB SSD PCIE G3X4/ RTX 2070 8GB/ 17.3 FHD IPS, 240Hz/3ms/ Win10) - Hàng Chính Hãng với màu xám súng, thanh thoát là nơi hợp nhất giữa hiệu quả và sự cải tiến. Thiết kế mang tính chiến lược của mẫu máy laptop gaming này có nguồn cảm hứng đến từ sự cộng tác với Nhóm BMW Designworks và giúp kiến tạo nên lợi thế làm mát với Vùng lưu thông khí 3D. Mặt trong với họa tiết cacbon tinh tế nổi bật với hệ thống ánh sáng Aura Sync tỏa rộng khắp trên dải đèn mới bao quanh máy, bàn phím và logo ROG. Dù bạn đang chuẩn bị cho một cuộc đấu hay tham gia vào một trò chơi nhanh thì cỗ máy vỏ kim loại này đều được tinh chỉnh tuyệt vời và sẵn sàng hành động.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  ///Reviews
                  const Divider(),
                  const SizedBox(height: SHFSizes.spaceBtwItems,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SHFSectionHeading(title: 'Review(3)', showActionButton: false,),
                      IconButton(onPressed: () => Get.to(() => const ProductReviewScreen()), icon: const Icon(Iconsax.arrow_right_3,size: 18,)),
                    ],
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

