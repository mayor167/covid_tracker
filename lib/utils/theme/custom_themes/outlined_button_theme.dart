import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';



class ROutlinedButtonTheme {
  ROutlinedButtonTheme._(); //To avoid creating instances


  static final lighROutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: RColors.dark,
      side: const BorderSide(color: RColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: RColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: RSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(RSizes.buttonRadius)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: RColors.light,
      side: const BorderSide(color: RColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: RColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: RSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(RSizes.buttonRadius)),
    ),
  );
}
