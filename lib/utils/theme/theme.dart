import 'package:flutter/material.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outline_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class SHFAppTheme{
  SHFAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: SHFTextTheme.lightTextTheme,
    chipTheme: SHFChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: SHFAppBarTheme.lightAppBarTheme,
    checkboxTheme: SHFCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: SHFBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SHFElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SHFOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: SHFTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: SHFTextTheme.lightTextTheme,
    chipTheme: SHFChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: SHFAppBarTheme.darkAppBarTheme,
    checkboxTheme: SHFCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: SHFBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: SHFElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: SHFOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: SHFTextFormFieldTheme.darkInputDecorationTheme,
  );
}