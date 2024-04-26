
import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/brands/brand_show_case.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/boxes_shimmer.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/list_tile_shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/brand_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/category_model.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          ///Handle loader, no record, or error message
          const loader = Column(
            children: [
              SHFListTileShimmer(),
              SizedBox(height: SHFSizes.spaceBtwItems,),
              SHFBoxesShimmer(),
              SizedBox(height: SHFSizes.spaceBtwItems,),
            ],
          );


          final widget = SHFCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          ///Record found
          final brands = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (_, index) {
              final brand = brands[index];
              return FutureBuilder(
                future: controller.getBrandProducts(
                    brandId: brand.id, limit: 3),
                builder: (context, snapshot) {

                  ///Handle loader, no record, or error message
                  final widget = SHFCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;

                  ///Record found
                  final products = snapshot.data!;

                  return SHFBrandShowcase(brand: brand,
                      images: products.map((e) => e.thumbnail).toList());
                },
              );
            },
          );
        }
    );
  }
}