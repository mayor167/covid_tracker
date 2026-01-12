import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app_boilerplate/utils/constants/colors.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';

class DateTimePickerField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime)? onDateTimeSelected;

  const DateTimePickerField({
    super.key,
    required this.label,
    required this.controller,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateTimeSelected,
  });

  @override
  State<DateTimePickerField> createState() => _DateTimePickerFieldState();
}

class _DateTimePickerFieldState extends State<DateTimePickerField> {
  Future<void> _selectDateTime(BuildContext context) async {
    DateTime now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? now,
      firstDate: widget.firstDate ?? now,
      lastDate: widget.lastDate ?? DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.fromDateTime(widget.initialDate ?? now),
      );

      if (pickedTime != null) {
        final selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        widget.controller.text =
            DateFormat('yyyy-MM-dd hh:mm a').format(selectedDateTime);

        if (widget.onDateTimeSelected != null) {
          widget.onDateTimeSelected!(selectedDateTime);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: const Icon(Icons.schedule),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RSizes.newtworkSelectRadius),
          borderSide: const BorderSide(color: RColors.primary),
        ),
      ),
      onTap: () => _selectDateTime(context),
    );
  }
}
