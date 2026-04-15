import '../features/covid_dashboard/models/global_stats_model.dart';
import '../features/covid_dashboard/models/historical_model.dart';
import '../data/repositories/covid_repository.dart';

/// Business-logic layer that sits between the controller and the repository.
///
/// Right now this is a thin pass-through, but it gives us a clear seam to add
/// caching, data transformations, or offline-fallback logic later without
/// touching the UI or the repository. This is the "use case" in Clean Architecture.
class CovidUseCase {
  final CovidRepository _repository;

  CovidUseCase(this._repository);

  /// Retrieves the latest global COVID-19 statistics.
  Future<GlobalStatsModel> getGlobalStats() => _repository.fetchGlobalStats();

  /// Retrieves the historical case data for the line chart.
  Future<HistoricalModel> getHistorical() => _repository.fetchHistorical();
}
