import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/features/shop/models/cart_item_model.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/shf_rounded_image.dart';
import '../../texts/shf_product_title_text.dart';
import '../../texts/shf_brand_title_text_with_verified_icon.dart';

/// Widget hiển thị một mục trong giỏ hàng.
class SHFCartItem extends StatelessWidget {
  const SHFCartItem({
    super.key,
    required this.item,
  });

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        /// 1 - Hình ảnh
        SHFRoundedImage(
          width: 60,
          height: 60,
          isNetworkImage: true,
          imageUrl: item.image ?? '',
          padding: const EdgeInsets.all(SHFSizes.sm),
          backgroundColor: dark ? SHFColors.darkerGrey : SHFColors.light,
        ),
        const SizedBox(width: SHFSizes.spaceBtwItems),

        /// 2 - Tiêu đề, Giá, & Kích cỡ
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Thương hiệu và Tiêu đề
              SHFBrandTitleWithVerifiedIcon(title: item.brandName ?? ''),
              Flexible(child: SHFProductTitleText(title: item.title, maxLines: 1)),

              /// Thuộc tính
              Text.rich(
                TextSpan(
                  children: (item.selectedVariation ?? {}).entries
                      .map(
                        (e) => TextSpan(
                      children: [
                        TextSpan(text: ' ${e.key} ', style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: '${e.value} ', style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

