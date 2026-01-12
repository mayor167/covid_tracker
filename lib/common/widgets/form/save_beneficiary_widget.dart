import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';

class SaveBeneficiaryWidget extends StatelessWidget {
  const SaveBeneficiaryWidget(
      {super.key, this.withBackground = false, required this.controller});
  final bool withBackground;
  final RxBool controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: withBackground
            ? (Get.isDarkMode ? RColors.darkContainer : RColors.lightContainer)
            : Colors.transparent, // Light background color for the field
        borderRadius: BorderRadius.circular(RSizes.sm), // Rounded corners
      ),
      child: Row(
        children: [
          Obx(() => Theme(
                data: Theme.of(context).copyWith(
                  checkboxTheme: CheckboxThemeData(
                    side: const BorderSide(
                      color: RColors.primary, // Orange border
                      width: 2,
                    ),
                    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.selected)) {
                        return RColors.primary;
                      }
                      return Colors.transparent;
                    }),
                    checkColor: WidgetStateProperty.all(RColors.white),
                    visualDensity: VisualDensity.compact, // Makes it tighter
                    materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap, // Shrinks size
                  ),
                ),
                child: Checkbox(
                  value: controller.value,
                  onChanged: (val) => controller.value = val ?? false,
                ),
              )),
          const SizedBox(
            width: RSizes.sm / 5,
          ),
          Flexible(
            child: Text(
              'Save Beneficiary',
              style: Theme.of(context).textTheme.labelSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: RSizes.sm / 5,
          ),
        ],
      ),
    );
  }
}
