import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/device/device_utility.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';

class RAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.onDispose,
    this.centerTitle = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? onDispose;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    //final isPhysicalDevice = RDeviceUtils.isPhysicalDevice;

    return Container(
      padding: const EdgeInsets.only(
          right: RSizes.md, left: RSizes.md, top: kIsWeb ? RSizes.lg : 0),
      child: AppBar(
        centerTitle: centerTitle,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: leadingOnPressed ??
                    () {
                      if (onDispose != null) onDispose!();

                      Get.back();
                    },
                icon: Icon(
                  Iconsax.arrow_left,
                  color: dark ? RColors.white : RColors.dark,
                ),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon),
                    color: dark ? RColors.white : RColors.dark,
                  )
                : null,
        title: title,
        titleSpacing: 0,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(RDeviceUtils.getAppBarHeight());
}
