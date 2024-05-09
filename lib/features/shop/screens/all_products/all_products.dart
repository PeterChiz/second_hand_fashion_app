import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/all_products_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/device/device_utility.dart';
import '../../models/product_model.dart';

/// Represents a screen that displays a list of products with the option for custom sorting and filtering.
class AllProducts extends StatelessWidget {
  const AllProducts({super.key, required this.title, this.query, this.futureMethod});

  /// The title of the screen.
  final String title;

  /// Represents a query to fetch products from the database.
  /// Use the [query] parameter to apply custom sorting or filtering criteria.
  final Query? query;

  /// Represents a function to fetch products as a future.
  /// If you use this [futureMethod] function, it does not allow custom sorting or filtering from the database.
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product fetching
    final controller = Get.put(AllProductsController());

    return Scaffold(
      appBar: SHFAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (_, snapshot) {
              // Check the state of the FutureBuilder snapshot
              const loader = SHFVerticalProductShimmer();
              final widget = SHFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

              // Return appropriate widget based on snapshot state
              if (widget != null) return widget;

              // Products found!
              final products = snapshot.data!;
              return SHFSortableProductList(products: products);
            },
          ),
        ),
      ),
    );
  }
}

/// Represents a sortable list of products that can be filtered and sorted.
///
/// You can also perform sorting directly from the database using [ProductRepository.filterProducts].
class SHFSortableProductList extends StatelessWidget {
  const SHFSortableProductList({
    super.key,
    required this.products,
  });

  /// The list of products to be displayed.
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product sorting
    final controller = Get.put(AllProductsController());
    // Assign the products to the controller
    controller.assignProducts(products);

    return Column(
      children: [
        /// -- Sort & Filter Section
        Row(
          children: [
            Obx(
                  () => Expanded(
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                  value: controller.selectedSortOption.value,
                  onChanged: (value) {
                    // Sort products based on the selected option
                    controller.sortProducts(value!);
                  },
                  items: ['Tên', 'Giá cao đến thấp', 'Giá thấp đến cao', 'Giảm giá', 'Mới nhất', 'Phổ biến'].map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections),

        /// Product Grid Section
        Obx(
              () => SHFGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => SHFProductCardVertical(product: controller.products[index], isNetworkImage: true),
          ),
        ),

        /// Bottom spacing to accommodate the navigation bar
        SizedBox(height: SHFDeviceUtils.getBottomNavigationBarHeight() + SHFSizes.defaultSpace),
      ],
    );
  }
}
