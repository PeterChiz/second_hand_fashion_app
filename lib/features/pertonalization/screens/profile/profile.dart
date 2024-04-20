import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_circular_image.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/widgets/change_name.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/widgets/profile_menu.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return  Scaffold(
      appBar: const SHFAppBar(
        showBackArrow: true,
        title: Text('Hồ sơ'),
      ),
      ///Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SHFSizes.defaultSpace
          ),
          child: Column(
            children: [
              ///Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SHFCircularImage(image: SHFImages.user, width: 80, height: 80,),
                    TextButton(onPressed: (){}, child: const Text('Thay đổi ảnh đại diện')),
                  ],
                ),
              ),

              ///Detail
              const SizedBox(height: SHFSizes.spaceBtwItems /2,),
              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems,),

              ///Heading Profile Info
              const SHFSectionHeading(title: 'Thông tin hồ sơ', showActionButton: false,),
              const SizedBox(height: SHFSizes.spaceBtwItems,),

              SHFProfileMenu(onPressed: () => Get.to(() =>const ChangeName()),title: 'Tên KH',value: controller.user.value.fullName),
              SHFProfileMenu(onPressed: () {  },title: 'Tên TK',value: controller.user.value.userName),
              
              const SizedBox(height: SHFSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems,),
              
              ///Heading Personal Info
              const SHFSectionHeading(title: 'Thông tin cá nhân ', showActionButton: false,),
              const SizedBox(height: SHFSizes.spaceBtwItems,),

              SHFProfileMenu(onPressed: () {  },title: 'Mã ID',value: controller.user.value.id, icon: Iconsax.copy,),
              SHFProfileMenu(onPressed: () {  },title: 'E-mail',value: controller.user.value.email),
              SHFProfileMenu(onPressed: () {  },title: 'Số điện thoại',value: controller.user.value.phoneNumber),
              SHFProfileMenu(onPressed: () {  },title: 'Giới tính',value: 'Male',),
              SHFProfileMenu(onPressed: () {  },title: 'Năm sinh',value: '20, Oct, 2002',),

              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems,),
              
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Close Account', style: TextStyle(color: Colors.red),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

