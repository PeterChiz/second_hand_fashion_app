import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/category_shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/category_controller.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../sub_categories/sub_categories.dart';

/// A header widget displaying popular categories.
class SHFHeaderCategories extends StatelessWidget {
  /// Constructor for [SHFHeaderCategories].
  const SHFHeaderCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.only(left: SHFSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// -- Heading
          const SHFSectionHeading(title: 'Danh mục', textColor: SHFColors.white, showActionButton: false),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          /// Obx widget for reactive UI updates based on the state of [categoryController].
          /// It displays a shimmer loader while categories are being loaded, shows a message if no data is found,
          /// and renders a horizontal list of featured categories with images and text.
          Obx(
                () {
              // Check if categories are still loading
              if (categoryController.isLoading.value) return const SHFCategoryShimmer();

              // Check if there are no featured categories found
              if (categoryController.featuredCategories.isEmpty) {
                return Center(child: Text('Không tìm thấy dữ liệu!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
              } else {

                /// Data Found
                // Display a horizontal list of featured categories with images and text
                return SizedBox(
                  height: 80,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categoryController.featuredCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final category = categoryController.featuredCategories[index];
                      return SHFVerticalImageAndText(
                        title: category.name,
                        image: category.image,
                        onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
