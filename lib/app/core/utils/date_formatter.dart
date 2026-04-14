import 'package:intl/intl.dart';

/// Thin wrapper around [DateFormat] to keep date-string logic consistent
/// across the dashboard (chart labels, "last updated" timestamps, etc.).
class DateFormatter {
  DateFormatter._(); // prevent instantiation

  /// Short label for chart axes — e.g. "Apr 14".
  static String shortDate(DateTime date) => DateFormat('MMM d').format(date);

  /// Longer format for the "Updated" timestamp — e.g. "Apr 14, 2026".
  static String fullDate(DateTime date) =>
      DateFormat('MMM d, yyyy').format(date);
}
