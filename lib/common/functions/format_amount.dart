import 'package:intl/intl.dart';

String formatAmount(double amount) {
  final NumberFormat formatter = NumberFormat("#,##0", "en_US"); // Format with commas
  return formatter.format(amount).toString(); // return value
}