import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/brands/brand_cart.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/brand_controller.dart';
import 'package:second_hand_fashion_app/features/shop/screens/brand/brand_products.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../../../../common/widgets/shimmers/brands_shimmer.dart';

class ALlBrandsScreen extends StatelessWidget {
  const ALlBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const SHFAppBar(
        title: Text('Brand'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              ///Heading
              const SHFSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(
                height: SHFSizes.spaceBtwItems,
              ),

              ///Brands
              Obx(() {
                if (brandController.isLoading.value) return const SHFBrandsShimmer();

                if (brandController.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'không tìm thấy dữ liệu',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ),
                  );
                }

                return SHFGridLayout(
                    itemCount: brandController.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final brand =
                      brandController.allBrands[index];
                      return SHFBrandCard(
                        brand: brand,
                        showBorder: true,
                        onTap: () => Get.to(() =>  BrandProducts(brand: brand,)),
                      );
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
