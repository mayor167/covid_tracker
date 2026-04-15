import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'covid_tracker_app/core/theme/app_theme.dart';
import 'covid_tracker_app/bindings/covid_binding.dart';
import 'covid_tracker_app/features/covid_dashboard/presentation/views/dashboard_view.dart';

/// Application entry point.
///
/// We bootstrap the app here and hand off to GetMaterialApp, which gives us
/// reactive state management and dependency injection out of the box via GetX.
void main() {
  runApp(const CovidApp());
}

/// Root widget for the COVID-19 Tracker application.
///
/// Sets up the Material theme, registers all dependencies through [CovidBinding],
/// and launches directly into the [DashboardView] as the home screen.
class CovidApp extends StatelessWidget {
  const CovidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'COVID-19 Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // CovidBinding wires up Repository -> UseCase -> Controller before the view loads
      initialBinding: CovidBinding(),
      home: const DashboardView(),
    );
  }
}