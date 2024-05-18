import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/layouts/grid_layout.dart';
import 'package:second_hand_fashion_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/brands_shimmer.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/brand_controller.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/category_controller.dart';
import 'package:second_hand_fashion_app/features/shop/screens/store/widgets/category_tab.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_cart.dart';
import '../brand/all_brands.dart';
import '../brand/brand.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    final brandController = Get.put(BrandController());
    final dark = SHFHelperFunctions.isDarkMode(context);
    return PopScope(
      canPop: false,
      // Chặn việc nhấn nút quay lại và chuyển hướng về Màn hình Trang chủ
      onPopInvoked: (value) async => Get.offAll(const NavigationMenu()),
      child: DefaultTabController(
        length: categories.length,
        child: Scaffold(
          /// -- Appbar
          appBar: SHFAppBar(
            title: Text('Cửa hàng',
                style: Theme.of(context).textTheme.headlineMedium),
            actions: const [SHFCartCounterIcon()],
          ),
          body: NestedScrollView(
            /// -- Header
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  // Khoảng cách giữa Appbar và TabBar. Trong chiều cao này, chúng tôi đã thêm [thanh tìm kiếm] và [thương hiệu nổi bật]
                  expandedHeight: 350,
                  automaticallyImplyLeading: false,
                  backgroundColor: dark ? SHFColors.black : SHFColors.white,

                  /// -- Thương hiệu Nổi bật
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(SHFSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        /// -- Thương Hiệu Nổi Bật
                        SHFSectionHeading(
                            title: 'Thương hiệu phổ biến',
                            onPressed: () =>
                                Get.to(() => const AllBrandsScreen())),
                        const SizedBox(height: SHFSizes.spaceBtwItems / 1.5),

                        /// -- Thương hiệu
                        Obx(
                          () {
                            // Kiểm tra xem danh mục đang được tải
                            if (brandController.isLoading.value) return const SHFBrandsShimmer();

                            // Kiểm tra xem có danh mục nổi bật nào không
                            if (brandController.featuredBrands.isEmpty) {
                              return Center(
                                  child: Text('Không tìm thấy dữ liệu',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .apply(color: Colors.white)));
                            } else {
                              /// Dữ liệu được tìm thấy
                              return SHFGridLayout(
                                itemCount: 4,
                                mainAxisExtent: 80,
                                itemBuilder: (_, index) {
                                  final brand =
                                      brandController.featuredBrands[index];
                                  return SHFBrandCard(
                                    brand: brand,
                                    showBorder: true,
                                    onTap: () =>
                                        Get.to(() => BrandScreen(brand: brand)),
                                  );
                                },
                              );
                            }
                          },
                        ),
                        const SizedBox(height: SHFSizes.spaceBtwSections),
                      ],
                    ),
                  ),

                  /// -- TABS
                  bottom: SHFTabBar(
                      tabs: categories
                          .map((e) => Tab(child: Text(e.name)))
                          .toList()),
                )
              ];
            },

            /// -- TabBar Views
            body: TabBarView(
              children: categories
                  .map((category) => SHFCategoryTab(category: category))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
