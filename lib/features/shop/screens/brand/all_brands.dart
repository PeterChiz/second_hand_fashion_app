import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/brands/brand_cart.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/screens/brand/brand_products.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class ALlBrandsScreen extends StatelessWidget {
  const ALlBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              SHFGridLayout(
                  itemCount: 10,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) => SHFBrandCard(
                        showBorder: true,
                        onTap: () => Get.to(() => const BrandProducts()),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
