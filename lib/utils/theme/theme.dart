import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';


class RAppTheme {
  RAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    disabledColor: RColors.grey,
    brightness: Brightness.light,
    primaryColor: RColors.primary,
    textTheme: RTextTheme.lighRTextTheme,
    chipTheme: RChipTheme.lighRChipTheme,
    scaffoldBackgroundColor: RColors.white,
    appBarTheme: RAppBarTheme.lighRAppBarTheme,
    checkboxTheme: RCheckboxTheme.lighRCheckboxTheme,
    bottomSheetTheme: RBottomSheetTheme.lighRBottomSheetTheme,
    elevatedButtonTheme: RElevatedButtonTheme.lighRElevatedButtonTheme,
    outlinedButtonTheme: ROutlinedButtonTheme.lighROutlinedButtonTheme,
    inputDecorationTheme: RTextFormFieldTheme.lightInputDecorationTheme
  );


  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    disabledColor: RColors.grey,
    brightness: Brightness.dark,
    primaryColor: RColors.primary,
    textTheme: RTextTheme.darkTextTheme,
    chipTheme: RChipTheme.darkChipTheme,
    scaffoldBackgroundColor: RColors.black,
    appBarTheme: RAppBarTheme.darkAppBarTheme,
    checkboxTheme: RCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: RBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: RElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: ROutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: RTextFormFieldTheme.darkInputDecorationTheme

  );
}