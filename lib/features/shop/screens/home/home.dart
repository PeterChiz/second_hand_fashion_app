import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:second_hand_fashion_app/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
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
                  SHFSearchContainer(text: 'Search in Store'),
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
                          title: 'Popular Categories',
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
                ],
              ),
            ),

            ///Body
            Padding(
              padding: const EdgeInsets.all(SHFSizes.defaultSpace),
              child: Column(
                children: [
                  ///Promo Slider
                  const SHFPromoSlider(banner: [
                    SHFImages.promoBanner1,
                    SHFImages.promoBanner2,
                    SHFImages.promoBanner3,
                  ]),
                  const SizedBox(
                    height: SHFSizes.spaceBtwSections,
                  ),

                  ///Heading
                  SHFSectionHeading(title: 'Popular Products', onPressed: (){},),
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

