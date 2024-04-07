import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/shf_circular_image.dart';

class SHFUserProfileTile extends StatelessWidget {
  const SHFUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const SHFCircularImage(
        image: SHFImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text('Bùi Thiện Chí', style: Theme.of(context).textTheme.headlineMedium!.apply(color: SHFColors.white),),
      subtitle: Text('chi.bt.62cntt@ntu.edu.vn', style: Theme.of(context).textTheme.bodyMedium!.apply(color: SHFColors.white),),
      trailing: IconButton(onPressed: (){},icon: const Icon(Iconsax.edit, color: SHFColors.white,),
      ),
    );
  }
}
