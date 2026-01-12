import 'package:flutter_app_boilerplate/common/controller/filter_controller.dart';
import 'package:flutter_app_boilerplate/common/widgets/filter/widgets/filter_date.dart';
import 'package:flutter_app_boilerplate/common/widgets/filter/widgets/filter_stattus.dart';
import 'package:flutter_app_boilerplate/common/widgets/filter/widgets/filter_type_widget.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class RFilterContent extends StatelessWidget {
  const RFilterContent({
    super.key,
    this.useType = false,
    required this.onPressed,
  });
  final bool useType;
  final Callback onPressed;
  @override
  Widget build(BuildContext context) {
    FilterController filterController = FilterController.instance;
    List choices = ['Success', 'Processing', 'Cancelled'];
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// status
          RFilterWidgetStatus(
              choices: choices, statusPicked: filterController.statusPicked),
          const SizedBox(
            height: RSizes.spaceBtwItems,
          ),

          /// date
          RDateFilterWidget(dateController: filterController),
          const SizedBox(
            height: RSizes.spaceBtwItems,
          ),
          if (useType) const RFilterTypeWidget(),

          const SizedBox(
            height: RSizes.spaceBtwSections,
          ),

          /// submit button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: onPressed, child: const Text('Filter'))),
          const SizedBox(
            height: RSizes.spaceBtwSections * 2,
          ),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: RColors.error),
              ),
            ),
          )
        ]);
  }
}
