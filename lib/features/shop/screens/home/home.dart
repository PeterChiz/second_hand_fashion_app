import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/product_controller.dart';
import 'package:second_hand_fashion_app/features/shop/screens/all_products/all_products.dart';
import 'package:second_hand_fashion_app/features/shop/screens/home/widgets/promo_slider.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import 'widgets/header_search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/home_appbar.dart';
import 'widgets/header_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            const SHFPrimaryHeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Appbar
                  SHFHomeAppBar(),
                  SizedBox(height: SHFSizes.spaceBtwSections),

                  /// -- Searchbar
                  SHFSearchContainer(
                      text: 'Tìm kiếm mặt hàng', showBorder: false),
                  SizedBox(height: SHFSizes.spaceBtwSections),

                  /// -- Categories
                  SHFHeaderCategories(),
                  SizedBox(height: SHFSizes.spaceBtwSections * 2),
                ],
              ),
            ),

            /// -- Body
            Container(
              padding: const EdgeInsets.all(SHFSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Promo Slider 1
                  const SHFPromoSlider(),
                  const SizedBox(height: SHFSizes.spaceBtwSections),

                  /// -- Products Heading
                  SHFSectionHeading(
                    title: SHFTexts.popularProducts,
                    onPressed: () => Get.to(
                      () => AllProducts(
                        title: SHFTexts.popularProducts,
                        futureMethod:
                            ProductRepository.instance.getAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwItems),

                  /// Products Section
                  Obx(
                    () {
                      // Hiển thị loader trong khi sản phẩm đang tải
                      if (controller.isLoading.value)
                        return const SHFVerticalProductShimmer();

                      // Kiểm tra nếu không tìm thấy sản phẩm nổi bật
                      if (controller.featuredProducts.isEmpty) {
                        return Center(
                            child: Text('Không tìm thấy dữ liệu!',
                                style: Theme.of(context).textTheme.bodyMedium));
                      } else {
                        // Có Sản phẩm Nổi bật!
                        return SHFGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => SHFProductCardVertical(
                              product: controller.featuredProducts[index],
                              isNetworkImage: true),
                        );
                      }
                    },
                  ),

                  SizedBox(
                      height: SHFDeviceUtils.getBottomNavigationBarHeight() +
                          SHFSizes.defaultSpace),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
