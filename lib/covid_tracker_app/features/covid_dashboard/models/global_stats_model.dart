/// Represents a snapshot of worldwide COVID-19 statistics.
///
/// Parsed from the disease.sh `/v3/covid-19/all` endpoint.
/// We only keep the fields the dashboard actually displays —
/// total cases, active, recovered, deaths, and the timestamp.
class GlobalStatsModel {
  final int cases;
  final int active;
  final int recovered;
  final int deaths;
  final DateTime updated;

  const GlobalStatsModel({
    required this.cases,
    required this.active,
    required this.recovered,
    required this.deaths,
    required this.updated,
  });

  /// Builds a [GlobalStatsModel] from the raw JSON map returned by disease.sh.
  ///
  /// The API sends the update timestamp as Unix milliseconds, so we convert it
  /// to a proper [DateTime] here at the boundary.
  factory GlobalStatsModel.fromJson(Map<String, dynamic> json) {
    return GlobalStatsModel(
      cases: json['cases'] as int,
      active: json['active'] as int,
      recovered: json['recovered'] as int,
      deaths: json['deaths'] as int,
      updated: DateTime.fromMillisecondsSinceEpoch(json['updated'] as int),
    );
  }
}
