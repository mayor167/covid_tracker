import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RDatePicker extends StatelessWidget {
  const RDatePicker(
      {super.key, required this.selectedDate, required this.selectedTime});
  final Rx selectedDate, selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value, // Use current selected date
      firstDate: DateTime(2000), // Earliest date selectable
      lastDate: DateTime(2100), // Latest date selectable
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked; // Update date in controller
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Text(
                          style: Theme.of(context).textTheme.labelLarge,
                          selectedDate.value.toString().split(" ")[0]),
                    )),
                Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => _pickTime(context),
                      child: Text(
                          style: Theme.of(context).textTheme.labelLarge,
                          "  ${selectedTime.value.hour.toString().padLeft(2, '0')}: ${selectedTime.value.minute.toString().padLeft(2, '0')}"),
                    )),
              ],
            ))
      ],
    );
  }
}
