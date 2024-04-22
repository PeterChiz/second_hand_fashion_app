import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/features/pertonalization/controllers/user_controller.dart';

import '../shimmers/shimmer.dart';
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
      leading: Obx(() {
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty ? networkImage : SHFImages.user;

        return controller.imageUploading.value
            ? const SHFShimmerEffect(
          width: 50,
          height: 50,
          radius: 50,
        )
            : SHFCircularImage(
            image: image,
            width: 50,
            height: 50,
            padding: 0,
            isNetworkImage: networkImage.isNotEmpty);
      }),
      title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineMedium!.apply(color: SHFColors.white),),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: SHFColors.white),),
      trailing: IconButton(onPressed: onPressed,icon: const Icon(Iconsax.edit, color: SHFColors.white,),
      ),
    );
  }
}
