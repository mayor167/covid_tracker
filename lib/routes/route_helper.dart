import 'package:get/get.dart';
import 'package:flutter_app_boilerplate/routes/route_middleware.dart';
import '../navigation_menu.dart';

class RRouteHelper {
// Authenticationl
  static const String initial = "/",
      onboarding = "/onboarding-page",
      navigationMenu = "/navigationMenu-page"
;

  static List<GetPage> routes = [

    // GetPage(name: initial, page: () => const OnBoardingScreen()),
 
    GetPage(
        name: navigationMenu,
        page: () => const NavigationMenu(),
        middlewares: [TRouteMiddleware()]),

  ];
}

