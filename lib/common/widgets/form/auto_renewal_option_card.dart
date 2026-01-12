import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app_boilerplate/common/functions/select_bottomsheet.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';

class AutoRenewalOptionCard extends StatelessWidget {
  const AutoRenewalOptionCard({
    super.key,
    required this.title,
    required this.items,
    required this.selectedValue,
    required this.displayText,
    required this.onSelected,
    this.labelPrefix = '',
    this.icon = Icons.list_alt_outlined,
  });

  final String title;
  final Map<String, String> items;
  final RxString selectedValue;
  final RxString displayText;
  final String labelPrefix;
  final IconData icon;
  final void Function(String key, String value) onSelected;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          showSelectionSheet(
            title: title,
            items: items,
            selected: selectedValue.value,
            onSelected: (key, value) {
              onSelected(key, value);
              selectedValue.value = value;
              displayText.value = value;
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(RSizes.sm),
          decoration: BoxDecoration(
            color:
                Get.isDarkMode ? RColors.darkContainer : RColors.lightContainer,
            borderRadius: BorderRadius.circular(RSizes.sm),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: RColors.primary,
                size: RSizes.iconXm,
              ),
              const SizedBox(width: RSizes.sm),
              Flexible(
                child: Row(
                  children: [
                    Text(
                      labelPrefix,
                      style: Theme.of(context).textTheme.labelSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      displayText.value,
                      style: Theme.of(context).textTheme.labelSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
