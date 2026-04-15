import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/global_stats_model.dart';

/// Donut (ring) chart showing the distribution of Active, Recovered, and Deaths.
///
/// This gives users an at-a-glance sense of how COVID cases break down globally.
/// The chart uses fl_chart's [PieChart] with a hollow centre (hence "donut"),
/// and each slice is paired with a legend entry that shows both the count and
/// the percentage.
class DistributionDonutChart extends StatelessWidget {
  final GlobalStatsModel stats;

  const DistributionDonutChart({super.key, required this.stats});

  // Consistent colour coding used across the dashboard
  static const _activeColor = Color(0xFFFFA726);    // amber
  static const _recoveredColor = Color(0xFF66BB6A);  // green
  static const _deathsColor = Color(0xFFEF5350);     // red

  @override
  Widget build(BuildContext context) {
    final total = stats.active + stats.recovered + stats.deaths;

    // Helper to turn a raw count into a percentage string like "42.1%"
    String pct(int val) => '${(val / total * 100).toStringAsFixed(1)}%';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Case Distribution',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            const SizedBox(height: 12),

            Row(
              children: [
                // The donut chart on the left
                SizedBox(
                  height: 140,
                  width: 140,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 48, // hollow centre = donut shape
                      sectionsSpace: 2,       // small gap between slices
                      sections: [
                        PieChartSectionData(
                          value: stats.active.toDouble(),
                          color: _activeColor,
                          radius: 32,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: stats.recovered.toDouble(),
                          color: _recoveredColor,
                          radius: 32,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: stats.deaths.toDouble(),
                          color: _deathsColor,
                          radius: 32,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Legend entries on the right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Legend(
                          color: _activeColor,
                          label: 'Active',
                          count: stats.active,
                          pct: pct(stats.active)),
                      const SizedBox(height: 12),
                      _Legend(
                          color: _recoveredColor,
                          label: 'Recovered',
                          count: stats.recovered,
                          pct: pct(stats.recovered)),
                      const SizedBox(height: 12),
                      _Legend(
                          color: _deathsColor,
                          label: 'Deaths',
                          count: stats.deaths,
                          pct: pct(stats.deaths)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A single row in the chart legend: coloured dot + label + count + percentage.
class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  final int count;
  final String pct;

  const _Legend({
    required this.color,
    required this.label,
    required this.count,
    required this.pct,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Colour indicator dot
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w500)),
              Text('${NumberFormat.compact().format(count)} ($pct)',
                  style:
                      TextStyle(fontSize: 10, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    );
  }
}
