import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/category_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/category_model.dart';
import 'package:second_hand_fashion_app/features/shop/screens/all_products/all_products.dart';
import 'package:second_hand_fashion_app/features/shop/screens/store/widgets/category_brands.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';

class SHFCategoryTab extends StatelessWidget {
  const SHFCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Thương hiệu của Danh mục
              CategoryBrands(category: category),
              const SizedBox(height: SHFSizes.spaceBtwSections * 2),

              /// -- Sản phẩm Danh mục Bạn Có Thể Thích
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  /// Hàm hỗ trợ: Xử lý Hiển thị Loader, Không có Bản ghi, HOẶC Thông báo LỖI
                  final response = SHFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const SHFVerticalProductShimmer());
                  if (response != null) return response;

                  /// Bản ghi được tìm thấy!
                  final products = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SHFSectionHeading(
                        title: 'Bạn có thể thích',
                        showActionButton: true,
                        onPressed: () => Get.to(AllProducts(
                          title: category.name,
                          futureMethod: controller.getCategoryProducts(categoryId: category.id, limit: -1),
                        )),
                      ),
                      const SizedBox(height: SHFSizes.spaceBtwItems),
                      SHFGridLayout(
                        itemCount: products.length < 4 ? products.length : 4,
                        itemBuilder: (_, index) => SHFProductCardVertical(product: products[index], isNetworkImage: true),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: SHFSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
