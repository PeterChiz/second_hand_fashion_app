import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/banner_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';

class SHFPromoSlider extends StatelessWidget {
  const SHFPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
            () {
          //Loader
          if (controller.isLoading.value) return const SHFShimmerEffect(width: double.infinity, height: 190);

          //khong tim thay du lieu
          if (controller.banners.isEmpty) {
            return const Center(child: Text('Không tìm thấy dữ liệu'),);
          } else {
            return Column(
              children: [
                CarouselSlider(
                    options: CarouselOptions(
                        viewportFraction: 1,
                        onPageChanged: (index, _) =>
                            controller.updatePageIndicator(index)),
                    items: controller.banners
                        .map(
                          (banner) =>
                          SHFRoundedImage(
                            imageURL: banner.imageUrl,
                            isNetworkImage: true,
                            onPressed: () => Get.toNamed(banner.targetScreen),
                          ),
                    ).toList()
                ),
                const SizedBox(
                  height: SHFSizes.spaceBtwItems,
                ),
                Center(
                  child: Obx(
                        () =>
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (int i = 0; i < controller.banners.length; i++)
                              SHFCircularContainer(
                                width: 20,
                                height: 4,
                                margin: const EdgeInsets.only(right: 10),
                                backgroundColor: controller.carousalCurrentIndex
                                    .value == i
                                    ? SHFColors.primary
                                    : SHFColors.grey,
                              ),
                          ],
                        ),
                  ),
                )
              ],
            );
          }
        }
    );
  }
}
