import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../models/product_attribute_model.dart';
import '../../../models/product_variation_model.dart';

class AttributeWidget extends StatelessWidget {
  final List<ProductVariationModel> variations;
  final ProductAttributeModel attribute;
  final String? selectedValue;
  final Function(String) onValueSelected;

  const AttributeWidget({
    super.key,
    required this.variations,
    required this.attribute,
    required this.selectedValue,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Truyền các biến thể để kiểm tra các thuộc tính nào có sẵn và số lượng tồn không phải là 0
    final availableVariationValues = variations
        .where((variation) =>
            // Kiểm tra các thuộc tính trống / hết hàng
            variation.attributeValues[attribute.name] != null &&
            variation.attributeValues[attribute.name]!.isNotEmpty &&
            variation.stock > 0)
        // Lấy tất cả các thuộc tính không trống của các biến thể
        .map((variation) => variation.attributeValues[attribute.name])
        .toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(attribute.name!),
        const SizedBox(height: 4.0),
        Wrap(
          spacing: 8.0,
          children: attribute.values!.map((value) {
            final isSelected = value == selectedValue;
            final isAvailable = availableVariationValues.contains(value);

            return Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: ChoiceChip(
                label: Text(value),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected && isAvailable) onValueSelected(value);
                },
                selectedColor: SHFColors.primary,
                labelStyle: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : (isAvailable
                            ? isDark
                                ? SHFColors.white
                                : SHFColors.dark
                            : isDark
                                ? Colors.white30
                                : Colors.grey)),
                elevation: isSelected ? 5.0 : 0.0,
                backgroundColor: isSelected
                    ? SHFColors.primary
                    : (isAvailable
                        ? Colors.transparent
                        : isDark
                            ? SHFColors.dark
                            : Colors.grey.shade200),
                iconTheme: IconThemeData(
                    color: isSelected ? Colors.white : Colors.black, size: 18),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
