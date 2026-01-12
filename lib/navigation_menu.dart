import 'package:flutter/foundation.dart';
import 'package:flutter_app_boilerplate/features/home/screens/home_screen.dart';
import 'package:flutter_app_boilerplate/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_app_boilerplate/utils/constants/sizes.dart';
import 'utils/constants/colors.dart';
import 'utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = RHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBarTheme(
            data: NavigationBarThemeData(
              labelPadding: EdgeInsets.zero,
              labelTextStyle: WidgetStateProperty.all(
                const TextStyle(fontSize: 11), //  smaller label text
              ),
              iconTheme: WidgetStateProperty.all(
                const IconThemeData(size: 19), //  smaller icon size
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: kIsWeb ? RSizes.lg : 0),
              child: NavigationBar(
                  labelPadding: EdgeInsets.zero,
                  height: 90,
                  elevation: 0,
                  selectedIndex: controller.selectedIndex.value,
                  onDestinationSelected: (index) =>
                      controller.selectedIndex.value = index,
                  backgroundColor: darkMode ? RColors.black : Colors.white,
                  indicatorColor: darkMode
                      ? RColors.white.withAlpha(26)
                      : RColors.black.withAlpha(26),
                  destinations: const [
                    NavigationDestination(
                        icon: Icon(Iconsax.home), label: 'Home'),
                    // Provide at least two destinations to satisfy NavigationBar's
                    // requirement. The second destination is a placeholder
                    // and can be replaced with real screens later.
                    NavigationDestination(
                        icon: Icon(Icons.person), label: 'More'),
                  ]),
            ),
          )),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    // Placeholder second screen for the 'More' tab
    const Center(child: Text('More')),
  ];

  void moveToPage(int index) {
    selectedIndex.value = index;
    Get.toNamed(RRouteHelper.navigationMenu);
  }
}
