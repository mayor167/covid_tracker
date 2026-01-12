import 'package:flutter_app_boilerplate/common/controller/filter_controller.dart';
import 'package:flutter_app_boilerplate/common/widgets/filter/widgets/filter_types_widget.dart';
import 'package:flutter_app_boilerplate/common/widgets/text/item_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RFilterTypeWidget extends StatelessWidget {
  const RFilterTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FilterController controller = FilterController.instance;
    Rx groupValue = controller.groupValue;
    List types = ['In', 'Out'];
    return Column(
      children: [
        const RItemHeading(title: 'Type'),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...types.map(
              (e) => RTypeRow(
                groupValue: groupValue,
                value: e,
              ),
            )
          ],
        )
      ],
    );
  }
}
