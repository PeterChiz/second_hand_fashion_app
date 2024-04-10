import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class SHFHomeAppBar extends StatelessWidget {
  const SHFHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SHFAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(SHFTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: SHFColors.grey)),
          Text(SHFTexts.homeAppbarSubTitle, style: Theme.of(context).textTheme.headlineSmall!.apply(color: SHFColors.white)),
        ],
      ),
      actions: [
        SHFCartCounterIcon(onPressed: () {},iconColor: SHFColors.white, ),
      ],
    );
  }
}
