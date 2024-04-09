import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/shf_circular_icon.dart';
import '../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SHFProductImageSlider extends StatelessWidget {
  const SHFProductImageSlider({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return SHFCurvedEdgeWidget(
      child: Container(
        color: dark ? SHFColors.darkerGrey : SHFColors.light,
        child: Stack(
          children: [
            ///Main Large Image
            const SizedBox(
                height: 400,
                child: Padding(
                  padding:
                  EdgeInsets.all(SHFSizes.productImageRadius * 2),
                  child: Center(
                      child: Image(
                          image: AssetImage(SHFImages.productImage1))),
                )),

            ///Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: SHFSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: SHFSizes.spaceBtwItems),
                  itemBuilder: (_, index) => SHFRoundedImage(
                    width: 80,
                    backgroundColor:
                    dark ? SHFColors.dark : SHFColors.white,
                    border: Border.all(color: SHFColors.primary),
                    padding: const EdgeInsets.all(SHFSizes.sm),
                    imageURL: SHFImages.productImage3,
                  ),
                ),
              ),
            ),
            ///Appbar Icons
            const SHFAppBar(
              showBackArrow: true,
              actions: [
                SHFCircularIcon(icon: Iconsax.heart5, color: Colors.red,),

              ],
            )
          ],
        ),
      ),
    );
  }
}
