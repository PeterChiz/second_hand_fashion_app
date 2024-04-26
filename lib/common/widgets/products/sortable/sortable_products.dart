import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/all_products_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class SHFSortableProducts extends StatelessWidget {
  const SHFSortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    //Initialize controller for managing product sorting
    final controller = Get.put(AllProductController());
    controller.assignProducts(products);
    return Column(
      children: [
        ///Dropdown
        DropdownButtonFormField(
          onChanged: (value) {
            //Sort products based on the selected option
            controller.sortProducts(value!);
          },
          value: controller.selectedSortOption.value,
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: ['Tên', 'Giá cao đến thấp', 'Giá thấp đến cao', 'Giảm giá', 'Mới nhất', 'Phổ biến']
              .map((option) =>
              DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: SHFSizes.spaceBtwSections),

        ///Products
        Obx(() => SHFGridLayout(itemCount: controller.products.length, itemBuilder: (_,index) =>  SHFProductCardVertical(product:controller.products[index]))),
      ],
    );
  }
}

