import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/chips/rounded_choice_chip.dart';
import '../../../../../common/widgets/texts/section_heading.dart';

import '../../../../../common/widgets/texts/shf_product_price_text.dart';
import '../../../../../common/widgets/texts/shf_product_title_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/variation_controller.dart';
import '../../../models/product_model.dart';

class SHFProductAttributes extends StatelessWidget {
  const SHFProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = VariationController.instance;
    controller.resetSelectedAttributes();
    return Obx(
          () => Column(
        children: [
          /// -- Giá trị và Mô tả thuộc tính đã chọn
          // Hiển thị giá biến thể và tồn kho khi một số biến thể được chọn.
          if (controller.selectedVariation.value.id.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SHFSectionHeading(title: 'Biến thể: ', showActionButton: false),
                    const SizedBox(width: SHFSizes.spaceBtwItems),

                    /// Giá
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Giá thực nếu giá giảm không rỗng.
                            const SHFProductTitleText(title: 'Giá : ', smallSize: true),
                            if (controller.selectedVariation.value.salePrice > 0)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: SHFSizes.spaceBtwItems),
                                  Text(
                                    controller.selectedVariation.value.price.toString(),
                                    style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                                  ),
                                  const SizedBox(width: SHFSizes.spaceBtwItems)
                                ],
                              ),
                            // Giá giảm nếu giá giảm không rỗng Ngược lại Giá đơn giản.
                            SHFProductPriceText(
                              price: controller.selectedVariation.value.salePrice > 0
                                  ? controller.selectedVariation.value.salePrice.toString()
                                  : controller.selectedVariation.value.price.toString(),
                            ),
                          ],
                        ),

                        /// Tồn kho
                        Row(
                          children: [
                            const SHFProductTitleText(title: 'Số lượng : ', smallSize: true),
                            Text(controller.selectedVariation.value.stock.toString(), style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                /// Mô tả
                SHFProductTitleText(
                  title: controller.selectedVariation.value.description.toString(),
                  smallSize: true,
                  maxLines: 4,
                ),
              ],
            ),
          const SizedBox(height: SHFSizes.spaceBtwItems),

          /// -- Thuộc tính
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
              // attribute = Thuộc tính Đơn sản phẩm [Tên: Màu sắc, Giá trị: [Xanh, Xanh dương, Cam]]
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SHFSectionHeading(title: attribute.name ?? '', showActionButton: false),
                const SizedBox(height: SHFSizes.spaceBtwItems / 2),
                Obx(
                      () => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: attribute.values!.map((attributeValue) {
                      // attributeValue = Giá trị Thuộc tính Đơn [Xanh]
                      final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                      final available = controller
                          .getAttributesAvailabilityInVariation(product.productVariations!, attribute.name!)
                          .contains(attributeValue);

                      /// Chip Thuộc tính
                      return SHFChoiceChip(
                        text: attributeValue,
                        selected: isSelected,
                        onSelected: available
                            ? (selected) {
                          if (selected && available) {
                            controller.onAttributeSelected(product, attribute.name ?? '', attributeValue);
                          }
                        }
                            : null,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: SHFSizes.spaceBtwItems),
              ],
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
