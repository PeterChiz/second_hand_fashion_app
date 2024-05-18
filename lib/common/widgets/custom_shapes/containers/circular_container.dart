import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

/// Một widget container tròn có thể chứa child tùy chọn, border và các kiểu dáng.
class SHFCircularContainer extends StatelessWidget {
  /// Tạo một container tròn.
  ///
  /// Tham số:
  ///   - child: Widget child tùy chọn để đặt bên trong container.
  ///   - margin: Phần lề xung quanh container.
  ///   - padding: Phần padding bên trong container.
  ///   - width: Chiều rộng của container.
  ///   - height: Chiều cao của container.
  ///   - radius: Bán kính của viền tròn.
  ///   - showBorder: Cho biết liệu có hiển thị border xung quanh container không.
  ///   - backgroundColor: Màu nền của container.
  ///   - borderColor: Màu của border (nếu [showBorder] là true).
  const SHFCircularContainer({
    super.key,
    this.child,
    this.margin,
    this.padding,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.showBorder = false,
    this.backgroundColor = SHFColors.white,
    this.borderColor = SHFColors.borderPrimary,
  });

  final Widget? child;
  final double? width;
  final double radius;
  final double? height;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}

