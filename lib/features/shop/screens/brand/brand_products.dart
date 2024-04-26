import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/brands/brand_cart.dart';
import 'package:second_hand_fashion_app/common/widgets/products/sortable/sortable_products.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/brand_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/brand_model.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return  Scaffold(
      appBar:  SHFAppBar(
        title: Text(brand.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SHFSizes.defaultSpace),
        child: Column(
          children: [
            ///Brand Detail
            SHFBrandCard(showBorder: true, brand: brand),
            const SizedBox(height: SHFSizes.spaceBtwSections,),

            FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id),
              builder: (context, snapshot) {
                ///Handle loader, No record, or error message
                const loader = SHFVerticalProductShimmer();
                final widget = SHFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                if(widget != null) return widget;

                ///Record found
                final brandProducts = snapshot.data!;
                return SHFSortableProducts(products: brandProducts);
              }
            ),
          ],
        ),
      ),
    );
  }
}
