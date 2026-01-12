import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_app_boilerplate/common/widgets/layouts/list_tile/history_tile.dart';


import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RTransactionHistoryList extends StatelessWidget {
  const RTransactionHistoryList({
    super.key,
    required this.history,
    this.itemCount,
  });

  final Rx<List<TransactionHistoryModel>> history;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    var histories = history.value;
    return RRoundedContainer(
      backgroundColor: Get.isDarkMode ? RColors.dark : RColors.lightGrey,
      padding: const EdgeInsets.symmetric(
          horizontal: RSizes.sm, vertical: RSizes.sm),
      radius: RSizes.sm,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: itemCount ?? histories.length,
        itemBuilder: (context, index) {
          final key = histories[index];
          String usdValue = (double.parse(Get.arguments.abbreviation != 'NGN'
                  ? key.usdValue
                  : key.nairaValue))
              .toStringAsFixed(2);
          final amount = Get.arguments.abbreviation != 'NGN'
              ? "\$$usdValue"
              : "₦$usdValue";
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RHistoryTile(
                coin: key.coin,
                title: "${key.coinValue} ${key.coin} received",
                subtitle: key.dateReceived,
                amount: amount,
                onTap: () {
                  // Get.toNamed(RRouteHelper.detailsPage,
                  //     arguments: key, parameters: ({'type': 'CoinList'}));
                },
              ),
              index != (itemCount ?? histories.length) - 1
                  ? const Divider(
                      thickness: 0.6,
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}

class TransactionHistoryModel {
  final String coin;
  final String coinValue;
  final String dateReceived;
  final String usdValue;
  final String nairaValue;

  TransactionHistoryModel({
    required this.coin,
    required this.coinValue,
    required this.dateReceived,
    required this.usdValue,
    required this.nairaValue,
  });
}
