import 'package:get/get.dart';
import '../data/repositories/covid_repository.dart';
import '../domain/covid_use_case.dart';
import '../features/covid_dashboard/controllers/covid_controller.dart';

/// Dependency-injection binding for the COVID Dashboard feature.
///
/// GetX calls this before the [DashboardView] is built, so every dependency
/// is ready by the time the UI needs it. We use [lazyPut] so objects are only
/// created when first accessed — keeps startup snappy.
///
/// Injection order:
///   1. [CovidRepository]  – handles raw HTTP calls to disease.sh
///   2. [CovidUseCase]     – business-logic layer that talks to the repository
///   3. [CovidController]  – reactive controller the view observes
class CovidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CovidRepository());
    Get.lazyPut(() => CovidUseCase(Get.find()));
    Get.lazyPut(() => CovidController(Get.find()));
  }
}
