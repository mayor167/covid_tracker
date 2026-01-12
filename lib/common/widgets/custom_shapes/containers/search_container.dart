import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class RSearchContainer extends StatelessWidget {
  const RSearchContainer(
      {super.key,
      required this.text,
      this.icon = Iconsax.search_normal,
      this.showBackground = true,
      this.showBorder = true,
      this.padding =
          const EdgeInsets.symmetric(horizontal: RSizes.defaultSpace),
      required this.onPressed});

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;
  final Callback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: Container(
          width: RDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(RSizes.md),
          decoration: BoxDecoration(
              color: showBackground
                  ? dark
                      ? RColors.dark
                      : RColors.light
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(RSizes.cardRadiusLg),
              border: showBorder ? Border.all(color: RColors.grey) : null),
          child: Row(children: [
            Icon(
              icon,
              color: RColors.grey,
            ),
            const SizedBox(
              width: RSizes.spaceBtwItems,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ]),
        ),
      ),
    );
  }
}
