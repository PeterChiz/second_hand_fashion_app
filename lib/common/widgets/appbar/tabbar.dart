import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/utils/device/device_utility.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

/// A custom tab bar widget with customizable appearance.
class SHFTabBar extends StatelessWidget implements PreferredSizeWidget{
  ///Nếu muốn thêm màu nền cho các tab phải wrap then trong Material widget.
  ///Để làm được điều đó, ta cần Widget [PreferredSize] và nên phải tạo lớp tùy chỉnh [PreferredSizeWidget]
  const SHFTabBar({
    super.key, required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? SHFColors.black : SHFColors.white,
      child: TabBar(
          isScrollable: true,
          indicatorColor: SHFColors.primary,
          unselectedLabelColor: SHFColors.darkGrey,
          labelColor: SHFHelperFunctions.isDarkMode(context)
              ? SHFColors.white
              : SHFColors.primary,
          tabs: tabs
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SHFDeviceUtils.getAppBarHeight());
}
