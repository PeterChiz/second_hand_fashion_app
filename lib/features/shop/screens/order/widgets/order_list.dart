import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

class SHFOrderListItems extends StatelessWidget {
  const SHFOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (_,__) => const SizedBox(height: SHFSizes.spaceBtwItems,),
      itemBuilder: (_,__) =>  SHFRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(SHFSizes.md),
        backgroundColor: dark ? SHFColors.dark : SHFColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            ///Row1
            Row(
              children: [
                ///1. Icon
                const Icon(Iconsax.ship4),
                const SizedBox(width: SHFSizes.spaceBtwItems /2,),

                ///2. Status & Date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Processing', style: Theme.of(context).textTheme.bodyLarge!.apply(color: SHFColors.primary, fontSizeDelta: 1),),
                      Text('07 Apr 2024', style: Theme.of(context).textTheme.headlineSmall,),
                    ],
                  ),
                ),

                ///3. Icon
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_34, size: SHFSizes.iconSm,)),
              ],
            ),
            const SizedBox(height: SHFSizes.spaceBtwItems),


            ///Row2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ///1. Icon
                      const Icon(Iconsax.ship4),
                      const SizedBox(width: SHFSizes.spaceBtwItems /2,),

                      ///2. Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order', style: Theme.of(context).textTheme.labelMedium),
                            Text('#200218', style: Theme.of(context).textTheme.titleMedium,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      ///1. Icon
                      const Icon(Iconsax.ship4),
                      const SizedBox(width: SHFSizes.spaceBtwItems /2,),

                      ///2. Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shipping Date', style: Theme.of(context).textTheme.labelMedium),
                            Text('10 Apr 2024', style: Theme.of(context).textTheme.titleMedium),
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
      ),
    );
  }
}
