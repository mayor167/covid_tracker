import 'package:get/get.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BottomBarButton2 extends StatelessWidget {
  const BottomBarButton2(
      {super.key,
      this.onPressed,
      this.text,
      this.child,
      this.isSuccess = false});

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(RSizes.lg),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            side: BorderSide.none,
            backgroundColor: RColors.primary,
            foregroundColor: Get.isDarkMode ? RColors.black : RColors.white,
            // shape: RoundedRectangleBorder(
            //   borderRadius:
            //       BorderRadius.circular(RSizes.xl), // Smooth rounded edges
            // ),
            padding: const EdgeInsets.symmetric(vertical: RSizes.md),
            elevation: 2,
          ),
          // onPressed: () {
          //   print("Hello");
          // },
          onPressed: onPressed,
          child: (child) != null
              ? child
              : Text(
                  text!,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(color: RColors.white),
                )),
    );
  }
}
