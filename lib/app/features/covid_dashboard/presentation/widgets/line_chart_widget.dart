import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/historical_model.dart';
import '../../../../core/utils/date_formatter.dart';

/// Displays a line chart of daily new COVID-19 cases over the last 7 days.
///
/// The chart uses fl_chart's [LineChart] under the hood. Data points come from
/// [HistoricalModel.last7Days], where each entry is a (date, newCases) pair.
///
/// Visual choices:
///   - Curved line with a subtle filled area beneath it for depth.
///   - Dots on each data point so individual days are easy to read.
///   - Y-axis uses compact notation ("120K" instead of "120,000") to save space.
///   - X-axis shows abbreviated dates ("Apr 10", "Apr 11", etc.).
class DailyLineChart extends StatelessWidget {
  final HistoricalModel data;

  const DailyLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final days = data.last7Days;

    // Find the peak value so we can add 20% headroom on the Y axis
    final maxY =
        days.map((d) => d.newCases.toDouble()).reduce((a, b) => a > b ? a : b);

    // Convert our DailyData list into FlSpot points (x = index, y = cases)
    final spots = List.generate(
      days.length,
      (i) => FlSpot(i.toDouble(), days[i].newCases.toDouble()),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart title
            const Padding(
              padding: EdgeInsets.only(left: 8, bottom: 16),
              child: Text('Daily New Cases — Last 7 Days',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            ),

            // The chart itself
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: maxY * 1.2, // 20% breathing room above the peak
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    // Y-axis: compact numbers on the left
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 48,
                        getTitlesWidget: (val, meta) => Text(
                          NumberFormat.compact().format(val),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    // X-axis: short date labels at the bottom
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (val, meta) {
                          final idx = val.toInt();
                          if (idx < 0 || idx >= days.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              DateFormatter.shortDate(days[idx].date),
                              style: const TextStyle(fontSize: 9),
                            ),
                          );
                        },
                      ),
                    ),
                    // Hide the top and right axes — we don't need them
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: const Color(0xFF1565C0),
                      barWidth: 2.5,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, pct, bar, idx) =>
                            FlDotCirclePainter(
                          radius: 3.5,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: const Color(0xFF1565C0),
                        ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        // Gradient fill fading toward the bottom for depth
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x281565C0), // 16% opacity at top
                            Color(0x041565C0), // near-transparent at bottom
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
