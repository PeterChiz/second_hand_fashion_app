import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

/// A customized choice chip that can act like a radio button.
class SHFChoiceChip extends StatelessWidget {
  /// Create a chip that acts like a radio button.
  ///
  /// Parameters:
  ///   - text: The label text for the chip.
  ///   - selected: Whether the chip is currently selected.
  ///   - onSelected: Callback function when the chip is selected.
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
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        avatar: SHFHelperFunctions.getColor(text) != null ? SHFCircularContainer(width: 50,height: 50,backgroundColor: SHFHelperFunctions.getColor(text)!) : null,
        selected: selected,
        onSelected: onSelected,
        backgroundColor: SHFHelperFunctions.getColor(text),
        labelStyle: TextStyle(color: selected ? SHFColors.white : null),
        shape: SHFHelperFunctions.getColor(text) != null  ? const CircleBorder() : null,
        label: SHFHelperFunctions.getColor(text) != null ? Text(text) : const SizedBox(),
        padding: SHFHelperFunctions.getColor(text) != null ? const EdgeInsets.all(0) : null,
        labelPadding: SHFHelperFunctions.getColor(text) != null ? const EdgeInsets.all(0) : null,
        //Make icon in the center
      ),
    );

  }
}
