import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_app_boilerplate/utils/constants/app_constants.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyObserver extends GetObserver {
  final box = GetStorage();

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute?.settings.name != null) {
      // 👇 navigate using the route name
      Get.toNamed(previousRoute!.settings.name!);
      box.write(RAppConstants.lastRoute, previousRoute.settings.name);
    }
    // debugPrint("Back navigation detected: ${route.settings.name} → ${previousRoute?.settings.name}");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      box.write(RAppConstants.lastRoute, route.settings.name);
    }
    //debugPrint("Navigated to: ${route.settings.name}");
  }
}
