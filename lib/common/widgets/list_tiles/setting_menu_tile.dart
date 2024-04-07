import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';

class SHFSettingMenuTile extends StatelessWidget {
  const SHFSettingMenuTile(
      {super.key, required this.icon, required this.title, required this.subTitle, this.trailing, this.onTap});

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28,color: SHFColors.primary,),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium,),
      subtitle: Text(subTitle,style:  Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
