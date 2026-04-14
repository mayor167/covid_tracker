import 'package:get/get.dart';
import '../../../core/exceptions/covid_exception.dart';
import '../../../core/error/error_handler.dart';
import '../models/global_stats_model.dart';
import '../models/historical_model.dart';
import '../../../domain/covid_use_case.dart';

/// The four states the dashboard can be in at any given moment.
/// The view switches its layout based on whichever state is current.
enum DashboardState { idle, loading, success, error }

/// Reactive controller that drives the COVID Dashboard UI.
///
/// Responsibilities:
///   - Kicks off data fetching when the view first loads ([onInit]).
///   - Manages loading / success / error states so the view can react.
///   - Exposes [globalStats] and [historical] as observables — the view
///     rebuilds automatically whenever these change.
///   - Provides [fetchData] as a public method so the refresh button and
///     pull-to-refresh can both trigger a reload.
///
/// Error handling:
///   The repository throws typed [CovidException] subtypes. We catch them here
///   and pass them through [ErrorHandler.toUserMessage] so the UI only ever
///   sees clean, user-friendly strings — never raw stack traces or HTTP codes.
class CovidController extends GetxController {
  final CovidUseCase _useCase;

  CovidController(this._useCase);

  // Observable state the view watches via Obx()
  final state = DashboardState.idle.obs;
  final errorMessage = ''.obs;
  final globalStats = Rxn<GlobalStatsModel>();
  final historical = Rxn<HistoricalModel>();

  @override
  void onInit() {
    super.onInit();
    fetchData(); // load data as soon as the controller is created
  }

  /// Fetches both global stats and historical data in parallel.
  ///
  /// Using [Future.wait] means both requests fly at the same time,
  /// so the user waits for the slower of the two — not the sum of both.
  ///
  /// All three trigger points (app boot, refresh button, pull-to-refresh)
  /// funnel through this single method, so error handling is consistent
  /// regardless of how the user initiates a data refresh.
  Future<void> fetchData() async {
    try {
      state.value = DashboardState.loading;
      errorMessage.value = '';

      // Fire both API calls simultaneously
      final results = await Future.wait([
        _useCase.getGlobalStats(),
        _useCase.getHistorical(),
      ]);

      globalStats.value = results[0] as GlobalStatsModel;
      historical.value = results[1] as HistoricalModel;
      state.value = DashboardState.success;
    } on CovidException catch (e) {
      // Typed exception from the repository — map to a user-friendly message
      errorMessage.value = ErrorHandler.toUserMessage(e);
      state.value = DashboardState.error;
    } catch (_) {
      // Safety net: anything we didn't anticipate still gets a clean message
      errorMessage.value =
          ErrorHandler.toUserMessage(const UnknownException());
      state.value = DashboardState.error;
    }
  }
}
