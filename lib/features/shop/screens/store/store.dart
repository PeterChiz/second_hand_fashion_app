import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/brands_shimmer.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/brand_controller.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/category_controller.dart';
import 'package:second_hand_fashion_app/features/shop/screens/brand/brand_products.dart';
import 'package:second_hand_fashion_app/features/shop/screens/cart/cart.dart';
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
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: SHFAppBar(
            title: Text(
              'Cửa hàng',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            actions: const [SHFCartCounterIcon()]),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                //phan cach giua appbar va tabbar
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
                        text: 'Tìm kiếm trong cửa hàng',
                        showBackground: true,
                        showBorder: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: SHFSizes.spaceBtwSections,
                      ),

                      ///Featured Brands
                      SHFSectionHeading(
                          title: 'Thương hiệu nổi bật',
                          onPressed: () =>
                              Get.to(() => const ALlBrandsScreen())),
                      const SizedBox(
                        height: SHFSizes.spaceBtwItems / 1.5,
                      ),

                      ///Brands GRID
                      Obx(() {
                        if (brandController.isLoading.value)
                          return const SHFBrandsShimmer();

                        if (brandController.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              'không tìm thấy dữ liệu',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }

                        return SHFGridLayout(
                            itemCount: brandController.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand =
                                  brandController.featuredBrands[index];
                              return SHFBrandCard(
                                brand: brand,
                                showBorder: true,
                                onTap: () =>
                                    Get.to(() => BrandProducts(brand: brand)),
                              );
                            });
                      })
                    ],
                  ),
                ),

                ///Tabs
                bottom: SHFTabBar(
                    tabs: categories
                        .map((category) => Tab(
                              child: Text(category.name),
                            ))
                        .toList()),
              ),
            ];
          },

          ///Body
          body: TabBarView(
              children: categories
                  .map((category) => SHFCategoryTab(
                        category: category,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
