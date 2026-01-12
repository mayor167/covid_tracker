import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RElevatedButton extends StatelessWidget {
  const RElevatedButton(
      {super.key,
      this.width = double.infinity,
      this.height = 50,
      this.radius = 50,
      this.backgroundColor = Colors.transparent,
      this.textColor,
      required this.text,
      required this.onPressed,
      this.useBorder = true,
      this.textStyle});

  final double width, height, radius;
  final Color? backgroundColor, textColor;
  final String text;

  final bool useBorder;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(
              textColor ?? (Get.isDarkMode ? RColors.white : RColors.dark)),
          backgroundColor: WidgetStateProperty.all(backgroundColor ??
              (Get.isDarkMode ? RColors.dark : RColors.light)),
          side: WidgetStateProperty.all(
            BorderSide(
                color: useBorder
                    ? RColors.secondary
                    : (backgroundColor ??
                        (Get.isDarkMode ? RColors.white : RColors.dark)),
                width: useBorder ? 1 : 0), // Set the border color and width
          ),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
              horizontal: 10, vertical: 8)), // Reduced inner padding
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(radius), // Set border radius here
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: textStyle),
      ),
    );
  }
}
