import 'package:flutter_app_boilerplate/navigation_menu.dart';
import 'package:flutter_app_boilerplate/utils/network/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(NavigationController());
  }
}
