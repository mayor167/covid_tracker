import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_app_boilerplate/common/widgets/layouts/list_tile/history_tile_with_status.dart';


import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RWalletHistoryList extends StatelessWidget {
  const RWalletHistoryList({
    super.key,
    required this.history,
    this.itemCount,
  });

  final Rx<List<WalletHistoryModel>> history;
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RHistoryTileWithStatus(
                coinName: key.coin,
                date: key.dateInitiated,
                status: key.type,
                amount: key.amount,
                description: key.description,
                onTap: () {
                  // Get.toNamed(RRouteHelper.detailsPage,
                  //     arguments: key, parameters: {'type': 'wallet'});
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

class WalletHistoryModel {
  final String coin;
  final String dateInitiated;
  final String type;
  final String amount;
  final String description;

  WalletHistoryModel({
    required this.coin,
    required this.dateInitiated,
    required this.type,
    required this.amount,
    required this.description,
  });
}
