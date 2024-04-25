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
import 'package:second_hand_fashion_app/utils/constants/enums.dart';

import '../../../../utils/constants/sizes.dart';
import '../product_reviews/product_reviews.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: const SHFBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///1. Product Image Slider
             SHFProductImageSlider(product: product,),

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
                  SHFProductMetaData(product: product,),
                  ///Attributes
                  if(product.productType == ProductType.variable.toString())  ProductAttributes(product: product,),
                  if(product.productType == ProductType.variable.toString()) const SizedBox(height: SHFSizes.spaceBtwSections,),
                  ///Checkout Button
                  SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: const Text('Checkout'))),
                  const SizedBox(height: SHFSizes.spaceBtwSections,),
                  ///Description
                  const SHFSectionHeading(title: 'Description',showActionButton: false,),
                  const SizedBox(height: SHFSizes.spaceBtwItems),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
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

