import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

/// Một widget container với các góc bo tròn và các thuộc tính có thể tùy chỉnh.
class SHFRoundedContainer extends StatelessWidget {
  /// Tạo một container bo tròn với các thuộc tính có thể tùy chỉnh.
  ///
  /// Tham số:
  ///   - width: Chiều rộng của container.
  ///   - height: Chiều cao của container.
  ///   - radius: Bán kính viền cho các góc bo tròn.
  ///   - padding: Khoảng cách lót bên trong container.
  ///   - margin: Khoảng cách ngoài container.
  ///   - child: Widget sẽ được đặt bên trong container.
  ///   - backgroundColor: Màu nền của container.
  ///   - borderColor: Màu viền của container.
  ///   - showBorder: Một cờ để xác định xem container có nên có viền không.
  const SHFRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.showBorder = false,
    this.padding = const EdgeInsets.all(SHFSizes.md),
    this.borderColor = SHFColors.borderPrimary,
    this.radius = SHFSizes.cardRadiusLg,
    this.backgroundColor = SHFColors.white,
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundColor;
  final Color borderColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}

