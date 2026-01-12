import 'package:flutter_app_boilerplate/common/widgets/icons/circular_icon.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RSingleLineHistoryTile extends StatelessWidget {
  const RSingleLineHistoryTile(
      {super.key,
      required this.icon,
      required this.date,
      this.amount,
      this.onTap,
      required this.iconBackgroundColor,
      this.useForwardIcon = false,
      this.amountColor});

  final IconData icon;
  final String date;
  final String? amount;
  final Color? amountColor;
  final Color iconBackgroundColor;
  final bool useForwardIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: RSizes.sm),
      leading: RCircularIcon(
        icon: icon,
        color: RColors.light,
        backgroundColor: iconBackgroundColor,
      ),
      title: Text(
        date,
        style: Theme.of(context).textTheme.titleSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: useForwardIcon
          ? const Icon(Iconsax.arrow_25)
          : Text(
              amount!,
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: (amountColor != null)
                      ? amountColor
                      : Get.isDarkMode
                          ? RColors.white
                          : RColors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
      onTap: onTap,
    );
  }
}
