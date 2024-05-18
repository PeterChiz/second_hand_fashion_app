import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

/// Một widget biểu tượng tròn tùy chỉnh với màu nền.
///
/// Các thuộc tính bao gồm:
/// Container [width], [height], & [backgroundColor].
///
/// Kích thước của biểu tượng [size], [color] & [onPressed]
class SHFCircularIcon extends StatelessWidget {
  const SHFCircularIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.size = SHFSizes.lg,
    this.onPressed,
    this.color,
    this.backgroundColor,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : SHFHelperFunctions.isDarkMode(context)
            ? SHFColors.black.withOpacity(0.9)
            : SHFColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
          onPressed: onPressed, icon: Icon(icon, color: color, size: size)),
    );
  }
}
