import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/banner_controller.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/shf_rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';

/// Widget để hiển thị trình chiếu khuyến mãi sử dụng quản lý trạng thái GetX.
class SHFPromoSlider extends StatelessWidget {
  const SHFPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy instance của BannerController sử dụng GetX
    final controller = Get.put(BannerController());

    // Sử dụng widget Obx để tự động xây dựng lại giao diện khi trạng thái của banner thay đổi
    return Obx(
      () {
        // Loader
        if (controller.bannersLoading.value)
          return const SHFShimmerEffect(width: double.infinity, height: 190);

        // Không tìm thấy dữ liệu
        if (controller.banners.isEmpty) {
          return const Center(child: Text('Không tìm thấy dữ liệu'));
        } else {
          /// Tìm thấy bản ghi!
          // Hiển thị CarouselSlider với các banner và chỉ số trang
          return Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index),
                ),
                items: controller.banners
                    .map(
                      (banner) => SHFRoundedImage(
                        imageUrl: banner.imageUrl,
                        isNetworkImage: true,
                        onPressed: () => Get.toNamed(banner.targetScreen),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: SHFSizes.spaceBtwItems),
              Center(
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Hiển thị chỉ số trang dựa trên số lượng banner
                      for (int i = 0; i < controller.banners.length; i++)
                        SHFCircularContainer(
                          width: 20,
                          height: 4,
                          margin: const EdgeInsets.only(right: 10),
                          backgroundColor:
                              controller.carousalCurrentIndex.value == i
                                  ? SHFColors.primary
                                  : SHFColors.grey,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
