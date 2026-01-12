import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

rShowSelectionSheet(BuildContext context,
    {double heightFactor = 0.6, required Widget child}) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return FractionallySizedBox(
            heightFactor: heightFactor,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: RSizes.defaultSpace),
                    child: child)));
      });
}
