import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_cart.dart';

class SHFBrandShowcase extends StatelessWidget {
  const SHFBrandShowcase({
    super.key, required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SHFRoundedContainer(
      showBorder: true,
      borderColor: SHFColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(SHFSizes.md),
      margin: const EdgeInsets.only(bottom: SHFSizes.spaceBtwItems),
      child: Column(
        children: [
          ///Brand with product Count
          const SHFBrandCard(showBorder: false),
          const SizedBox(height: SHFSizes.spaceBtwItems,),


          ///Brand top 3 Product Images
          Row(
              children: images.map((image) => brandTopProductImageWidget(image, context)).toList()
          )
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(String image,context){
    return Expanded(child: SHFRoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(SHFSizes.md),
      margin: const EdgeInsets.only(right: SHFSizes.sm),
      backgroundColor: SHFHelperFunctions.isDarkMode(context) ? SHFColors.darkerGrey : SHFColors.light,
      child:  Image(image: AssetImage(image), fit: BoxFit.contain,),
    ),
    );
  }
}
