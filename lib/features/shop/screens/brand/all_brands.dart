import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/brands/brand_cart.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/brand_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../../../../common/widgets/shimmers/brands_shimmer.dart';
import 'brand.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: const SHFAppBar(
        title: Text('Thương hiệu'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              /// Danh mục con
              const SHFSectionHeading(
                title: 'Thương hiệu',
                showActionButton: false,
              ),
              const SizedBox(
                height: SHFSizes.spaceBtwItems,
              ),

              /// Thương hiệu
              Obx(
                () {
                  // Kiểm tra nếu thương hiệu đang được tải
                  if (controller.isLoading.value)
                    return const SHFBrandsShimmer();

                  // Kiểm tra nếu không có thương hiệu nào được tìm thấy
                  if (controller.allBrands.isEmpty) {
                    return Center(
                        child: Text('Chưa có dữ liệu!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: Colors.white)));
                  } else {
                    /// Dữ liệu được tìm thấy
                    return SHFGridLayout(
                      itemCount: controller.allBrands.length,
                      mainAxisExtent: 80,
                      itemBuilder: (_, index) {
                        final brand = controller.allBrands[index];
                        return SHFBrandCard(
                          brand: brand,
                          showBorder: true,
                          onTap: () => Get.to(() => BrandScreen(brand: brand)),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
