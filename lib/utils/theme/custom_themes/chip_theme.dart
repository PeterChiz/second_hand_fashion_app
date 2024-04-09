import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';

class SHFChipTheme{
  SHFChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: SHFColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: SHFColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: SHFColors.darkerGrey,
    labelStyle: TextStyle(color: Colors.white),
    selectedColor: SHFColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: SHFColors.white,
  );
}