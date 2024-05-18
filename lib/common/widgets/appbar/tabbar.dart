import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/utils/device/device_utility.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

/// Tiện ích thanh tab tùy chỉnh với giao diện có thể tùy chỉnh.
class SHFTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Hàm tạo mặc định cho SHFTabBar.
  ///
  /// Tham số:
  ///   - tabs: Danh sách các tiện ích biểu diễn các tab.
  const SHFTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? SHFColors.black : SHFColors.white, // Màu nền của thanh tab
      child: TabBar(
        tabs: tabs, // Danh sách tab
        isScrollable: true, // Cho phép các tab có thể cuộn
        indicatorColor: SHFColors.primary, // Màu của chỉ báo tab
        labelColor: dark ? SHFColors.white : SHFColors.primary, // Màu của nhãn tab đã chọn
        unselectedLabelColor: SHFColors.darkGrey, // Màu của nhãn tab chưa được chọn
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SHFDeviceUtils.getAppBarHeight()); // Kích thước ưa thích của thanh tab
}

