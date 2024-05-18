import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/brands/brand_cart.dart';
import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/brand_controller.dart';
import '../../models/brand_model.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: const SHFAppBar(showBackArrow: true, title: Text('Thương hiệu')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              ///
              SHFBrandCard(brand: brand, showBorder: true),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              /// Danh mục con
              const SHFSectionHeading(title: 'Sản phẩm', showActionButton: false),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              FutureBuilder(
                future: controller.getBrandProducts(brand.id, -1),
                builder: (context, snapshot) {
                  /// Xử lý Loader, Không có Bản ghi, HOẶC Thông báo Lỗi
                  const loader = SHFVerticalProductShimmer();
                  final widget = SHFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  /// Bản ghi được tìm thấy!
                  final brandProducts = snapshot.data!;
                  return SHFSortableProducts(products: brandProducts);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
