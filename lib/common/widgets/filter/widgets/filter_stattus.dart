import 'package:flutter_app_boilerplate/common/widgets/chips/choice_chips.dart';
import 'package:flutter_app_boilerplate/common/widgets/text/item_heading.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RFilterWidgetStatus extends StatelessWidget {
  const RFilterWidgetStatus({
    super.key,
    required this.choices,
    required this.statusPicked,
  });

  final List choices;
  final Rx statusPicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RItemHeading(
          title: 'Status',
        ),

        const SizedBox(
          height: RSizes.spaceBtwItems,
        ),

        /// choices
        SizedBox(
          height: RSizes.spaceBtwSections * 1.5,
          child: ListView.separated(
              itemCount: choices.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(
                    width: RSizes.xs * 1.5,
                  ),
              itemBuilder: (_, index) {
                return Obx(() => GestureDetector(
                    onTap: () => statusPicked.value = choices[index],
                    child: RChoiceChip(
                        text: choices[index],
                        selected: statusPicked.value == choices[index])));
              }),
        ),
      ],
    );
  }
}
