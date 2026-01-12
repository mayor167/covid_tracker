import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimePickerController extends GetxController {
  Rx fromDate = DateTime.now().obs; // Observed variable to hold the date
  Rx fromTime = TimeOfDay.now().obs;
  Rx toTime = TimeOfDay.now().obs;
  Rx toDate = DateTime.now().obs;

}
