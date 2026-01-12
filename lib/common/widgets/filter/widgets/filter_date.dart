import 'package:flutter_app_boilerplate/common/controller/filter_controller.dart';
import 'package:flutter_app_boilerplate/common/widgets/dateTime/date.dart';
import 'package:flutter_app_boilerplate/common/widgets/text/item_heading.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RDateFilterWidget extends StatelessWidget {
  const RDateFilterWidget({
    super.key,
    required this.dateController,
  });

  final FilterController dateController;

  @override
  Widget build(BuildContext context) {
    Rx selectedDateFirst = dateController.fromDate;
    Rx selectedDateSecond = dateController.toDate;
    return Column(
      children: [
        /// date

        /// date from

        const Row(
          children: [
            Expanded(flex: 4, child: RItemHeading(title: 'From')),

            /// sspace
            SizedBox(
              height: RSizes.spaceBtwSections,
            ),

            /// to
            Expanded(flex: 4, child: RItemHeading(title: 'To')),
          ],
        ),
        // const SizedBox(
        //   height: RSizes.sm,
        // ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: RDatePicker(
                selectedDate: selectedDateFirst,
                selectedTime: dateController.fromTime,
              ),
            ),
            const SizedBox(
              height: RSizes.spaceBtwItems,
            ),
            Expanded(
              flex: 4,
              child: RDatePicker(
                selectedDate: selectedDateSecond,
                selectedTime: dateController.toTime,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
