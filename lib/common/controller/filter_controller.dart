import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();
  //variables
  Rx statusPicked = 'All'.obs;
  Rx fromDate = DateTime.now().obs; // Observed variable to hold the date
  Rx fromTime = TimeOfDay.now().obs;
  Rx toTime = TimeOfDay.now().obs;
  Rx toDate = DateTime.now().obs;
  Rx groupValue = 'All'.obs;

  @override
  void onInit() {
  statusPicked.value = 'All';
   fromDate.value = DateTime.now(); // Observed variable to hold the date
   fromTime.value = TimeOfDay.now();
   toTime.value = TimeOfDay.now();
   toDate.value = DateTime.now();
   groupValue.value = 'All';
    // : implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    //  implement onClose
    statusPicked.value = 'All';
   fromDate.value = DateTime.now(); // Observed variable to hold the date
   fromTime.value = TimeOfDay.now();
   toTime.value = TimeOfDay.now();
   toDate.value = DateTime.now();
   groupValue.value = 'All';
    super.onClose();
  }
}
