import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class RTapBar extends StatelessWidget implements PreferredSizeWidget {
  const RTapBar(
      {super.key,
      // this.title,
      // this.showBackArrow = false,
      // this.leadingIcon,
      required this.tabs,
 ///     this.leadingOnPressed
 });

  // final Widget? title;
  // final bool showBackArrow;
  // final IconData? leadingIcon;
  final List<Widget> tabs;
  //final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    return Container(
      color: RHelperFunctions.isDarkMode(context)
                      ? RColors.black
                      : RColors.white,

      padding: const EdgeInsets.symmetric(horizontal: RSizes.md),
      child: TabBar(
          isScrollable: true,
          indicatorColor: RColors.primary,
          labelColor: dark
              ? RColors.white
              : RColors.black,
          tabs: tabs,
          unselectedLabelColor: RColors.darkGrey,
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(RDeviceUtils.getAppBarHeight());
}
