import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:second_hand_fashion_app/features/shop/screens/all_products/all_products.dart';
import 'package:second_hand_fashion_app/features/shop/screens/home/widgets/promo_slider.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            const SHFPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///Appbar
                  SHFHomeAppBar(),
                  SizedBox(
                    height: SHFSizes.spaceBtwSections,
                  ),

                  ///Searchbar
                  SHFSearchContainer(text: 'Tìm kiếm mặt hàng'),
                  SizedBox(
                    height: SHFSizes.spaceBtwSections,
                  ),

                  ///Categories
                  Padding(
                    padding: EdgeInsets.only(left: SHFSizes.defaultSpace),
                    child: Column(
                      children: [
                        ///Heading
                        SHFSectionHeading(
                          title: 'Danh mục phổ biến',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: SHFSizes.spaceBtwItems,
                        ),

                        ///Categories
                        SHFHomeCategories(),
                      ],
                    ),
                  ),
                   SizedBox(height: SHFSizes.spaceBtwSections,),

                ],
              ),
            ),

            ///Body
            Padding(
              padding: const EdgeInsets.all(SHFSizes.defaultSpace),
              child: Column(
                children: [
                  ///Promo Slider
                  const SHFPromoSlider(),
                  const SizedBox(
                    height: SHFSizes.spaceBtwSections,
                  ),

                  ///Heading
                  SHFSectionHeading(title: 'Popular Products', onPressed: () => Get.to(() => const AllProducts()),),
                  const SizedBox(
                    height: SHFSizes.spaceBtwSections,
                  ),

                  ///Popular Product
                  SHFGridLayout(itemCount: 2, itemBuilder: (_,index) => const SHFProductCardVertical(),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

