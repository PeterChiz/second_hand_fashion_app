import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:second_hand_fashion_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_circular_image.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            SHFPrimaryHeaderContainer(
              child: Column(
                children: [
                  SHFAppBar(
                    title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: SHFColors.white),),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections,),

                  ///User Profile Card
                  const ListTile(
                    leading: SHFCircularImage(
                      image: SHFImages.user,
                      width: 50,
                      height: 50,
                      padding: 0,
                    ),
                  ),
                  const SizedBox(height: SHFSizes.spaceBtwSections,),
                ],
              ),
            )

            ///Body
          ],
        ),
      ),
    );
  }
}
