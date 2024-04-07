import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class SHFRoundedImage extends StatelessWidget {
  const SHFRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageURL,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = SHFSizes.md,
  });

  final double? width, height;
  final String imageURL;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;

  final BoxFit? fit;

  final EdgeInsetsGeometry? padding;

  final bool isNetworkImage;

  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.zero,
            child: Image(
              fit: fit, image: isNetworkImage ? NetworkImage(imageURL) : AssetImage(imageURL) as ImageProvider,
            ),
        ),
      ),
    );
  }
}
