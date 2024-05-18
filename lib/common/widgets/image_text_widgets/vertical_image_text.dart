import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_circular_image.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../texts/shf_brand_title_text.dart';

/// Một widget hiển thị hình ảnh với văn bản phía dưới trong một sắp xếp dọc.
class SHFVerticalImageAndText extends StatelessWidget {
  /// Constructor cho [SHFVerticalImageAndText].
  const SHFVerticalImageAndText({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.textColor = SHFColors.white,
  });

  /// Đường dẫn tài nguyên hình ảnh hoặc URL.
  final String image;

  /// Văn bản sẽ được hiển thị phía dưới hình ảnh.
  final String title;

  /// Màu của văn bản.
  final Color textColor;

  /// Cờ chỉ định liệu hình ảnh có được tải từ mạng hay không.
  final bool isNetworkImage;

  /// Màu nền của widget.
  final Color? backgroundColor;

  /// Hàm gọi lại khi widget được chạm vào.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: SHFSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Biểu tượng tròn
            Flexible(
              child: SHFCircularImage(
                image: image,
                fit: BoxFit.fitWidth,
                padding: SHFSizes.sm * 1.4,
                isNetworkImage: isNetworkImage,
                backgroundColor: backgroundColor,
                overlayColor: SHFHelperFunctions.isDarkMode(context)
                    ? SHFColors.light
                    : SHFColors.dark,
              ),
            ),

            /// Văn bản
            const SizedBox(height: SHFSizes.spaceBtwItems / 2),
            SizedBox(width: 55, child: SHFBrandTitleText(title: title, color: textColor)),
          ],
        ),
      ),
    );
  }
}

