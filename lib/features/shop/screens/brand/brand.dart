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
      appBar: const SHFAppBar(showBackArrow: true, title: Text('Brand')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              SHFBrandCard(brand: brand, showBorder: true),
              const SizedBox(height: SHFSizes.spaceBtwSections),

              /// Sub Categories
              const SHFSectionHeading(title: 'Products', showActionButton: false),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              FutureBuilder(
                  future: controller.getBrandProducts(brand.id, -1),
                  builder: (context, snapshot) {
                    /// Handle Loader, No Record, OR Error Message
                    const loader = SHFVerticalProductShimmer();
                    final widget = SHFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    /// Record Found!
                    final brandProducts = snapshot.data!;
                    return SHFSortableProducts(products: brandProducts);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}