import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../common/widgets/sub_categories/sub_categories.dart';
import '../../../../../utils/constants/image_strings.dart';

class SHFHomeCategories extends StatelessWidget {
  const SHFHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return SHFVerticalImageText(
              image: SHFImages.shoeIcon,
              title: 'Shoes',
              onTap: () => Get.to(() => const SubCategoriesScreen()),
            );
          }),
    );
  }
}
