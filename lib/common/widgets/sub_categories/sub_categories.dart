import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_rounded_image.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../products/product_cards/product_card_horizontal.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SHFAppBar(
        title: Text('Sports'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(SHFSizes.defaultSpace),
        child: Column(
          children: [
            ///Banner
            const SHFRoundedImage(
              width: double.infinity,
              imageURL: SHFImages.promoBanner3,
              applyImageRadius: true,
            ),
            const SizedBox(
              height: SHFSizes.spaceBtwSections,
            ),

            ///Sub-Categories
            Column(
              children: [
                ///Heading
                SHFSectionHeading(
                  title: 'Sports shirts',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: SHFSizes.spaceBtwItems / 2,
                ),

                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: SHFSizes.spaceBtwItems),
                    itemBuilder: (context, index) =>
                        const SHFProductCardHorizontal(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
