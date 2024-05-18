import 'package:flutter/material.dart';

import '../../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../../features/shop/models/product_model.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../texts/shf_product_price_text.dart';

class PricingWidget extends StatelessWidget {
  const PricingWidget({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Giá thực nếu giá khuyến mãi không null
          if (product.productType == ProductType.single.toString() && product.salePrice > 0)
            Padding(
              padding: const EdgeInsets.only(left: SHFSizes.sm),
              child: Text(
                product.price.toString(),
                style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
              ),
            ),

          /// Giá, Hiển thị giá khuyến mãi là giá chính nếu có giá khuyến mãi.
          Padding(
            padding: const EdgeInsets.only(left: SHFSizes.sm),
            child: SHFProductPriceText(price: ProductController.instance.getProductPrice(product)),
          ),
        ],
      ),
    );
  }
}
