import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';

class PasswordField extends StatelessWidget {
  const PasswordField(
      {super.key,
      required this.prefixIcon,
      required this.labelText,
      this.keyboardType = TextInputType.none,
      this.maxLength = 50,
      this.controller,
      this.validator});

  final IconData prefixIcon;
  final String labelText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);
    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (context, isObscured, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isObscured,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          buildCounter: (context,
                  {required int currentLength,
                  required bool isFocused,
                  required int? maxLength}) =>
              null,
          decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: RColors.primary,
              size: RSizes.iconXxm,
            ),
            label: Text(
              labelText,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            // labelText: labelText,
            suffixIcon: IconButton(
              icon: Icon(isObscured ? Iconsax.eye : Iconsax.eye_slash),
              onPressed: () {
                obscureText.value = !obscureText.value; // Toggle obscureText
              },
              iconSize: RSizes.iconXxm,
            ),
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
      },
    );
  }
}
