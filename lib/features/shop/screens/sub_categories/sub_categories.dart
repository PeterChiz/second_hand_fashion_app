import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/horizontal_product_shimmer.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/category_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/category_model.dart';
import 'package:second_hand_fashion_app/features/shop/screens/all_products/all_products.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart';
import '../../../../data/repositories/product/product_repository.dart';


class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key,  required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: SHFAppBar(showBackArrow: true, title: Text(category.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [

              /// Danh mục Con
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (_, snapshot) {
                  /// Xử lý Tiến trình Tải, Không có Bản ghi, HOẶC Thông báo Lỗi
                  const loader = SHFHorizontalProductShimmer();
                  final widget = SHFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  /// Bản ghi được tìm thấy.
                  final subCategories = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];

                      /// Lấy Sản phẩm của Danh mục
                      return FutureBuilder(
                        future: controller.getCategoryProducts(categoryId: subCategory.id),
                        builder: (_, snapshot) {
                          /// Xử lý Tiến trình Tải, Không có Bản ghi, HOẶC Thông báo Lỗi
                          final widget = SHFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                          if (widget != null) return widget;

                          /// Chúc mừng
                          final products = snapshot.data!;
                          return Column(
                            children: [
                              /// Tiêu đề Danh mục Con
                              SHFSectionHeading(
                                title: subCategory.name,
                                showActionButton: true,
                                onPressed: () => Get.to(() => AllProducts(
                                  title: subCategory.name,
                                  futureMethod: ProductRepository.instance.getProductsForCategory(categoryId: subCategory.id, limit: -1),
                                )),
                              ),
                              const SizedBox(height: SHFSizes.spaceBtwItems / 2),

                              /// Sản phẩm Danh mục Con
                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: products.length,
                                  separatorBuilder: (context, index) => const SizedBox(width: SHFSizes.spaceBtwItems),
                                  itemBuilder: (context, index) => SHFProductCardHorizontal(product: products[index]),
                                ),
                              ),
                              const SizedBox(height: SHFSizes.spaceBtwSections),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
