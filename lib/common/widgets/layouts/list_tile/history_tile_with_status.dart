import 'package:flutter_app_boilerplate/common/styles/status_color_helper.dart';
import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/coin_card.dart';
import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/gift_card_icon.dart';
import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/network_card.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class RHistoryTileWithStatus extends StatelessWidget {
  const RHistoryTileWithStatus(
      {super.key,
      required this.status,
      required this.date,
      required this.amount,
      this.onTap,
      required this.description,
      this.coinName = '',
      this.historyType,
      this.networkName = ''});

  final String status;
  final String description;
  final String date;
  final String amount;
  final VoidCallback? onTap;
  final String coinName;
  final String? historyType;
  final String networkName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: RSizes.sm),
      leading: historyType == 'Data' ||
              historyType == 'Airtime' ||
              historyType == 'CableTv'
          ? NetworkCard(networkName: networkName)
          : historyType == 'giftcard'
              ? const GiftCardIcon()
              : CoinCard(coinName: coinName),
      title: Text(
        description,
        style: Theme.of(context).textTheme.titleSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        date,
        style: Theme.of(context).textTheme.labelSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              "₦$amount",
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: RSizes.xs),
          Flexible(
            child: Text(
              status,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: RStatusColorHelper.getStatusColor(status),
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
