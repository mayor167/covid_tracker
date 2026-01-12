import 'package:flutter_app_boilerplate/bindings/general_bindings.dart';
import 'package:flutter_app_boilerplate/navigation_menu.dart';
import 'package:flutter_app_boilerplate/routes/route_observers.dart';
import 'package:flutter_app_boilerplate/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/route_helper.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // local storage (not needed here since we use bindings and controllers)

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: RAppTheme.lightTheme,
        darkTheme: RAppTheme.darkTheme,
        // initialRoute: RRouteHelper.initial,
        initialBinding: GeneralBindings(),
        unknownRoute: GetPage(
          transition: Transition.noTransition,
          name: '/page-not-found',
          page: () => const Center(child: Text('Page not found')),
        ),
        navigatorObservers: [
          routeObserver,
          MyObserver()
        ], // 👈 attach observers

        getPages: RRouteHelper.routes,
        home: const NavigationMenu());
  }
}
