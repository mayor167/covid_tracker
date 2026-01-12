import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'package:flutter_app_boilerplate/utils/validators/validation.dart';

enum RInputActionType { contactPicker, beneficiaryPicker, custom }

class RInputField extends StatelessWidget {
  const RInputField(
      {super.key,
      required this.controller,
      this.useLabel = true,
      this.useSuffix = false,
      this.labelText = 'Phone Number',
      this.hintText = 'Enter Phone Number',
      this.keyboardType = TextInputType.phone,
      this.maxLength = 11,
      this.validator,
      this.initialValue,
      this.prefixIcon = Icons.call_outlined,
      this.suffixActionType = RInputActionType.contactPicker,
      this.onCustomSuffixTap,
      required this.focusNode});

  final TextEditingController controller;
  final bool useLabel, useSuffix;
  final String labelText, hintText;
  final TextInputType keyboardType;
  final int maxLength;
  final String? Function(String?)? validator;
  final IconData prefixIcon;
  final String? initialValue;

  final RInputActionType suffixActionType;
  final VoidCallback? onCustomSuffixTap;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    // Ensure controller text is set if initialValue exists and controller is empty
    if ((initialValue?.isNotEmpty ?? false) && controller.text.isEmpty) {
      controller.text = initialValue!;
    }

    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      buildCounter: (_,
              {required currentLength,
              required isFocused,
              required maxLength}) =>
          null,
      validator: validator ?? RValidator.validatePhoneNumber,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
          size: RSizes.iconMd,
          color: RColors.primary,
        ),
        label: useLabel
            ? Text(
                labelText,
                style: Theme.of(context).textTheme.labelSmall,
              )
            : null,
        suffixIcon: useSuffix
            ? InkWell(
                onTap: () {
                  switch (suffixActionType) {
                    case RInputActionType.contactPicker:
                      // contactsController.pickContact((formattedPhone) {
                      //   controller.text = formattedPhone;
                      // });
                      break;
                    case RInputActionType.beneficiaryPicker:
                      // Implement your beneficiary picker logic here
                      break;
                    case RInputActionType.custom:
                      if (onCustomSuffixTap != null) onCustomSuffixTap!();
                      break;
                  }
                },
                child: const Icon(
                  Icons.contacts, // You can also make this customizable later
                  size: RSizes.iconMd,
                  color: RColors.primary,
                ),
              )
            : null,
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
    );
  }
}
