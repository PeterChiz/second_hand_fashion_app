import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/category_shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/category_controller.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../sub_categories/sub_categories.dart';

/// Widget tiêu đề hiển thị các danh mục phổ biến.
class SHFHeaderCategories extends StatelessWidget {
  /// Constructor cho [SHFHeaderCategories].
  const SHFHeaderCategories({super.key, });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.only(left: SHFSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// -- Tiêu đề
          const SHFSectionHeading(title: 'Danh mục', textColor: SHFColors.white, showActionButton: false),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          /// Widget Obx để cập nhật giao diện người dùng theo trạng thái của [categoryController].
          /// Nó hiển thị một shimmer loader trong khi các danh mục đang được tải, hiển thị một thông báo nếu không tìm thấy dữ liệu,
          /// và vẽ một danh sách ngang các danh mục nổi bật với hình ảnh và văn bản.
          Obx(
                () {
              // Kiểm tra xem các danh mục có đang được tải không
              if (categoryController.isLoading.value) return const SHFCategoryShimmer();

              // Kiểm tra xem có danh mục nổi bật nào được tìm thấy không
              if (categoryController.featuredCategories.isEmpty) {
                return Center(child: Text('Không tìm thấy dữ liệu!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
              } else {
                /// Dữ liệu đã được tìm thấy
                // Hiển thị một danh sách ngang các danh mục nổi bật với hình ảnh và văn bản
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
