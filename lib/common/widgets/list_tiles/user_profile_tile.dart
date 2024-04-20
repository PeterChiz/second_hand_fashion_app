import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/user_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/shf_circular_image.dart';

class SHFUserProfileTile extends StatelessWidget {
  const SHFUserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const SHFCircularImage(
        image: SHFImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineMedium!.apply(color: SHFColors.white),),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: SHFColors.white),),
      trailing: IconButton(onPressed: onPressed,icon: const Icon(Iconsax.edit, color: SHFColors.white,),
      ),
    );
  }
}
