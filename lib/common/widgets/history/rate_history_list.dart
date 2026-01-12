import 'package:flutter_app_boilerplate/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter_app_boilerplate/common/widgets/layouts/list_tile/single_line_history_tile.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RRateHistoryList extends StatelessWidget {
  const RRateHistoryList({
    super.key,
    required this.history,
    this.itemCount,
  });

  final RxList history;
  final int? itemCount;

  double extractRate(String rate) {
    // Use a regular expression to extract numeric parts and parse to double
    final numericString = rate.replaceAll(RegExp(r'[^0-9]'), '');
    return double.tryParse(numericString) ?? 0.0;
  }

  Color determineColor(String comment) {
    if (comment == 'UP') {
      return RColors.success;
    } else if (comment == 'DOWN') {
      return RColors.error;
    } else {
      return Get.isDarkMode ? RColors.white : RColors.black;
    }
  }

  Color determineIconBackground(String comment) {
    if (comment == 'UP') {
      return RColors.success;
    } else if (comment == 'DOWN') {
      return RColors.error;
    } else {
      return RColors.black;
    }
  }

  IconData determineIcon(String comment) {
    if (comment == 'UP') {
      return Icons.arrow_upward;
    } else if (comment == 'DOWN') {
      return Icons.arrow_downward;
    } else {
      return Icons.arrow_upward;
    }
  }

  @override
  Widget build(BuildContext context) {
    RHelperFunctions.isDarkMode(context);
    return RRoundedContainer(
      backgroundColor: Get.isDarkMode ? RColors.dark : RColors.lightGrey,
      padding: const EdgeInsets.symmetric(
          horizontal: RSizes.sm, vertical: RSizes.sm),
      radius: RSizes.sm,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: itemCount ?? history.length,
        itemBuilder: (context, index) {
          final currentItem = history[index];

          // Determine colors and icon based on rate comparison
          final amountColor = determineColor(currentItem.comment);
          // ignore: unused_local_variable
          final iconBackgroundColor =
              determineIconBackground(currentItem.comment);
          final icon = determineIcon(currentItem.comment);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RSingleLineHistoryTile(
                icon: icon,
                amount: currentItem.price,
                amountColor: amountColor,
                date: currentItem.date,
                // iconBackgroundColor: iconBackgroundColor,
                iconBackgroundColor: RColors.black,
                onTap: () {},
              ),
              if (index != (itemCount ?? history.length) - 1)
                const Divider(thickness: 0.6),
            ],
          );
        },
      ),
    );
  }
}
