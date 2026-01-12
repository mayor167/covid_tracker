import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/coin_card.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RHistoryTile extends StatelessWidget {
  const RHistoryTile(
      {super.key,
      required this.title,
      required this.subtitle,
      this.amount,
      this.subTrail,
      this.onTap,
      this.useForwardIcon = false,
      this.homeList = false,
      required this.coin});

  final String title, subtitle;
  final String? amount;
  final String? subTrail;
  final String coin;
  final bool useForwardIcon;
  final bool homeList;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: RSizes.sm),
      leading: CoinCard(coinName: coin),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: homeList
          ? const Icon(Iconsax.arrow_right5)
          : (useForwardIcon
              ? const Icon(Iconsax.arrow_25)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amount ?? '',
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                          color:
                              Get.isDarkMode ? RColors.white : RColors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subTrail != null)
                      Text(
                        subTrail!,
                        style: Theme.of(context).textTheme.labelSmall!.apply(
                            color:
                                Get.isDarkMode ? RColors.white : RColors.black),
                      ),
                  ],
                )),
      onTap: onTap,
    );
  }
}
