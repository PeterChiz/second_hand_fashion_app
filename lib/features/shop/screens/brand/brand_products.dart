import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/brands/brand_cart.dart';
import 'package:second_hand_fashion_app/common/widgets/products/sortable/sortable_products.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SHFAppBar(
        title: Text('Nike'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SHFSizes.defaultSpace),
        child: Column(
          children: [
            ///Brand Detail
            SHFBrandCard(showBorder: true),
            SizedBox(height: SHFSizes.spaceBtwSections,),

            SHFSortableProducts(products: [],),
          ],
        ),
      ),
    );
  }
}
