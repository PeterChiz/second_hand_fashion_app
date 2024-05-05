import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';

class SHFChipTheme{
  SHFChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: SHFColors.white,
    selectedColor: SHFColors.primary,
    disabledColor: SHFColors.grey.withOpacity(0.4),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: const TextStyle(color: SHFColors.black, fontFamily: 'Poppins'),
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    checkmarkColor: SHFColors.white,
    selectedColor: SHFColors.primary,
    disabledColor: SHFColors.darkerGrey,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: SHFColors.white, fontFamily: 'Poppins'),
  );
}