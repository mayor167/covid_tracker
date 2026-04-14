import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A compact card that displays a single COVID statistic (e.g. "Active: 12.3M").
///
/// Each card shows:
///   - A colour-coded circular icon on the left
///   - The metric label ("Total Cases", "Active", etc.)
///   - The formatted value using compact notation (e.g. "704M" instead of "704,000,000")
///
/// The [color] parameter tints both the icon background and the value text,
/// making it easy to visually distinguish different metrics at a glance.
class StatsCard extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final IconData icon;

  const StatsCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // NumberFormat.compact() turns large numbers into human-friendly strings
    final formatted = NumberFormat.compact().format(value);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colour-tinted icon badge — top left for a clean vertical flow
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),

            // Bold value — the number users care about most
            Text(formatted,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: color,
                    height: 1.1)),
            const SizedBox(height: 2),

            // Subtle label beneath
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
