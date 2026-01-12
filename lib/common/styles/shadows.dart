import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class RSpacingStyle {

  static final verticalProductShadow = BoxShadow(
    color: RColors.darkerGrey.withAlpha(26),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );


  static final horizeontalProductShadow = BoxShadow(
    color: RColors.darkerGrey.withAlpha(26),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );

}