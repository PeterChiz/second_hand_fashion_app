import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_cart.dart';
import '../../../../common/widgets/brands/brand_show_case.dart';
import '../../../../common/widgets/images/shf_circular_image.dart';
import '../../../../common/widgets/texts/shf_brand_title_text_with_verified_icon.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: SHFAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            SHFCartCounterIcon(
              onPressed: () {},
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: SHFHelperFunctions.isDarkMode(context)
                    ? SHFColors.black
                    : SHFColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(SHFSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ///Search bar
                      const SizedBox(
                        height: SHFSizes.spaceBtwItems,
                      ),
                      const SHFSearchContainer(
                        text: 'Search in store',
                        showBackground: true,
                        showBorder: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: SHFSizes.spaceBtwSections,
                      ),

                      ///Featured Brands
                      SHFSectionHeading(
                          title: 'Featured Brand',
                          showActionButton: true,
                          onPressed: () {}),
                      const SizedBox(
                        height: SHFSizes.spaceBtwItems / 1.5,
                      ),

                      ///Brands GRID
                      SHFGridLayout(
                          itemCount: 4,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            return const SHFBrandCard(
                              showBorder: false,
                            );
                          })
                    ],
                  ),
                ),

                ///Tabs
                bottom: const SHFTabBar(tabs: [
                  Tab(child: Text('Sports'),),
                  Tab(child: Text('Furniture'),),
                  Tab(child: Text('Electronic'),),
                  Tab(child: Text('Clothes'),),
                  Tab(child: Text('Cosmetics'),),
                ],),
              ),
            ];
          },

          ///Body
          body:  const TabBarView(children: [
            SHFCategoryTab(),
            SHFCategoryTab(),
            SHFCategoryTab(),
            SHFCategoryTab(),

          ],),
        ),
      ),
    );
  }
}



