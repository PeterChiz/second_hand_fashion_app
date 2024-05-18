import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/utils/constants/colors.dart';

class SHFShadowStyle{
  static final verticalProductShadow = BoxShadow(
    color: SHFColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}