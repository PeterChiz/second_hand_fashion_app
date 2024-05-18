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

/// Đại diện cho một màn hình hiển thị danh sách sản phẩm với tùy chọn sắp xếp và lọc tùy chỉnh.
class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  /// Tiêu đề của màn hình.
  final String title;

  /// Đại diện cho một truy vấn để lấy sản phẩm từ cơ sở dữ liệu.
  /// Sử dụng tham số [query] để áp dụng các tiêu chí sắp xếp hoặc lọc tùy chỉnh.
  final Query? query;

  /// Đại diện cho một hàm để lấy sản phẩm dưới dạng tương lai.
  /// Nếu bạn sử dụng hàm [futureMethod] này, nó không cho phép sắp xếp hoặc lọc tùy chỉnh từ cơ sở dữ liệu.
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    // Khởi tạo controller để quản lý việc lấy sản phẩm
    final controller = Get.put(AllProductsController());

    return Scaffold(
      appBar: SHFAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (_, snapshot) {
              // Kiểm tra trạng thái của snapshot trong FutureBuilder
              const loader = SHFVerticalProductShimmer();
              final widget = SHFCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot, loader: loader);

              // Trả về widget phù hợp dựa trên trạng thái snapshot
              if (widget != null) return widget;

              // Sản phẩm được tìm thấy!
              final products = snapshot.data!;
              return SHFSortableProductList(products: products);
            },
          ),
        ),
      ),
    );
  }
}

/// Đại diện cho một danh sách sản phẩm có thể được sắp xếp và lọc.
///
/// Có thể thực hiện sắp xếp trực tiếp từ cơ sở dữ liệu bằng cách sử dụng [ProductRepository.filterProducts].
class SHFSortableProductList extends StatelessWidget {
  const SHFSortableProductList({
    super.key,
    required this.products,
  });

  /// Danh sách sản phẩm để hiển thị.
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    // Khởi tạo controller để quản lý việc sắp xếp sản phẩm
    final controller = Get.put(AllProductsController());
    // Gán các sản phẩm cho controller
    controller.assignProducts(products);

    return Column(
      children: [
        /// -- Phần Sắp xếp & Lọc
        Row(
          children: [
            Obx(
              () => Expanded(
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration:
                      const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                  value: controller.selectedSortOption.value,
                  onChanged: (value) {
                    // Sắp xếp sản phẩm dựa trên tùy chọn được chọn
                    controller.sortProducts(value!);
                  },
                  items: [
                    'Tên',
                    'Giá cao đến thấp',
                    'Giá thấp đến cao',
                    'Giảm giá',
                    'Mới nhất',
                    'Phổ biến'
                  ].map((option) {
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

        /// Phần Lưới Sản phẩm
        Obx(
          () => SHFGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) => SHFProductCardVertical(
                product: controller.products[index], isNetworkImage: true),
          ),
        ),

        /// Khoảng trắng dưới cùng để thích nghi với thanh điều hướng dưới cùng
        SizedBox(
            height: SHFDeviceUtils.getBottomNavigationBarHeight() +
                SHFSizes.defaultSpace),
      ],
    );
  }
}
