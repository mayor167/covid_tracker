import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_app_boilerplate/common/widgets/layouts/list_tile/history_tile_with_status.dart';


import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RWithdrawalHistoryList extends StatelessWidget {
  const RWithdrawalHistoryList({
    super.key,
    required this.history,
    this.itemCount,
  });

  final Rx<List<WithdrawalHistoryModel>> history;
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
          final item = histories[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RHistoryTileWithStatus(
                date: item.dateInitiated,
                status: item.status,
                amount: item.amount,
                description: "Withdrawal into ${item.bankDetails}",
                onTap: () {},
                // Get.toNamed(RRouteHelper.detailsPage,
                //     arguments: item, parameters: {'type': 'withdrawal'}),
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

class WithdrawalHistoryModel {
  final String dateInitiated;
  final String status;
  final String amount;
  final String bankDetails;

  WithdrawalHistoryModel({
    required this.dateInitiated,
    required this.status,
    required this.amount,
    required this.bankDetails,
  });
}
