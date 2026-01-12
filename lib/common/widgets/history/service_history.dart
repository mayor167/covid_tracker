import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_app_boilerplate/common/widgets/layouts/list_tile/history_tile_with_status.dart';

import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/helpers/functions.dart';

class ServiceHistory<T> extends StatelessWidget {
  const ServiceHistory({
    super.key,
    required this.history,
    this.itemCount,
    this.type = 'Data',
    required this.getService,
    required this.getDescription,
    required this.getDate,
    required this.getStatus,
    required this.getAmount,
  });

  final Rx<List<T>> history;
  final int? itemCount;
  final String type;
  final String Function(T) getService;
  final String Function(T) getDescription;
  final String Function(T) getDate;
  final String Function(T) getStatus;
  final String Function(T) getAmount;

  @override
  Widget build(BuildContext context) {
    var histories = history.value;
    // print("Histories: $histories");
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
                historyType: type,
                networkName:
                    extractNetworkName(getService(item)).capitalizeFirst ?? '',
                date: getDate(item),
                status: getStatus(item),
                amount: getAmount(item),
                description: getDescription(item),
                onTap: () {
                  // Get.toNamed(RRouteHelper.detailsPage,
                  //     arguments: item,
                  //     parameters: {'type': type.toLowerCase()});
                },
              ),
              // show divider if there's more history
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
