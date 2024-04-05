import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/home_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class SHFPromoSlider extends StatelessWidget {
  const SHFPromoSlider({
    super.key, required this.banner,
  });

  final List<String> banner;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) => controller.updatePageIndicator(index)
          ),
          items: banner.map((url) => SHFRoundedImage(imageURL: url)).toList(),
        ),
        const SizedBox(height: SHFSizes.spaceBtwItems,),
        Center(
          child: Obx(
                () =>
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for(int i = 0; i < banner.length; i++)
                      SHFCircularContainer(
                        width: 20,
                        height: 4,
                        margin: const EdgeInsets.only(right: 10),
                        backgroundColor: controller.carousalCurrentIndex.value == i ? SHFColors.primary : Colors.green,
                      ),

                  ],
                ),
          ),
        )
      ],
    );
  }
}
