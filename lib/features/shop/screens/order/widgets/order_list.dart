import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/animation_loader.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/orderController.dart';
import 'package:second_hand_fashion_app/navigation_menu.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

class SHFOrderListItems extends StatelessWidget {
  const SHFOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          ///Nothing found widget
          final emptyWidget = SHFAnimationLoaderWidget(
            text: 'Rất tiếc, chưa có đơn đặt hàng nào!',
            animation: SHFImages.orderCompletedAnimation,
            showAction: true,
            actionText: 'Tiếp tục mua sắm',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          ///
          final response = SHFCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          ///
          final orders = snapshot.data!;
          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, index) =>
                  const SizedBox(height: SHFSizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final order = orders[index];
                return SHFRoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(SHFSizes.md),
                  backgroundColor: SHFHelperFunctions.isDarkMode(context)
                      ? SHFColors.dark
                      : SHFColors.light,
                  child: Column(
                    children: [
                      ///Top row
                      Row(
                        children: [
                          ///1. Image
                          const Icon(Iconsax.ship),
                          const SizedBox(width: SHFSizes.spaceBtwItems / 2),

                          ///2. Status & Date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderStatusText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: SHFColors.primary,
                                          fontSizeDelta: 1),
                                ),
                                Text(
                                  order.formattedOrderDate,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),

                          ///3. Icon
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.arrow_right_34,
                                size: SHFSizes.iconSm,
                              )),
                        ],
                      ),
                      const SizedBox(height: SHFSizes.spaceBtwItems),

                      ///Bottom row
                      Row(
                        children: [
                          ///Order no
                          Expanded(
                            child: Row(
                              children: [
                                ///1. Icon
                                const Icon(Iconsax.tag),
                                const SizedBox(
                                  width: SHFSizes.spaceBtwItems / 2
                                ),

                                ///2. Order

                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Đơn hàng',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium),
                                        Text(
                                          order.id,
                                          maxLines: 1,
                                          overflow:   TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          ///Delivery Date
                          Expanded(
                            child: Row(
                              children: [
                                ///1. Icon
                                const Icon(Iconsax.calendar),
                                const SizedBox(
                                  width: SHFSizes.spaceBtwItems / 2
                                ),

                                ///2. Status & Date
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Ngày giao hàng',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                      Text(order.formattedDeliveryDate,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
