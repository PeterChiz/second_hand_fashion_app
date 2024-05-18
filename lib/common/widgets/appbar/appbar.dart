import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/device/device_utility.dart';
import 'package:second_hand_fashion_app/utils/helpers/helper_functions.dart';

class SHFAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Thanh ứng dụng tùy chỉnh để đạt được một mục tiêu thiết kế mong muốn.
  /// - Đặt [title] cho một tiêu đề tùy chỉnh.
  /// - [showBackArrow] để chuyển đổi hiển thị mũi tên quay lại.
  /// - [leadingIcon] cho một biểu tượng dẫn đầu tùy chỉnh.
  /// - [leadingOnPressed] gọi lại cho sự kiện nhấn biểu tượng dẫn đầu.
  /// - [actions] để thêm một danh sách các tiện ích hành động.
  /// - Lề ngang của thanh ứng dụng có thể được tùy chỉnh bên trong tiện ích này.
  const SHFAppBar(
      {super.key,
        this.title,
        this.showBackArrow = false,
        this.leadingIcon,
        this.actions,
        this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = SHFHelperFunctions.isDarkMode(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: SHFSizes.md),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: showBackArrow
              ? IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Iconsax.arrow_left, color: dark ? SHFColors.white : SHFColors.dark,))
              : leadingIcon != null
              ? IconButton(
              onPressed: leadingOnPressed, icon: Icon(leadingIcon))
              : null,
          title: title,
          actions: actions,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(SHFDeviceUtils.getAppBarHeight());
}
