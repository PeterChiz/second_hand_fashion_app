import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../common/widgets/images/shf_circular_image.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/category_shimmer.dart';
import '../../../../common/widgets/shimmers/search_category_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/brand_controller.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/search_controller.dart';
import '../../models/category_model.dart';
import '../all_products/all_products.dart';
import '../brand/brand.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchController = Get.put(SHFSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SHFAppBar(
        title: Text('Tìm kiếm', style: Theme.of(context).textTheme.headlineMedium),
        actions: [TextButton(onPressed: () => Get.back(), child: const Text('Thoát'))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Thanh tìm kiếm và Nút Lọc
              Row(
                children: [
                  /// Tìm kiếm
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      onChanged: (query) =>
                          searchController.searchProducts(query),
                      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.search_normal), hintText: 'Tìm kiếm'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              /// Kết quả tìm kiếm
              Obx(
                    () => searchController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : searchController.searchResults.isNotEmpty
                    ? SHFGridLayout(
                  itemCount: searchController.searchResults.length,
                  itemBuilder: (_, index) => SHFProductCardVertical(product: searchController.searchResults[index]),
                )
                    : brandsAndCategories(context),
              ),

              const SizedBox(height: SHFSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget thương hiệu và danh mục
  Column brandsAndCategories(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categoryController = Get.put(CategoryController());
    final isDark = SHFHelperFunctions.isDarkMode(context);
    return Column(
      children: [

        /// Danh mục
        const SHFSectionHeading(title: 'Danh mục', showActionButton: false),
        const SizedBox(height: SHFSizes.spaceBtwItems),

        /// Obx widget để cập nhật giao diện người dùng theo trạng thái của [categoryController].
        /// Hiển thị hiệu ứng shimmer khi danh mục đang được tải, hiển thị thông báo nếu không tìm thấy dữ liệu,
        /// và hiển thị danh sách danh mục nổi bật dưới dạng danh sách ngang với hình ảnh và văn bản.
        Obx(
              () {
            if (categoryController.isLoading.value) return const SHFSearchCategoryShimmer();

            if (categoryController.allCategories.isEmpty) {
              return Center(child: Text('Không tìm thấy dữ liệu!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
            } else {
              final categories = categoryController.allCategories;
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: SHFSizes.spaceBtwItems),
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (_, index) => GestureDetector(
                  onTap: () => Get.to(() => AllProducts(title: categories[index].name, futureMethod: categoryController.getCategoryProducts(categoryId: categories[index].id))),
                  child: Row(
                    children: [
                      SHFCircularImage(
                        width: 25,
                        height: 25,
                        padding: 0,
                        isNetworkImage: true,
                        overlayColor: isDark ? SHFColors.white : SHFColors.dark,
                        image: categories[index].image,
                      ),
                      const SizedBox(width: SHFSizes.spaceBtwItems / 2),
                      Text(categories[index].name)
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
