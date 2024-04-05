import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class SHFCircularContainer extends StatelessWidget {
  const SHFCircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.backgroundColor = SHFColors.white, this.margin,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}