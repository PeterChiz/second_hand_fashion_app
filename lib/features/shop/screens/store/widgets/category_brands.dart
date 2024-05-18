import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/brands/brand_show_case.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/boxes_shimmer.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/list_tile_shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/brand_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/category_model.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: BrandController.instance.getBrandsForCategory(category.id),
      builder: (_, snapshot) {
        /// Xử lý hiển thị Loader, Không có bản ghi hoặc thông báo lỗi
        const loader = Column(
          children: [
            SHFListTileShimmer(),
            SizedBox(height: SHFSizes.spaceBtwItems),
            SHFBoxesShimmer(),
            SizedBox(height: SHFSizes.spaceBtwItems),
          ],
        );
        final widget = SHFCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, loader: loader);
        if (widget != null) return widget;

        /// Bản ghi được tìm thấy!
        final brands = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];

            /// Tải Sản phẩm Thương hiệu
            return FutureBuilder(
              future: controller.getBrandProducts(brand.id, 3),
              builder: (_, snapshot) {
                /// Xử lý hiển thị Loader, Không có bản ghi hoặc thông báo lỗi
                final widget = SHFCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);
                if (widget != null) return widget;

                /// Bản ghi được tìm thấy!
                final products = snapshot.data!;
                return SHFBrandShowcase(
                  brand: brand,
                  images: products.map((e) => e.thumbnail).toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}
