import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RFullscreenloader {
  static void openLoadingDailog() {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: RHelperFunctions.isDarkMode(Get.context!)
                  ? RColors.dark
                  : RColors.white,
              width: double.infinity,
              height: double.infinity,
            )));
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
