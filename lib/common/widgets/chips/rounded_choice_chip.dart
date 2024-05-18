import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

/// Một choice chip được tùy chỉnh có thể hoạt động như một nút radio.
class SHFChoiceChip extends StatelessWidget {
  /// Tạo một chip hoạt động như một nút radio.
  ///
  /// Tham số:
  ///   - text: Nhãn cho chip.
  ///   - selected: Cho biết liệu chip có được chọn hiện tại không.
  ///   - onSelected: Hàm callback khi chip được chọn.
  const SHFChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Theme(
      // Sử dụng màu canvas trong suốt để phù hợp với kiểu dáng hiện có.
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        // Sử dụng hàm này để lấy Màu như một Chip
        avatar: SHFHelperFunctions.getColor(text) != null
            ? SHFCircularContainer(width: 50, height: 50, backgroundColor: SHFHelperFunctions.getColor(text)!)
            : null,
        selected: selected,
        onSelected: onSelected,
        backgroundColor: SHFHelperFunctions.getColor(text),
        labelStyle: TextStyle(color: selected ? SHFColors.white : null),
        shape: SHFHelperFunctions.getColor(text) != null ? const CircleBorder() : null,
        label: SHFHelperFunctions.getColor(text) == null ? Text(text) : const SizedBox(),
        padding: SHFHelperFunctions.getColor(text) != null ? const EdgeInsets.all(0) : null,
        labelPadding: SHFHelperFunctions.getColor(text) != null ? const EdgeInsets.all(0) : null,
      ),
    );
  }
}

