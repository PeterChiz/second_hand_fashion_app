import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_rounded_image.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/horizontal_product_shimmer.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/category_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/category_model.dart';
import 'package:second_hand_fashion_app/features/shop/screens/all_products/all_products.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';

import '../products/product_cards/product_card_horizontal.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: SHFAppBar(title: Text(category.name), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(SHFSizes.defaultSpace),
        child: Column(
          children: [
            ///Banner
            const SHFRoundedImage(
                width: double.infinity,
                imageURL: SHFImages.promoBanner3,
                applyImageRadius: true),
            const SizedBox(height: SHFSizes.spaceBtwSections),

            ///Sub-Categories
            FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {
                  ///Handle loader, no record, or error message
                  const loader = SHFHorizontalProductShimmer();
                  final widget = SHFCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  ///Record found
                  final subCategories = snapshot.data!;

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final subCategory = subCategories[index];
                        return FutureBuilder(
                            future: controller.getCategoryProducts(
                                categoryId: subCategory.id),
                            builder: (context, snapshot) {
                              ///Handle loader, no record, or error message
                              final widget =
                                  SHFCloudHelperFunctions.checkMultiRecordState(
                                      snapshot: snapshot, loader: loader);
                              if (widget != null) return widget;

                              /// Record found
                              final products = snapshot.data!;

                              return Column(
                                children: [
                                  ///Heading
                                  SHFSectionHeading(
                                      title: subCategory.name,
                                      onPressed: () => Get.to(() => AllProducts(
                                            title: subCategory.name,
                                            futureMethod:
                                                controller.getCategoryProducts(
                                                    categoryId: subCategory.id,
                                                    limit: -1),
                                          ))),
                                  const SizedBox(
                                      height: SHFSizes.spaceBtwItems / 2),

                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                        itemCount: products.length,
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                                width: SHFSizes.spaceBtwItems),
                                        itemBuilder: (context, index) =>
                                            SHFProductCardHorizontal(
                                                product: products[index])),
                                  ),
                                  const SizedBox(
                                      height: SHFSizes.spaceBtwSections)
                                ],
                              );
                            });
                      });
                })
          ],
        ),
      ),
    );
  }
}
