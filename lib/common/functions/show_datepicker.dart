import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

Rx selectedDate = ''.obs;

Future<void> rSelectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(), // Default to current date
    firstDate: DateTime(2000), // Earliest date
    lastDate: DateTime(2100), // Latest date
  );
  if (picked != null && picked != selectedDate.value) selectedDate.value = picked;
}
