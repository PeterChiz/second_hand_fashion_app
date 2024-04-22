import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/category_shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/category_controller.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../common/widgets/sub_categories/sub_categories.dart';
import '../../../../../utils/constants/image_strings.dart';

class SHFHomeCategories extends StatelessWidget {
  const SHFHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if(categoryController.isLoading.value) return const SHFCategoryShimmer();

      if(categoryController.featuredCategories.isEmpty){
        return Center(child: Text('Không tìm thấy dữ liệu!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return SHFVerticalImageText(
                image: category.image,
                title: category.name,
                onTap: () => Get.to(() => const SubCategoriesScreen()),
              );
            }),
      );
    });
  }
}
