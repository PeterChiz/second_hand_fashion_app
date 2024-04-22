import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/category_controller.dart';
import 'package:second_hand_fashion_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_cart.dart';
import '../brand/all_brands.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: SHFAppBar(
          title: Text(
            'Store',
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
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
                          onPressed: () =>
                              Get.to(() => const ALlBrandsScreen())),
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
                bottom: SHFTabBar(
                    tabs: categories.map((category) =>
                        Tab(child: Text(category.name),)).toList()
                ),
              ),
            ];
          },

          ///Body
          body: TabBarView(
              children: categories.map((category) =>
                  SHFCategoryTab(category: category,)).toList()
          ),
        ),
      ),
    );
  }
}
