import 'package:flutter_app_boilerplate/common/widgets/loaders/animation_loader.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///A utility class for managing a full-screen loading dialog
class RFullScreenLoader {
  ///open a full-screen loaidng dialog with a given text and animation
  ///
  ///Prarameters:
  /// - text: The text to be displayed in the loading dialog
  ///  - animation: The Lottie animation to be shown

  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (_) => PopScope(
          canPop: false,
          child: Container(
            color: RHelperFunctions.isDarkMode(Get.context!)
                ? RColors.dark
                : RColors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                // RCircularLoader(),
                RAnimationLoaderWidget(
                  text: text,
                  animation: animation,
                )
              ],
            ),
          )),
    );
  }

  ///stop the currently open loading dialog
  ///The method doesn't return anuthing
  static stopLoading() {
    Navigator.of(Get.overlayContext!)
        .pop(); //close the dialog using the navigator
  }
}
