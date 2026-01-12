import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app_boilerplate/common/functions/show_bottomsheet.dart';
import 'package:flutter_app_boilerplate/common/widgets/form/date_time_picker.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';

class SchedulePickerCard extends StatelessWidget {
  const SchedulePickerCard({
    super.key,
    this.dateTimeController,
    required this.selectedDateTime,
    this.label = 'Schedule Order For',
    this.icon = Icons.send_time_extension_outlined,
    this.format = 'yyyy-MM-dd hh:mm a',
    this.onChanged,
  });

  final TextEditingController? dateTimeController;
  final RxString selectedDateTime;
  final String? label;
  final IconData icon;
  final String format;
  final void Function(DateTime)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          rShowSelectionSheet(
            context,
            heightFactor: 0.4,
            child: Column(
              children: [
                Text(
                  "Select when you'd like this order to be processed. We'll automatically handle it at your chosen time.",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(
                  height: RSizes.defaultSpace,
                ),
                DateTimePickerField(
                  label: 'Schedule Date & Time',
                  controller: dateTimeController!,
                  onDateTimeSelected: (dateTime) {
                    final formatted = DateFormat(format).format(dateTime);
                    selectedDateTime.value = formatted;
                    onChanged?.call(dateTime);
                    Get.back();
                  },
                ),
              ],
            ),
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
                      '$label: ',
                      style: Theme.of(context).textTheme.labelSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      selectedDateTime.value,
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
