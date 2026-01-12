import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RProgressiveLoader {
  static hideLoader() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static showloader({required locationHeight}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          top: RSizes.defaultSpace,
          left: RSizes.defaultSpace,
          right: RSizes.defaultSpace,
          bottom: locationHeight),
      content: const LinearProgressIndicator(
        color: RColors.primary,
      ),
    ));
  }
  // const RProgressiveLoader({super.key, required this.topPadding});
  // final double topPadding;

  // @override
  // Widget build(BuildContext context) {
  //   bool dark = RHelperFunctions.isDarkMode(context);
  //   return Scaffold(
  //     backgroundColor: dark
  //         ? RColors.darkContainer
  //         : RColors.lightContainer,
  //     body: Padding(
  //       padding: EdgeInsets.only(top: topPadding),
  //       child: const LinearProgressIndicator(
  //         color: RColors.primary,
  //       ),
  //     ),
  //   );
  // }
}
