import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class RFormDivider extends StatelessWidget {
  const RFormDivider({
    super.key,
    required this.dividerText,  this.color,
  });

  final String dividerText;
  final Color? color;

  @override
  Widget build(BuildContext context) {
     final dark = RHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
          color: color ?? (dark ? RColors.darkGrey : RColors.grey),
          thickness: 0.5,
          indent: 60,
          endIndent: 5,
        )),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium?.apply(color: color ?? (dark ? RColors.grey : RColors.grey)),
        ),
        Flexible(
            child: Divider(
          color: color ?? (dark ? RColors.darkGrey : RColors.grey),
          thickness: 0.5,
          indent: 6,
          endIndent: 60,
        ))
      ],
    );
  }
}