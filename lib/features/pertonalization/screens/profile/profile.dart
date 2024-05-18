import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_circular_image.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/change_name.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/widgets/profile_menu.dart';
import 'package:second_hand_fashion_app/common/widgets/shimmers/shimmer.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: SHFAppBar(
        showBackArrow: true,
        title: Text('Hồ sơ', style: Theme.of(context).textTheme.headlineSmall),
      ),

      ///Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : SHFImages.user;

                      return controller.imageUploading.value
                          ? const SHFShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : SHFCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(
                        onPressed: controller.imageUploading.value
                            ? () {}
                            : () => controller.uploadUserProfilePicture(),
                        child: const Text('Thay đổi ảnh đại diện')),
                  ],
                ),
              ),

              ///Detail
              const SizedBox(height: SHFSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems),

              ///Heading Profile Info
              const SHFSectionHeading(
                  title: 'Thông tin hồ sơ', showActionButton: false),
              const SizedBox(height: SHFSizes.spaceBtwItems),

              SHFProfileMenu(
                  onPressed: () => Get.to(() => const ChangeName()),
                  title: 'Tên KH',
                  value: controller.user.value.fullName),
              SHFProfileMenu(
                  onPressed: () {},
                  title: 'Tên TK',
                  value: controller.user.value.username),

              const SizedBox(height: SHFSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems),

              ///Heading Personal Info
              const SHFSectionHeading(
                title: 'Thông tin cá nhân ',
                showActionButton: false,
              ),
              const SizedBox(height: SHFSizes.spaceBtwItems),

              SHFProfileMenu(
                  onPressed: () {},
                  title: 'Mã ID',
                  value: controller.user.value.id,
                  icon: Iconsax.copy),
              SHFProfileMenu(
                  onPressed: () {},
                  title: 'E-mail',
                  value: controller.user.value.email),
              SHFProfileMenu(
                  onPressed: () {},
                  title: 'Số điện thoại',
                  value: controller.user.value.phoneNumber),

              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Xóa tài khoản',
                      style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
