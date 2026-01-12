import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RTypeRow extends StatelessWidget {
  const RTypeRow({super.key, required this.groupValue, this.value = 'All'});

  final Rx groupValue;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => Radio(
            value: value,
            // ignore: deprecated_member_use
            groupValue: groupValue.value,
            activeColor: RColors.primary,
            // ignore: deprecated_member_use
            onChanged: (value) {
              groupValue.value = value;
            })),
        Text(value),
      ],
    );
  }
}
