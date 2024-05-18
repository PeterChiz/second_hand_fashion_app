import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/features/shop/models/brand_model.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/shf_circular_image.dart';
import '../texts/shf_brand_title_text_with_verified_icon.dart';

/// Widget thẻ biểu diễn một thương hiệu.
class SHFBrandCard extends StatelessWidget {
  /// Hàm tạo mặc định cho SHFBrandCard.
  ///
  /// Tham số:
  ///   - brand: Thương hiệu để hiển thị.
  ///   - showBorder: Một cờ chỉ ra liệu có hiển thị viền xung quanh thẻ hay không.
  ///   - onTap: Hàm gọi lại khi thẻ được chạm.
  const SHFBrandCard({
    super.key,
    required this.brand,
    required this.showBorder,
    this.onTap,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = SHFHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      /// Thiết kế Container
      child: SHFRoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(SHFSizes.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// -- Icon
            Flexible(
              child: SHFCircularImage(
                image: brand.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
                overlayColor: isDark ? SHFColors.white : SHFColors.black,
              ),
            ),
            const SizedBox(width: SHFSizes.spaceBtwItems / 2),

            /// -- Texts
            // [Expanded] & Column [MainAxisSize.min] là quan trọng để giữ các phần tử ở trung tâm dọc và cũng
            // để giữ văn bản trong ranh giới.
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SHFBrandTitleWithVerifiedIcon(title: brand.name, brandTextSize: TextSizes.large),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

