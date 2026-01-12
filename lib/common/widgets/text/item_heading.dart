import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/sizes.dart';

class RItemHeading extends StatelessWidget {
  const RItemHeading({
    super.key,
    this.textColor,
    this.showActionButton = false,
    required this.title,
    this.buttonTitle = 'View all',
    this.onPressed,
    this.padding,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final EdgeInsets? padding;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.apply(
                color: textColor ??
                    (Get.isDarkMode ? RColors.darkGrey : RColors.darkerGrey)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (showActionButton)
            TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.only(right: RSizes.md),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(buttonTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .apply(color: textColor)))
        ],
      ),
    );
  }
}
