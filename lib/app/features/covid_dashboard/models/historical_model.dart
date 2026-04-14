/// A single day's worth of new-case data, used to plot the line chart.
class DailyData {
  final DateTime date;
  final int newCases;

  const DailyData({required this.date, required this.newCases});
}

/// Holds the last 7 days of daily new COVID-19 cases worldwide.
///
/// Parsed from the disease.sh `/v3/covid-19/historical/all?lastdays=8` endpoint.
/// That endpoint returns *cumulative* totals keyed by date strings like "4/13/26",
/// so we need a bit of maths to convert them into daily deltas.
class HistoricalModel {
  final List<DailyData> last7Days;

  const HistoricalModel({required this.last7Days});

  /// Transforms the raw cumulative JSON into a list of 7 daily new-case values.
  ///
  /// How it works:
  ///   1. We request 8 days of data from the API.
  ///   2. For each consecutive pair of days we compute:
  ///        newCases = cumulative[day] - cumulative[day-1]
  ///   3. That gives us exactly 7 delta values — one for each of the last 7 days.
  ///
  /// The date string format from the API is "M/D/YY" (e.g. "4/13/26" for April 13 2026),
  /// so we split on "/" and reconstruct a proper [DateTime].
  factory HistoricalModel.fromJson(Map<String, dynamic> json) {
    // The API nests case data under "timeline" for country queries, but returns
    // it at the top level for the global "all" endpoint. Handle both.
    final casesMap = Map<String, int>.from(
      (json['timeline']?['cases'] ?? json['cases']) as Map,
    );

    final entries = casesMap.entries.toList();

    // Grab the last 8 entries so we can diff them into 7 daily deltas
    final recent = entries.length >= 8
        ? entries.sublist(entries.length - 8)
        : entries;

    final List<DailyData> days = [];
    for (int i = 1; i < recent.length; i++) {
      // Parse the "M/D/YY" date string
      final parts = recent[i].key.split('/');
      final date = DateTime(
        2000 + int.parse(parts[2]),
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      // Clamp to zero in case of data corrections that make a day negative
      final delta = (recent[i].value - recent[i - 1].value).clamp(0, 99999999);
      days.add(DailyData(date: date, newCases: delta));
    }

    return HistoricalModel(last7Days: days);
  }
}
