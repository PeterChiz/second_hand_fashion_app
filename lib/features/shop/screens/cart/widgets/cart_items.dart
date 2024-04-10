import 'package:flutter/material.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class SHFCartItems extends StatelessWidget {
  const SHFCartItems({super.key,
    this.showAddRemoveButtons =true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: 2,
        separatorBuilder: (_, __) => const SizedBox(
              height: SHFSizes.spaceBtwSections,
            ),
        itemBuilder: (_, index) => Column(
              children: [
                ///Cart item
                const SHFCartItem(),
                if(showAddRemoveButtons)
                const SizedBox(
                  height: SHFSizes.spaceBtwItems,
                ),

                ///Add, Remove Button Row with total Price
                if(showAddRemoveButtons)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ///Extra Space
                        SizedBox(
                          width: 70,
                        ),

                        ///Add, Remove Buttons
                        SHFProductQualityWithAddRemoveButton(),
                      ],
                    ),
                    SHFProductPriceText(price: '256'),
                  ],
                ),
              ],
            ));
  }
}
