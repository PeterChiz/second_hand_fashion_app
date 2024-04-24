import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/models/category_model.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';

import '../../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class SHFCategoryTab extends StatelessWidget {
  const SHFCategoryTab({
    super.key, required this.category,
  });

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return  ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            children: [
              ///Brands
              const SHFBrandShowcase(
                images: [
                  SHFImages.productImage26,
                  SHFImages.productImage21,
                  SHFImages.productImage25,
                ],
              ),
              const SHFBrandShowcase(
                images: [
                  SHFImages.productImage3,
                  SHFImages.productImage2,
                  SHFImages.productImage1,
                ],
              ),
              ///Products
              SHFSectionHeading(title: 'Bạn có thể thích', onPressed: (){},),
              const SizedBox(height: SHFSizes.spaceBtwItems,),

              SHFGridLayout(itemCount: 4, itemBuilder: (_,index) =>  SHFProductCardVertical(product: ProductModel.empty(),)),
            ],
          ),
        ),
      ],
    );
  }
}
