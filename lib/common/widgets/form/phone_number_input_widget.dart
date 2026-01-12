import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/validators/validation.dart';

class PhoneNumberInputWidget extends StatelessWidget {
  const PhoneNumberInputWidget(
      {super.key,
      required this.controller,
      this.useLabel = true,
      this.useSuffix = false});

  final TextEditingController controller;
  final bool useLabel;
  final bool useSuffix;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      maxLength: 11,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      buildCounter: (context,
              {required int currentLength,
              required bool isFocused,
              required int? maxLength}) =>
          null,
      validator: (value) => RValidator.validatePhoneNumber(value),
      decoration: InputDecoration(
        hintText: 'Enter Phone Number',
        prefixIcon: const Icon(
          Icons.call_outlined,
          size: RSizes.iconMd,
          color: RColors.primary,
        ),
        label: useLabel
            ? Text(
                'Phone Number',
                style: Theme.of(context).textTheme.labelSmall,
              )
            : null,
        suffixIcon: null,
        contentPadding: const EdgeInsets.all(RSizes.xs),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
          borderSide: const BorderSide(color: RColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
          borderSide: const BorderSide(color: RColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
          borderSide: const BorderSide(color: Colors.orange, width: 1),
        ),
        filled: true,
        fillColor: Get.isDarkMode ? RColors.black : RColors.white,
      ),
      // onChanged: onPhoneNumberChanged,
    );
  }
}
