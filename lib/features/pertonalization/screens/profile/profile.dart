import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/common/widgets/images/shf_circular_image.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/profile/widgets/profile_menu.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const SHFAppBar(
        showBackArrow: true,
        title: Text('Profile'),
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
                    TextButton(onPressed: (){}, child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              ///Detail
              const SizedBox(height: SHFSizes.spaceBtwItems /2,),
              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems,),
              const SHFSectionHeading(title: 'Profile Infomation', showActionButton: false,),
              const SizedBox(height: SHFSizes.spaceBtwItems,),

              SHFProfileMenu(onPressed: () {  },title: 'Name',value: 'Bùi Thiện Chí',),
              SHFProfileMenu(onPressed: () {  },title: 'UserName',value: 'chiz',),
              
              const SizedBox(height: SHFSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems,),
              
              ///Heading Personal Info
              const SHFSectionHeading(title: 'Personal Information', showActionButton: false,),
              const SizedBox(height: SHFSizes.spaceBtwItems,),

              SHFProfileMenu(onPressed: () {  },title: 'User ID',value: '12321', icon: Iconsax.copy,),
              SHFProfileMenu(onPressed: () {  },title: 'E-mail',value: 'chi.bt.62cntt@ntu.edu.vn',),
              SHFProfileMenu(onPressed: () {  },title: 'Phone Number',value: '0773872129',),
              SHFProfileMenu(onPressed: () {  },title: 'Sex',value: 'Male',),
              SHFProfileMenu(onPressed: () {  },title: 'Date of Birth',value: '10, Oct, 1994',),

              const Divider(),
              const SizedBox(height: SHFSizes.spaceBtwItems,),
              
              Center(
                child: TextButton(
                  onPressed: (){},
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

